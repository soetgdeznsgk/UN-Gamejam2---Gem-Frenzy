extends Node

var app_id:String;
var aes_key:String;
var auto_init: bool;

@onready var components = $Components
@onready var offline_data = $OfflineData

## will be true if user is not signed in or without internet
var offline_mode: bool = true;

var session: NewgroundsSession = NewgroundsSession.new();
var session_started: bool = false;

var signing_in: bool = false;
var signed_in : bool = false;

## Emitted when starting session/signing in/signing out
signal on_session_change(session: NewgroundsSession)

## Emitted when savedata has been uploaded/downloaded, 
## and offline scoreboards & medals have been synced
signal on_saves_synced()

signal on_signed_in();
signal on_signed_out();

var medals: Dictionary = {}
func get_medal_resource(medal_id: int) -> MedalResource:
	if medals.has(medal_id):
		return medals[medal_id];
	return null

var medal_score: int = 0; ## Stores the user's total medal score, fetched with medal_get_medal_score()
signal on_medals_loaded(medals:Array[MedalResource]);
signal on_medal_unlocked(medal_id:int);
signal on_medal_score_get(score:int);

var save_slots:Dictionary = {};
signal on_cloudsave_slots_loaded();
signal on_cloudsave_slot_loaded(slot: int);

signal on_cloudsave_set_data(slot: int);
signal on_cloudsave_get_data(slot: int);
signal on_cloudsave_cleared(slot: int);

signal on_highscore_submitted(board_id: int, score: NewgroundsScoreboardItem)

var aes = AESContext.new();

const C = preload("res://addons/newgrounds/scripts/newgrounds_consts.gd")
func _ready():
	_load_session();
	_init_medals();
	
	app_id 		= ProjectSettings.get_setting(C.APP_ID_PROPERTY, "")
	aes_key 	= ProjectSettings.get_setting(C.AES_KEY_PROPERTY, "")
	auto_init 	= ProjectSettings.get_setting(C.AUTO_INIT_PROPERTY, true);
	
	var aes_bytes = Marshalls.base64_to_raw(aes_key)
	var aes_bits = aes_bytes.size() << 3;
	
	assert(aes_bits == 256 || aes_bits == 128, "Newgrounds AES Key Required (Assign it in the project settings)")
	assert(app_id, "Newgrounds App ID Required (Assign it in the project settings)")
	
	components.init(app_id, aes_key, session)
	
	if auto_init:
		init();
	pass

func _init_medals():
	var medalMap = NewgroundsIds.MedalIdsToResource.medals;
	for medal_id in medalMap.keys():
		var medal_resource:MedalResource = load(medalMap[medal_id])
		medal_resource.unlocked = offline_data.is_medal_unlocked(medal_id)
		medals[medal_id] = medal_resource;
	pass

func _p(s):
	# print('Newgrounds.io: %s' % s)
	pass

func init():
	_p("init")
	_refresh_session()

var _retrying_signin = false
## Starts a session & launches newgrounds passport in case user
## has not logged in. If logged in, this will do nothing.
func sign_in():
	var s = await components.app_check_session().on_response
	if s.error:# == NewgroundsRequest.ERR_SESSION_CANCELLED or s.error == NewgroundsRequest.ERR_INVALID_SESSION:
		session.reset()
	if (session.is_signed_in() && !session.expired):
		return
	if (!session.passport_url.is_empty()):
		signing_in = true;
		$Pinger.start()
		OS.shell_open(session.passport_url)
	else:
		var req = _session_start()
		var res = await req.on_response
		if res.error != NewgroundsRequest.ERR_FAILED_REQUEST:
			# retry signin
			sign_in()
	pass

## Signs the user out from newgrounds.io and ends the current session
func sign_out():
	await components.app_end_session().on_response
	
	session.reset()
	session.save()
	offline_mode = true;
	signed_in = false;
	session_started = false;
	signing_in = false;
	$Pinger.stop()
	
	on_session_change.emit(session)
	on_signed_out.emit();
	pass


func _refresh_session() -> NewgroundsRequest:
	_p("refresh_session")
	var res = components.app_check_session()
	res.on_response.connect(_session_change)
	return res

## Session stuff
#############
func _session_start(force: bool = false) -> NewgroundsRequest:
	_p('Session start')
	var req = components.app_start_session()
	req.on_response.connect(_session_change)
	return req

