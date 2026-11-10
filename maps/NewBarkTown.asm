	object_const_def
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_FISHER
	const NEWBARKTOWN_RIVAL
	const NEWBARKTOWN_FIELDMON_6
	const NEWBARKTOWN_REPEL_WOMAN
	const NEWBARKTOWN_CRYSTAL
	const NEWBARKTOWN_SILVER_FINAL
	const NEWBARKTOWN_CRYSTAL_FINAL
	const NEWBARKTOWN_PIKACHU

NewBarkTown_MapScripts:
	def_scene_scripts
	scene_script NewBarkTownNoop1Scene, SCENE_NEWBARKTOWN_TEACHER_STOPS_YOU
	scene_script NewBarkTownNoop2Scene, SCENE_NEWBARKTOWN_NOOP

	def_callbacks
	callback MAPCALLBACK_NEWMAP, FlyPoint
	callback MAPCALLBACK_OBJECTS, SilverAndCrystal

NewBarkTownNoop1Scene:
	end

NewBarkTownNoop2Scene:
	end

SilverAndCrystal:
    disappear NEWBARKTOWN_CRYSTAL
    disappear NEWBARKTOWN_CRYSTAL_FINAL
    disappear NEWBARKTOWN_SILVER_FINAL

    checkevent EVENT_BEAT_CRYSTAL_7
    iffalse .end
    appear NEWBARKTOWN_CRYSTAL_FINAL
    appear NEWBARKTOWN_SILVER_FINAL
.end
    endcallback

FlyPoint:
    appear NEWBARKTOWN_FIELDMON_6
	setflag ENGINE_FLYPOINT_NEW_BARK
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	endcallback

NewBarkTown_TeacherStopsYouScene1:
    hidefollower
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherRunsToYouMovement1
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherBringsYouBackMovement1
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
    showfollower
	end

NewBarkTown_TeacherStopsYouScene2:
    hidefollower
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherRunsToYouMovement2
	turnobject PLAYER, UP
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherBringsYouBackMovement2
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
    showfollower
	end

NewBarkTownTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .BeatE4
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .CallMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .TellMomYoureLeaving
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .MonIsAdorable
	writetext Text_GearIsImpressive
	waitbutton
	closetext
	end

.MonIsAdorable:
	writetext Text_YourMonIsAdorable
	waitbutton
	closetext
	end

.TellMomYoureLeaving:
	writetext Text_TellMomIfLeaving
	waitbutton
	closetext
	end

.CallMom:
	writetext Text_GearIsImpressive
	waitbutton
	closetext
	end

.BeatE4:
	writetext Text_SafeWithYou
	waitbutton
	closetext
	end

NewBarkTownFisherScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .notBeatE4
	writetext Text_FishBeatE4
	sjump .report_losses
.notBeatE4
	writetext Text_ElmDiscoveredNewMon
.report_losses
	promptbutton
	callasm .FormatWhiteoutCount
	writetext Text_FisherLossReport
	waitbutton
	closetext
	end

.FormatWhiteoutCount
	; Pre-fill with terminators so shorter numbers don't leak stale buffer text.
	ld hl, wStringBuffer3
	ld a, "@"
	ld bc, 6
	call ByteFill
	; PrintNum expects a 2-byte value in big-endian order.
	ld a, [wWhiteoutCount + 1]
	ld [wStringBuffer4], a
	ld a, [wWhiteoutCount]
	ld [wStringBuffer4 + 1], a
	ld de, wStringBuffer4
	ld hl, wStringBuffer3
	lb bc, PRINTNUM_LEFTALIGN | 2, 5
	call PrintNum
	ret

NewBarkTownSilverScript:
    faceplayer
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iffalse .noPokemon
	writetext NewBarkTownRivalNotThatOneText
	waitbutton
	closetext
	end
