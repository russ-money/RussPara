/obj/machinery/jukebox
	name = "jukebox"
	desc = "For when there is no piano man."
	icon = 'icons/obj/jukebox.dmi'
	icon_state = "jukebox2"
	anchored = 1
	atom_say_verb = "states"
	density = 1
	max_integrity = 300
	integrity_failure = 100
	armor = list(melee = 20, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	var/active = 1
	var/list/rangers = list()
	var/charge = 35
	var/stop = 0
	var/static/list/songs = list()
	var/datum/music_track/selection = null
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	light_color = LIGHT_COLOR_LIGHTBLUE


/obj/machinery/jukebox/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/circuitboard/jukebox(null)
	component_parts += new /obj/item/stock_parts/console_screen(null, 1)
	component_parts += new /obj/item/stack/cable_coil(null, 3)
	component_parts += new /obj/item/stack/sheet/glass(null, 1)
	add_songs()
	. = ..()
	selection = songs[1]


/obj/machinery/jukebox/power_change()
	. = ..()
	update_icon()
	active = 0
	stop = world.time
	overlays.Cut()
	if(stat & NOPOWER)
		set_light(0)
		dance_over()
		icon_state = "jukebox2-nopower"
	else
		set_light(3, 3)
		icon_state = "jukebox2"
		if(emagged)
			overlays += image(icon, "jukebox2-emagged")


/obj/machinery/jukebox/obj_break(damage_flag)
	if(!(stat & BROKEN))
		stat |= BROKEN
		icon_state = "jukebox2-broken"
		dance_over()
		overlays.Cut()
		playsound(src,'sound/machines/terminal_off.ogg',50,1)


/obj/machinery/jukebox/update_icon()
	if(stat & NOPOWER)
		overlays.Cut()
		icon_state = "jukebox2-nopower"
		playsound(src,'sound/machines/terminal_off.ogg',50,1)
		active = 0
	if(stat & BROKEN)
		overlays.Cut()
		icon_state = "jukebox2-broken"
		playsound(src,'sound/machines/terminal_off.ogg',50,1)
		active = 0
	if(active)
		icon_state = "jukebox2"
		if(!emagged)
			overlays += image(icon, "jukebox2-running")
		else if(emagged)
			overlays += image(icon, "jukebox2-emagged")
	else
		icon_state = "jukebox2"


/datum/music_track
	var/song_name = "generic"
	var/song_path = null
	var/song_length = 0
	var/song_beat = 0
	var/GBP_required = 0

/datum/music_track/New(name, path, length, beat)
	song_name = name
	song_path = path
	song_length = length
	song_beat = beat

/obj/machinery/jukebox/proc/add_track(file, name, length, beat)
	var/sound/S = file
	if(!istype(S))
		return
	if(!name)
		name = "[file]"
	if(!beat)
		beat = 5
	if(!length)
		length = 2400 //Unless there's a way to discern via BYOND.
	var/datum/music_track/T = new /datum/track(name, file, length, beat)
	songs += T


/obj/machinery/jukebox/attack_hand(mob/user)
	if(..())
		return
	interact(user)

/obj/machinery/jukebox/interact(mob/user)
	if(!anchored)
		to_chat(user,"<span class='warning'>This device must be anchored by a wrench!</span>")
		return
	if(!Adjacent(user) && !isAI(user))
		return
	user.set_machine(src)
	var/list/dat = list()
	dat +="<div class='statusDisplay' style='text-align:center'>"
	dat += "<b><A href='?src=[UID()];action=toggle'>[!active ? "Play" : "Stop"]<b></A><br>"
	dat += "</div><br>"
	dat += "<A href='?src=[UID()];action=select'> Select Track</A><br>"
	dat += "Track Selected: [selection.song_name]<br>"
	dat += "Track Length: [DisplayTimeText(selection.song_length)]<br><br>"
	var/datum/browser/popup = new(user, "vending", "Jukebox", 400, 300)
	popup.set_content(dat.Join())
	popup.open()

/obj/machinery/jukebox/Topic(href, href_list)
	if(..())
		return
	add_fingerprint(usr)
	switch(href_list["action"])
		if("toggle")
			if(QDELETED(src))
				return
			if(!active)
				if(stop > world.time)
					to_chat(usr, "<span class='warning'>Error: The device is still resetting from the last activation, it will be ready again in [DisplayTimeText(stop-world.time)].</span>")
					playsound(src, 'sound/misc/compiler-failure.ogg', 50, 1)
					return
				active = TRUE
				update_icon()
				dance_setup()
				processing_objects.Add(src)
				updateUsrDialog()
			else if(active)
				stop = 0
				updateUsrDialog()
		if("select")
			if(active)
				to_chat(usr, "<span class='warning'>Error: You cannot change the song until the current one is over.</span>")
				return
			var/list/available = list()
			for(var/datum/music_track/S in songs)
				available[S.song_name] = S
			var/selected = input(usr, "Choose your song", "Track:") as null|anything in available
			if(QDELETED(src) || !selected || !istype(available[selected], /datum/music_track))
				return
			selection = available[selected]
			updateUsrDialog()


/obj/machinery/jukebox/proc/add_songs()
	songs = null
	songs = list(
		new /datum/music_track("Bob's Bluegrass", 				'sound/jukebox/bluegrass1.mid', 	1850, 	4),
		new /datum/music_track("Bob's Latin Vibes", 			'sound/jukebox/latinvibes1.mid', 	3560, 	4),
		new /datum/music_track("Bob's Polka", 					'sound/jukebox/polka1.mid', 		1730, 	4),
		new /datum/music_track("Bob's Quintet", 				'sound/jukebox/quintet.mid', 		2560, 	4),
		new /datum/music_track("Bob's Slow Swing", 				'sound/jukebox/slowswing.mid', 		2050, 	4),
		new /datum/music_track("Bob's Dance Brass", 			'sound/jukebox/dancebrass2.mid', 	1850, 	4),
		new /datum/music_track("Bob's Euro Brass", 				'sound/jukebox/dancebrass2.mid', 	2070, 	4),
		new /datum/music_track("Bob's Breezy Air", 				'sound/jukebox/breezyair.mid', 		2470, 	4),
		new /datum/music_track("Bob's Breezy Concerto", 		'sound/jukebox/breezyconcerto1.mid',1920, 	4),
		new /datum/music_track("Bob's Jazz Clarinet 1", 		'sound/jukebox/jazzclarinet1.mid',	1670, 	4),
		new /datum/music_track("Bob's Jazz Clarinet 2", 		'sound/jukebox/jazzclarinet2.mid',	3330, 	4),
		new /datum/music_track("Bob's Country Ballad", 			'sound/jukebox/countryballad1.mid',	3170, 	4),
		new /datum/music_track("Bob's Breezy Flute", 			'sound/jukebox/breezyflute.mid',	2060, 	4),
		new /datum/music_track("Bob's Country Flute", 			'sound/jukebox/countryflute1.mid',	2270, 	4),
		new /datum/music_track("Bob's Flute Samba 1", 			'sound/jukebox/flutesamba1.mid',	2270, 	4),
		new /datum/music_track("Bob's Flute Samba 2", 			'sound/jukebox/flutesamba2.mid',	1670, 	4),
		new /datum/music_track("Bob's Irish Flute", 			'sound/jukebox/flutesamba2.mid',	1820, 	4),
		new /datum/music_track("Bob's Breezy Guitar", 			'sound/jukebox/breezyguitar.mid',	2500, 	4),
		new /datum/music_track("Bob's Country Guitar 1", 		'sound/jukebox/countryguitar1.mid',	1920, 	4),
		new /datum/music_track("Bob's Country Guitar 2", 		'sound/jukebox/countryguitar2.mid',	2000, 	4),
		new /datum/music_track("Bob's Rock Guitar", 			'sound/jukebox/rockguitar1.mid',	1920, 	4),
		new /datum/music_track("Bob's Fast Jazz", 				'sound/jukebox/fastjazz1.mid',		2020, 	4),
		new /datum/music_track("Bob's Jazz Vibes", 				'sound/jukebox/jazzvibes1.mid',		2630, 	4),
		new /datum/music_track("Bob's Funky Keyboard", 			'sound/jukebox/funkykeyboard1.mid',	2780, 	4),
		new /datum/music_track("Bob's Blue Jazz Organ", 		'sound/jukebox/bluejazzorgan1.mid',	1520, 	4),
		new /datum/music_track("Bob's Bouncy Organ", 			'sound/jukebox/bouncyorgan1.mid',	1180, 	4),
		new /datum/music_track("Bob's Bouncy Piano 1", 			'sound/jukebox/bouncypiano1.mid',	1850, 	4),
		new /datum/music_track("Bob's Bouncy Piano 2", 			'sound/jukebox/bouncypiano2.mid',	1620, 	4),
		new /datum/music_track("Bob's Piano Concerto", 			'sound/jukebox/pianoconcerto1.mid',	1560, 	4),
		new /datum/music_track("Bob's Piano Orchesta", 			'sound/jukebox/pianoorchesta1.mid',	2000, 	4),
		new /datum/music_track("Bob's Ragtime Piano", 			'sound/jukebox/ragtimepiano1.mid',	790, 	4),
		new /datum/music_track("Bob's Reggae 1", 				'sound/jukebox/reggae1.mid',		2000, 	4),
		new /datum/music_track("Bob's Reggae 2", 				'sound/jukebox/reggae2.mid',		2180, 	4),
		new /datum/music_track("Bob's Ballad of Sax", 			'sound/jukebox/balladofsaxes1.mid',	2340, 	4),
		new /datum/music_track("Bob's Bouncy Sax 1", 			'sound/jukebox/bouncysax1.mid',		1800, 	4),
		new /datum/music_track("Bob's Bouncy Sax 2", 			'sound/jukebox/bouncysax2.mid',		2380, 	4),
		new /datum/music_track("Bob's Bouncy Sax 3", 			'sound/jukebox/bouncysax3.mid',		1670, 	4),
		new /datum/music_track("Bob's Sax Samba", 				'sound/jukebox/sambasax1.mid',		2380, 	4),
		new /datum/music_track("Bob's Jazz Trumpet 1", 			'sound/jukebox/jazztrumpet1.mid',	2080, 	4),
		new /datum/music_track("Bob's Jazz Trumpet 2", 			'sound/jukebox/jazztrumpet2.mid',	1510, 	4),
		)


/obj/machinery/jukebox/proc/dance_setup()
	stop = world.time + selection.song_length

/obj/machinery/jukebox/proc/dance_over()
	for(var/mob/living/L in rangers)
		if(!L || !L.client)
			continue
		L.stop_sound_channel(CHANNEL_JUKEBOX)
	rangers = list()


/obj/machinery/jukebox/process()
	if(charge < 35)
		charge += 1
	if(world.time < stop && active)
		var/sound/song_played = sound(selection.song_path)
		for(var/mob/M in range(10,src))
			if(!(M in rangers))
				rangers[M] = TRUE
				M.playsound_local(get_turf(M), null, 35, channel = CHANNEL_JUKEBOX, S = song_played)
		for(var/mob/L in rangers)
			if(get_dist(src, L) > 10)
				rangers -= L
				if(!L || !L.client)
					continue
				L.stop_sound_channel(CHANNEL_JUKEBOX)
	else if(active)
		active = FALSE
		processing_objects.Remove(src)
		dance_over()
		overlays.Cut()
		playsound(src,'sound/machines/terminal_off.ogg',50,1)
		icon_state = "jukebox2"
		if(!emagged)
			stop = world.time + 50
		else
		//It just won't stop playing that damn gnome song.
			stop = world.time + 1990
			active = TRUE
			update_icon()

/obj/machinery/jukebox/emag_act(var/mob/living/user as mob)
	if(!emagged)
		emagged = 1
		update_icon()
		if(user)
			user.visible_message("[user.name] emags [src].","<span class='warning'>You overwrite the songbank in [src].</span>")
		if (active)
			active = FALSE
			processing_objects.Remove(src)
			dance_over()
			overlays.Cut()
			playsound(src,'sound/machines/terminal_off.ogg',50,1)
		songs = null
		songs = list(new /datum/music_track("!!GNOME VILLAGE PARTY!!", 'sound/jukebox/gnomes.ogg', 1990, 4))
		selection = songs[1]
		active = TRUE
		update_icon()
		stop = world.time + 1990


/obj/machinery/jukebox/attackby(obj/item/I, mob/user, params)
	if(default_unfasten_wrench(user, I) && !active)
		return
	if(default_deconstruction_crowbar(I, ignore_panel = TRUE))
		return
	else
		return ..()