func _session_change(data:NewgroundsResponse):
	if (data.error):
		if data.error == NewgroundsRequest.ERR_FAILED_REQUEST:
			offline_mode = true;
			_p("Offline mode: true")
			return;
		if !session_started:
			$Pinger.stop()
			_session_start()
		return
		
	var s = data.data;
	var changed = session.setFromDictionary(s)
	
	session_started = true;
	
	if (!signed_in && session.user):
		signed_in = true;
		signing_in = false;
		$Pinger.start()
		offline_mode = false;
		on_signed_in.emit()
		_sync_offline_data()
	else:
		offline_mode = !session.is_signed_in();
		
	_save_session()
	
	if changed:
		on_session_change.emit(session);
	pass
func _sync_offline_data():
	await offline_data.retry_sending_medals_and_highscores()
	on_saves_synced.emit();
	
## Scoreboards
###############
func scoreboard_get_scores(scoreboard_id: int, limit:int = 10, skip:int = 0, period: String = "D", social: bool = false, user:String = "", tag: String = "") -> Array[NewgroundsScoreboardItem]:
	var res = components.scoreboard_get_scores(scoreboard_id, limit, skip, period, social, user, tag).on_response
	if res.error:
		return []
	var score_list: Array[NewgroundsScoreboardItem] = [];
	var i = skip + 1
	for score in res.data:
		var item = NewgroundsScoreboardItem.fromDict(score)
		item.index = i
		i += 1
		score_list.push_back(item)
	return score_list;

func scoreboard_submit(scoreboard_id: int, score: int) -> NewgroundsScoreboardItem:
	var req = await components.scoreboard_post_score(scoreboard_id, score).on_response
	if req.error:
		if req.error != NewgroundsRequest.ERR_INVALID_SCOREBOARD_ID:
			offline_data.add_failed_scoreboard_post(scoreboard_id, score)
		return null
	var scr = NewgroundsScoreboardItem.fromDict(req.data)
	on_highscore_submitted.emit(scoreboard_id, scr)
	return scr;
func scoreboard_submit_time(scoreboard_id: int, seconds: float) -> NewgroundsScoreboardItem:
	return await scoreboard_submit(scoreboard_id, int(seconds * 1000.0))

## Medals
############

## Lists medals, emits on_medals_loaded
func medal_get_list(app_id: String = "") -> Array[MedalResource]:
	var is_external = app_id != "" and app_id != self.app_id;
	
	var res = await components.medal_get_list(app_id).on_response
	
	if res.error:
		if !is_external:
			return medals.values()
		print("Could not get external medals. Make sure the app ID is correct and allowed in your project settings.")
		return []
	
	var medals_list:Array[MedalResource] = [];
	var m = res.data;
	for medal in m:
		var medal_res = get_medal_resource(medal.id)
		if !medal_res:
			medal_res = MedalResource.fromDict(medal);
		else:
			medal_res.unlocked = medal.unlocked
		
		medals_list.push_back(medal_res)
		
		if is_external:
			continue
		
		if !is_external:
			medals[medal_res.id] = medal_res;
		if !medal_res.unlocked:
			var medal_status = offline_data.get_medal_unlock_state(medal_res.id);
			# Medal was unlocked on newgrounds, but was then reset
			if session.is_signed_in() and medal_status == offline_data.MedalUnlockState.UnlockedNewgrounds:
				offline_data.set_medal_unlocked(medal_res.id, false)
			else:
				medal_res.unlocked = offline_data.is_medal_unlocked(medal_res.id);
		else:
			offline_data.set_medal_unlocked(medal_res.id, true)
		
	
	if !is_external:
		on_medals_loaded.emit(medals_list)
	
	return medals_list

## Unlocks medal. emits on_medal_unlocked on success
func medal_unlock(medal_id: int, silent: bool = false) -> bool:
	if offline_mode:
		var medal = get_medal_resource(medal_id);
		if medal:
			medal.unlocked = true;
		offline_data.add_failed_medal_unlock(medal_id)
		if !silent:
			on_medal_unlocked.emit(medal_id)
		return true
	
	var res = await components.medal_unlock(medal_id).on_response
	
	if res.error:
		if res.error != NewgroundsRequest.ERR_MEDAL_NOT_FOUND:
			var medal = get_medal_resource(medal_id);
			if medal:
				medal.unlocked = true;
			offline_data.add_failed_medal_unlock(medal_id)
			if !silent:
				on_medal_unlocked.emit(medal_id)
		return false
	
	offline_data.set_medal_unlocked(medal_id, true)
	
	var m = res.data;
	var medal = get_medal_resource(medal_id);
	if medal:
		medal.unlocked = true;
	else:
		medal = MedalResource.fromDict(m);
		medals[medal.id] = medal;
	if !silent:
		on_medal_unlocked.emit(medal_id)
	return true