.noPokemon
	writetext NewBarkTownRivalText1
	waitbutton
	closetext
	turnobject NEWBARKTOWN_RIVAL, LEFT
	opentext
	writetext NewBarkTownRivalText2
	waitbutton
	closetext
	follow PLAYER, NEWBARKTOWN_RIVAL
	applymovement PLAYER, NewBarkTown_RivalPushesYouAwayMovement
	stopfollow
	pause 5
	turnobject NEWBARKTOWN_RIVAL, DOWN
	pause 5
	playsound SFX_TACKLE
	applymovement PLAYER, NewBarkTown_RivalShovesYouOutMovement
	applymovement NEWBARKTOWN_RIVAL, NewBarkTown_RivalReturnsToTheShadowsMovement
	end

NewBarkTownSign:
	jumptext NewBarkTownSignText

NewBarkTownPlayersHouseSign:
	jumptext NewBarkTownPlayersHouseSignText

NewBarkTownElmsLabSign:
	jumptext NewBarkTownElmsLabSignText

NewBarkTownElmsHouseSign:
	jumptext NewBarkTownElmsHouseSignText

NewBarkTown_TeacherRunsToYouMovement1:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

NewBarkTown_TeacherRunsToYouMovement2:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

NewBarkTown_TeacherBringsYouBackMovement1:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

NewBarkTown_TeacherBringsYouBackMovement2:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

NewBarkTown_RivalPushesYouAwayMovement:
	turn_head UP
	step DOWN
	step_end

NewBarkTown_RivalShovesYouOutMovement:
	turn_head UP
	fix_facing
	jump_step DOWN
	remove_fixed_facing
	step_end

NewBarkTown_RivalReturnsToTheShadowsMovement:
	step RIGHT
	step_end

Text_GearIsImpressive:
	text "J'ai déjà assayé "
	line "de devenir"
	cont "un dresseur"

	para "Mais j'ai foncé"
	line "dans un énorme"
	cont "Ratatac en dehors"
	cont "du village."

	para "J'ai donc couru"

	para "Tu peut courrire"
	line "en maintenant B."

	para "Sauf si tu"
	line "as les"
	cont "chaussures de"
	cont "course."

	para "Tu courras"
	count "automatiquement"
	done

Text_SafeWithYou:
	text "Bonjour Maitre"
	line "<PLAYER>!"
	para "Tu me rend si fier"
	line "d'être née à"
	cont "Bourg Geon."
	para "Je me sent en"
	line "sécurité avec"
	count "toi ici"
	done

Text_WaitPlayer:
	text "Attends, <PLAY_G>!"
	done

Text_WhatDoYouThinkYoureDoing:
	text "Qu'est-ce que tu"
	line "fais?"
	done

Text_ItsDangerousToGoAlone:
	text "C'est dangereux"
	line "de sortir sans un"
	cont "#mon!"
	done

Text_YourMonIsAdorable:
	text "Oh! Ton #mon"
	line "semble puissant!"
	cont "J'aimerai en"
	cont "avoir un!"
	done

Text_TellMomIfLeaving:
	text "Salut, <PLAY_G>!"
	line "Tu part déjà?"

	para "Tu devrai aller"
	line "voir ta mère"
	cont "une dernière"
	cont "fois"
	done

Text_ElmDiscoveredNewMon:
	text "Salut, <PLAYER>!"

	para "Je me souvient"
	line "quand ton père"
	para "est parti pour"
	line "entrainer son"
	cont "#mon"

	para "Il était fort!"

	para "Il a capturé un"
	line "Ursaring enragé."

	para "Il peut prendre"
	line "soin de lui."
	done

Text_FishBeatE4:
	text "Ouah <PLAYER> tu"
	line "est le Maitre!"
	para "Ton père est si"
	line "fière de toi."
	para "Tu est bien plus"
	line "fort qu'il ne"
	cont "pourrait jamais"
	cont "être"
	done

Text_FisherLossReport:
	text "Pas comme moi."
	line "Je perd tout le"
	cont "temps."

	para "Je peut dire que"
	line "tu as perdu"
	cont "@"
	text_ram wStringBuffer3
	text " combats."

	para "Tient bon!"
	done

