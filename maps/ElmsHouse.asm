	object_const_def
	const ELMSHOUSE_ELMS_WIFE
	const ELMSHOUSE_ELMS_SON

ElmsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

ElmsWife:
	jumptextfaceplayer ElmsWifeText

ElmsSon:
	jumptextfaceplayer ElmsSonText

ElmsHousePC:
    checkevent EVENT_BEAT_WALLACE
    iffalse .preWallace
    jumptext ElmsHousePCPostWallaceText
.preWallace
	jumptext ElmsHousePCText

ElmsHouseBookshelf:
	jumpstd DifficultBookshelfScript

ElmsWifeText:
	text "Salut <PLAYER> !"
	para "Le prof Orme est"
	line "au labo comme"
	cont "tout le temps."

	para "Il ne croit pas"
	line "aux semaines de 4"
	cont "jours, ni même de"
	cont "5 jours."
	done

ElmsSonText:
	text "Quand je serais"
	line "grand, je"
	cont "trouverais le"
	cont "#mon le plus"
	cont "fort et je le"
	cont "capturerais !"
	para "Je battrais le"
	line "Conseil des 4 et"
	cont "je chasserais une"
	cont "organisation de"
	cont "méchants."
	done

ElmsHousePCPostWallaceText:
	text "L'Empereur Marc a"
	line "abdiqué mais sa"
	cont "localisation est"
	cont "inconnue."

	para "Le Maître Pierre"
	line "Rochard est en"
	cont "vie et a pris le"
	cont "commmendement de"
	cont "l'armée d'Hoenn."

	para "la guerre est"
	line "terminée."

	para "Tout cela grâce à"
	line "un jeune"
	cont "dresseur inconnu."

	para "Le nouveau Maître"
	line "de Johto."

	para "Maitre <PLAYER> !"

	para "Longue vie au"
	line "Maitre <PLAYER> !"
    done

ElmsHousePCText:
	text "Info secrète de"
	line "la Ligue #mon."

	para "Nos espions nous"
	line "envoient des"
	cont "nouvelles très"
	cont "inquiétantes."

	para "On pense que"
	line "l'Empereur Marc"
	cont "est aux commandes"
	cont "du #mon"
	cont "légendaire"
	cont "d'Hoenn."

	para "S'il maîtrise les"
	cont "trois forces de"
	cont "la nature."

	para "Il y a un mince"
	line "espoir de"
	cont "l'arrêter sauf si"
	cont "les Maîtres de"
	cont "toutes les autres"
	cont "régions acceptent"
	cont "de se battre."
	done

ElmsEevee:
    opentext
    writetext ElmsEeveeText
    cry EEVEE
    waitbutton
    closetext
    end

ElmsEeveeText:
    text "Evo !"
    done

ElmsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, NEW_BARK_TOWN, 4
	warp_event  3,  7, NEW_BARK_TOWN, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, ElmsHousePC
	bg_event  6,  1, BGEVENT_READ, ElmsHouseBookshelf
	bg_event  7,  1, BGEVENT_READ, ElmsHouseBookshelf

	def_object_events
	object_event  1,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ElmsWife, -1
	object_event  5,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsSon, -1
	object_event  2,  3, SPRITE_EEVEE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, ElmsEevee, -1

