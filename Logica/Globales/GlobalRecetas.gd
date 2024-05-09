extends Node

enum {
	CristalRGB,
	Allmetal,
	Acero,
	CristalFuego,
	CristalFrio,
	CristalAgua,
	CristalTierra
}
enum recetas {
	CristalRGB,
	Allmetal,
	Acero,
	CristalFuego,
	CristalFrio,
	CristalAgua,
	CristalTierra
}
#}
func encontrarReceta(ingredientes : Array) -> int: # NO TOCAR ESTA PORQUERIA
	if ingredientes.has(GlobalRecursos.mineralesSinFondo.Hierro) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Carbon) and ingredientes.size() == 2: # Acero (hierro + carbon)
		return Acero
	if ingredientes.has(GlobalRecursos.mineralesSinFondo.Rubi) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Zafiro) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Esmeralda): 
	# RGD Crystal (Rubi + Zafiro + Esmeralda)
		return CristalRGB
	if ingredientes.has(GlobalRecursos.mineralesSinFondo.Plata) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Hierro) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Cobre): 
		# Allmetal (Plata + Hierro + Cobre)
		return Allmetal
	if ingredientes.has(GlobalRecursos.mineralesSinFondo.Oro) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Topacio) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Rubi): 
		# Fire crystal (Oro + Topacio + Rubi)
		return CristalFuego
	if ingredientes.has(GlobalRecursos.mineralesSinFondo.Plata) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Amatista) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Zafiro): 
		# Frosty crystal (Plata + amatista + zafiro)
		return CristalFrio
	if ingredientes.has(GlobalRecursos.mineralesSinFondo.Hierro) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Zafiro) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Diamante): 
		# Water crystal (hierro + zafiro + diamante)
		return CristalAgua
	if ingredientes.has(GlobalRecursos.mineralesSinFondo.Cobre) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Topacio) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Esmeralda): 
		# Earth crystal (cobre + topacio + esmeralda)
		return CristalTierra
	return -1 # ésto es ejecutado si la receta no existe, será llamada por el horno
	
func print_receta(ingredientes : Array) -> void:
	var miReceta = encontrarReceta(ingredientes)
	print( recetas.keys()[miReceta] )