NewBarkTownRivalNotThatOneText:
    text "Tu pense que c'est"
    line "le plus fort?"

    para "Tu est aussi"
    line "inutile que ce"
	cont "#mon."

    para "Je vais devoir"
    line "le faire moi-même."

    para "Dégage, gamin !"
    done

NewBarkTownRivalText1:
	text "<……>"

	para "Regardes ces"
	line "#mon!"
	done

NewBarkTownRivalText2:
	text "Salut, ça te dirait"
	line "De m'aider!"

	para "Apporte moi un de"
	line "ces #mon."

	para "Soit sur de"
	line "prendre le plus"
	cont "fort."

	para "Maintenant vas-y!"
	done

NewBarkTownSignText:
	text "Bourg Geon"

	para "La Ville où"
	line "souffle le vent"
	cont "du renouveau"
	done

NewBarkTownPlayersHouseSignText:
	text "Maison de <PLAYER>"
	done

NewBarkTownElmsLabSignText:
	text "Laboratoire du"
	line "Prof. Orme.
	done

NewBarkTownElmsHouseSignText:
	text "Maison du"
	line "Prof. Orme."
	done

NeedToGetAPokemon:
    turnobject PLAYER, DOWN
	opentext
	writetext NewBarkTownBlockText
    waitbutton
    closetext
    applymovement PLAYER, Movement_NewBarkTownTurnBack
    end

NeedToGetAPokemon2:
    turnobject PLAYER, LEFT
	opentext
	writetext NewBarkTownBlockText
    waitbutton
    closetext
    applymovement PLAYER, Movement_NewBarkTownTurnLeft
    end

NewBarkTownBlockText:
    text "Je doit récupérer"
    line "un #mon chez"
    cont "le Prof. Orme!"
    done

ElmsMission:
    turnobject PLAYER, LEFT
	opentext
	writetext ElmsMissionText
    waitbutton
    closetext
    applymovement PLAYER, Movement_NewBarkTownTurnLeft
    end

ElmsMissionText:
    text "Je devrai aller"
    line "voir le"
	cont "Prof. orme !"
    done

Movement_NewBarkTownTurnBack:
	step DOWN
	step_end

Movement_NewBarkTownTurnLeft:
	step LEFT
	step_end

NewBarkFieldMon6Script:
	faceplayer
	cry STARLY
	pause 15
	loadwildmon STARLY, 3
	startbattle
	reloadmapafterbattle
	setevent EVENT_FIELD_MON_6
	disappear NEWBARKTOWN_FIELDMON_6
	end

NewBarkTownRepelScript:
	faceplayer
	opentext
	checkitem REPULSOR
	iftrue .GotRepulsor
	writetext NewBarkTownRepulsorText
	promptbutton
	verbosegiveitem REPULSOR
	promptbutton
.GotRepulsor:
	writetext NewBarkTownGotRepelsText
	waitbutton
	closetext
	end

NewBarkTownRepulsorText:
    text "#mon are"
    line "friends."

    para "They will often"
    line "come up to greet"
    cont "you even if"
    cont "you're in a"
    cont "hurry."

    para "This will"
    line "help with that."
    done

NewBarkTownGotRepelsText:
    text "Les #mon sont"
    line "tes amis."

    para "Mais certains"
    line "sont dangereux."

    para "Tu doit toujours"
    line "être préparé."

    para "Repulsor tiendra"
    line "les #mon"
    cont "faible à distance"

    para "Tu peut l'allumer"
    line "ou l'éteindre"
    cont "dans key items."
    done

CrystalScript1:
    showemote EMOTE_SHOCK, PLAYER, 15
    applymovement PLAYER, NewBarkTownMovement_PlayerRight
    sjump CrystalScript
    end

CrystalScript2:
    showemote EMOTE_SHOCK, PLAYER, 15
    applymovement PLAYER, NewBarkTownMovement_PlayerUpAndRight
    sjump CrystalScript
    end