## Fetch the user's total score, emitted by on_medal_score_get
func medal_get_medal_score() -> int:
	var req = await components.medal_get_medal_score().on_response
	on_medal_score_get.emit(req.data)
	return req.data;

## CLoudsave stuff
func cloudsave_load_slots() -> Array[NewgroundsSaveSlot]:
	var res = await components.cloudsave_load_slots().on_response
	if res.error:
		return []
	
	var slots = res.data
	var res_array:Array[NewgroundsSaveSlot] = [];
	for s in slots:
		var slot: NewgroundsSaveSlot = _store_slot_data(s)
		res_array.push_back(slot)
	
	on_cloudsave_slots_loaded.emit()
	
	return res_array

## Saves slot data both remotely and locally.
## Returns saveslot if saved in cloud successfully, otherwise null.
func cloudsave_set_data(slot_id: int, data: String) -> NewgroundsSaveSlot:
	offline_data.store_local_slot_data(slot_id, data);
	if offline_mode:
		var slot = save_slots[slot_id]
		if slot:
			slot.data = data;
		on_cloudsave_set_data.emit(slot_id)
		return null

	var res = await components.cloudsave_set_data(slot_id, data).on_response
	
	if !res.error:
		var slot: NewgroundsSaveSlot = _store_slot_data(res.data)
		slot.data = data;
		offline_data.store_local_slot_data(slot_id, data, slot.timestamp)
		on_cloudsave_set_data.emit(slot_id)
		return slot
	
	return null
	pass

## Clears saveslot both remotely and in the local cache
## Returns true on success, otherwise false.
func cloudsave_clear_slot(slot_id: int) -> bool:
	offline_data.clear_slot_data(slot_id)
	var res = await components.cloudsave_clear_slot(slot_id).on_response
	if !res.error:
		var slot = _store_slot_data(res.data)
		slot.data = "";
		on_cloudsave_cleared.emit(slot_id);
		return true
	return false
	pass

func cloudsave_load_slot(slot_id: int) -> NewgroundsSaveSlot:
	var res = await components.cloudsave_load_slot(slot_id).on_response
	if !res.error:
		var slot = _store_slot_data(res.data)
		on_cloudsave_slot_loaded.emit(slot.id)
		return slot
	return null

func _store_slot_data(slot_data: Dictionary):
	var slot: NewgroundsSaveSlot
	if save_slots.has(slot_data.id):
		slot = save_slots[slot_data.id]
		slot.setValuesFromDict(slot_data)
	else:
		slot = NewgroundsSaveSlot.fromDict(slot_data)
	save_slots[slot.id] = slot
	return slot;

## Returns the data string from a cloudsave. Attempts to fallback to offline cache.
## Returns empty string on error or empty save.
func cloudsave_get_data(slot_id: int) -> String:
	if offline_mode:
		return offline_data.get_local_slot_data(slot_id, 0)
	
	var slot = await cloudsave_load_slot(slot_id);
	var slot_remote_timestamp = 0 if slot == null else slot.timestamp
	
	var local_save = offline_data.get_local_slot_data(slot_id, slot_remote_timestamp)
	if local_save:
		return local_save;

	if slot:
		var request = components.cloudsave_get_data(slot.url)
		var loadRes = await request.on_response
		
		if loadRes.error:
			return ''
		
		slot.data = loadRes.data
		
		offline_data.store_local_slot_data(slot.id, slot.data, slot.timestamp)
		on_cloudsave_get_data.emit(slot.id)
		
		return slot.data
	
	return ''
	
func _load_session():
	var _session_id = "";
	
	if OS.has_feature('web'):
		_session_id = str(JavaScriptBridge.eval("""
			var id = new URLSearchParams(window.location.search).get("ngio_session_id");
			id ? id : ""
		""", true))

	session.load();
	offline_data.load();
	
	if _session_id:
		session.id = _session_id;
	pass

func _save_session():
	session.save();

func _notification(what):
	match what:
		NOTIFICATION_WM_WINDOW_FOCUS_IN:
			if signing_in:
				_refresh_session.call_deferred()
			pass
	

