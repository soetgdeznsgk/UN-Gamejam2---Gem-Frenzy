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
#enum mineralesSinFondo{
	#Hierro, 0
	#Plata, 1 
	#Oro, 2
	#Carbon, 3
	#Cobre, 4
	#Amatista, 5
	#Esmeralda, 6
	#Topacio, 7
	#Rubi, 8
	#Zafiro, 9 
	#Diamante, 10
#}
func encontrarReceta(ingredientes : Array) -> int: # NO TOCAR ESTA PORQUERIA
	if ingredientes.has(GlobalRecursos.mineralesSinFondo.Hierro) and ingredientes.has(GlobalRecursos.mineralesSinFondo.Carbon): # Acero (hierro + carbon)
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
	#print("algo salio mal con el array: ", ingredientes)
	return -1 # ésto es ejecutado si la receta no existe, será llamada por el horno
	