CrystalScript:
    playmusic MUSIC_DANCING_HALL
    opentext
    writetext Crystal1_WaitUpText
    waitbutton
    closetext
    turnobject PLAYER, RIGHT
    appear NEWBARKTOWN_CRYSTAL
    applymovement NEWBARKTOWN_CRYSTAL, NewBarkTownMovement_CrystalApproaches
    opentext
    writetext Crystal1_ChallengeText
    waitbutton
    closetext

    special HealParty
	winlosstext Crystal1LosesText, Crystal1WinsText
    loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	loadtrainer CRYSTAL, CRYSTAL_1
	startbattle
	setevent EVENT_BEAT_CRYSTAL_1
	setmapscene NEW_BARK_TOWN, SCENE_CUSTOM_FINISHED
	reloadmap

	opentext
	writetext Crystal1_WellDoneText
	waitbutton
	closetext
	special FadeOutMusic
	turnobject NEWBARKTOWN_CRYSTAL, DOWN
	pause 20
	opentext
	writetext Crystal1_SorryText
	waitbutton
	playmusic MUSIC_NEW_BARK_TOWN
	turnobject NEWBARKTOWN_CRYSTAL, LEFT
	writetext PresentForYouText
	waitbutton
	verbosegiveitem JUKEBOX
	writetext Crystal1_GoodLuckText
	waitbutton
	closetext
	turnobject PLAYER, LEFT
	applymovement NEWBARKTOWN_CRYSTAL, NewBarkTownMovement_CrystalLeaves
	disappear NEWBARKTOWN_CRYSTAL
	special HealParty
.end
    end

NewBarkTownMovement_PlayerRight:
    step RIGHT
    step_end

NewBarkTownMovement_PlayerUpAndRight:
    step UP
    step RIGHT
    step_end

Crystal1_WaitUpText:
    text "Salut!"

    para "Attends un peu."
    done

NewBarkTownMovement_CrystalApproaches:
    big_step LEFT
    big_step LEFT
    big_step LEFT
    big_step UP
    big_step LEFT
    step_end

Crystal1_ChallengeText:
    text "Tu vient juste de "
    line "recevoir un"
	cont "#mon"

    para "I recently got"
    line "my first #mon"
    cont "too."

    para "My Dad gave it"
    line "to me."

    para "Well you know what"
    line "we have to do now."

    para "Let's battle?"
    done

Crystal1LosesText:
    text "Aww you did"
    line "well Riolu."
    done

Crystal1WinsText:
    text "You did really"
    line "well."
    done

Crystal1_WellDoneText:
    text "That was fun!"

    para "Now we have to"
    line "beat all Gym"
    cont "Leaders."

    para "Beat all the Elite"
    line "Four and Champion."

    para "Crush the Hoenn"
    line "army and save all"
    cont "Johto and Kanto!"

    para "Race you!"
    done

Crystal1_SorryText:
    text "I'm sorry."

    para "I hope you find"
    line "your Dad."
    done

PresentForYouText:
    text "Oh I got a present"
    line "for you!"
    para "With this you can"
    line "listen to some"
    cont "music while you"
    cont "battle."
    done

Crystal1_GoodLuckText:
    text "I'm sure I'll see"
    line "you along the way."

    para "I'm serious about"
    line "that race though!"

    para "Good luck!"
    done

NewBarkTownMovement_CrystalLeaves:
    big_step DOWN
    big_step LEFT
    big_step LEFT
    big_step LEFT
    big_step LEFT
    big_step LEFT
    step_end

FinalSilverScript:
    faceplayer
    opentext
	writetext SilverFinalGeneralText
	waitbutton
    closetext
	opentext
	writetext RematchTextSilverFinal
	nooryes
	iftrue .fight
	writetext RematchRefuseTextSilverFinal
	waitbutton
	closetext
	end
.fight
	writetext SilverFinalPreBattleText
	waitbutton
	closetext
	winlosstext SilverFinalLossText, SilverFinalWinText
	readmem wDifficulty
	ifequal DIFFICULTY_HARD, .hard
	sjump .normal
.hard
	loadvar VAR_BATTLETYPE, BATTLETYPE_BOSS_BATTLE
	loadtrainer RIVAL2, MASTER_RIVAL
	sjump .battle
.normal
	loadvar VAR_BATTLETYPE, BATTLETYPE_BOSS_BATTLE
	loadtrainer RIVAL2, RIVAL2_SILVER_CAVE
.battle
	startbattle
	ifequal LOSE, .lose
	reloadmapafterbattle
	special HealParty
	opentext
	writetext SilverFinalAfterBattleText
	waitbutton
	closetext
	end
.lose
    reloadmap
	special HealParty
	opentext
	writetext SilverFinalLoseAfterBattleText
	waitbutton
	closetext
	end

FinalCrystalScript:
    faceplayer
    opentext
	writetext CrystalFinalGeneralText
	waitbutton
    closetext
	opentext
	writetext RematchTextCrystalFinal
	nooryes
	iftrue .fight
	writetext RematchRefuseTextCrystalFinal
	waitbutton
	closetext
	end
.fight
	writetext CrystalFinalPreBattleText
	waitbutton
	closetext

    special HealParty
	winlosstext CrystalFinalLossText, CrystalFinalWinText
	readmem wDifficulty
	ifequal DIFFICULTY_HARD, .hard_crystal
	sjump .normal
.hard_crystal
	loadvar VAR_BATTLETYPE, BATTLETYPE_BOSS_BATTLE
	loadtrainer CRYSTAL, MASTER_CRYSTAL
	sjump .battle
.normal
	loadvar VAR_BATTLETYPE, BATTLETYPE_BOSS_BATTLE
	loadtrainer CRYSTAL, CRYSTAL_7
.battle
	startbattle
	ifequal LOSE, .lose
	reloadmapafterbattle
	special HealParty
	opentext
	writetext CrystalFinalAfterBattleText
	waitbutton
	closetext
	end
.lose
    reloadmap
    special HealParty
	opentext
	writetext CrystalFinalLoseAfterBattleText
	waitbutton
	closetext
	end

SilverFinalGeneralText:
    text "This place is"
    line "peaceful."

    para "The rest of the"
    line "world is frantic"
    cont "and busy."

    para "Like I used to"
    line "be."

    para "I'm glad <GREEN>"
    line "insisted I come"
    cont "here and stay a"
    cont "while."

    para "I'm happier than"
    line "I can remember"
    cont "being before."
    done

RematchTextSilverFinal:
    text "However I don't"
    line "want you becoming"
    cont "too complacent."

    para "How about another"
    line "battle?"
    done

RematchRefuseTextSilverFinal:
    text "I guess we both"
    line "know how it would"
    cont "go."
    done

SilverFinalPreBattleText:
    text "Don't you dare"
    line "hold back!"
    done

SilverFinalLossText:
    text "Some things never"
    line "change."
    done

SilverFinalWinText:
    text "You let me win!"
    done

SilverFinalLoseAfterBattleText:
    text "You've gone soft"
    line "it seems."

    para "How disappointing."
    done

SilverFinalAfterBattleText:
    text "I don't even care"
    line "that I will never"
    cont "beat you."

    para "I am happy with"
    line "who I am and"
    cont "what I have"
    cont "achieved."

    para "Losing to <GREEN>"
    line "however..."

    para "That would be"
    line "different."
    done

CrystalFinalGeneralText:
    text "Hey <PLAYER>."

    para "It's really good"
    line "to see you again."

    para "I think I've had"
    line "enough"
    cont "adventuring."

    para "I'm happy here"
    line "with my family."

    para "Though I miss"
    line "not seeing our"
    cont "local hero more"
    cont "often!"
    done

RematchTextCrystalFinal:
    text "It can get a"
    line "little boring"
    cont "sometimes though."

    para "I can battle"
    line "<RIVAL> and it's"
    cont "fun but I'd like"
    cont "to battle you."

    para "How about it?"
    done

RematchRefuseTextCrystalFinal:
    text "Ah I see."

    para "You don't want"
    line "to embarrass me."

    para "How gallant of"
    line "you."
    done

CrystalFinalPreBattleText:
    text "Let's have some"
    line "fun!"
    done

CrystalFinalLossText:
    text "What a surprising"
    line "conclusion!"

    para "That was fun!"
    done

CrystalFinalWinText:
    text "You don't have"
    line "to let me win."
    done

CrystalFinalLoseAfterBattleText:
    text "I won?!"

    para "I must truly be"
    line "the best trainer"
    cont "ever huh."

    para "Thanks for letting"
    line "me win."
    done

CrystalFinalAfterBattleText:
    text "You know I am"
    line "still amazed at"
    cont "the adventure we"
    cont "had."

    para "You are the hero"
    line "who saved me and"
    cont "all of us."

    para "But you're also"
    line "my friend."

    para "And I miss you."

    para "Now get out"
    line "there and keep"
    cont "changing the"
    cont "world!"
    done

NewBarkPikachu:
    faceplayer
    opentext
    writetext NewBarkPikachuText
    cry PIKACHU
    waitbutton
    closetext
    end

NewBarkPikachuText:
    text "Pika! Pika!"
    line "Pikachu!"
    done

NewBarkTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13, 17, PLAYERS_HOUSE_1F, 1
	warp_event  6, 15, ELMS_LAB, 1
	warp_event  3, 23, PLAYERS_NEIGHBORS_HOUSE, 1
	warp_event 11, 25, ELMS_HOUSE, 1

	def_coord_events
	coord_event  1, 20, SCENE_DEFAULT, NewBarkTown_TeacherStopsYouScene1
	coord_event  1, 21, SCENE_DEFAULT, NewBarkTown_TeacherStopsYouScene2
	coord_event  10, 11, SCENE_DEFAULT, NeedToGetAPokemon
	coord_event  11, 11, SCENE_DEFAULT, NeedToGetAPokemon
	coord_event  18, 17, SCENE_DEFAULT, NeedToGetAPokemon2
	coord_event  18, 18, SCENE_DEFAULT, NeedToGetAPokemon2
	coord_event  1, 20, SCENE_CUSTOM_1, CrystalScript1
	coord_event  1, 21, SCENE_CUSTOM_1, CrystalScript2
	coord_event  18, 17, SCENE_CUSTOM_2, ElmsMission
	coord_event  18, 18, SCENE_CUSTOM_2, ElmsMission


	def_bg_events
	bg_event  8, 20, BGEVENT_READ, NewBarkTownSign
	bg_event 11, 17, BGEVENT_READ, NewBarkTownPlayersHouseSign
	bg_event  3, 15, BGEVENT_READ, NewBarkTownElmsLabSign
	bg_event  9, 25, BGEVENT_READ, NewBarkTownElmsHouseSign

	def_object_events
	object_event  6, 20, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, MAPOBJECT_DARK_SKIN, NewBarkTownTeacherScript, -1
	object_event 10, 20, SPRITE_FISHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NewBarkTownFisherScript, -1
	object_event  3, 14, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownSilverScript, EVENT_RIVAL_NEW_BARK_TOWN
	object_event 12, 7, SPRITE_DYNAMIC_POKEMON, SPRITEMOVEDATA_WANDER, 2, 2, STARLY, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, NewBarkFieldMon6Script, EVENT_FIELD_MON_6
	object_event 10,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownRepelScript, -1
	object_event  7, 21, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMP_EVENT_1

	object_event 14, 20, SPRITE_RIVAL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FinalSilverScript, EVENT_TEMP_EVENT_2
	object_event 12, 22, SPRITE_BEAUTY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, FinalCrystalScript, EVENT_TEMP_EVENT_3
	object_event 11, 4, SPRITE_DYNAMIC_POKEMON, SPRITEMOVEDATA_WANDER, 1, 1, PIKACHU, -1, PAL_NPC_YELLOW, OBJECTTYPE_SCRIPT, 0, NewBarkPikachu, -1
