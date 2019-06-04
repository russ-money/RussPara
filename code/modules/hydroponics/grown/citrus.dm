// Citrus - base type
/obj/item/reagent_containers/food/snacks/grown/citrus
	seed = /obj/item/seeds/lime
	name = "citrus"
	desc = "It's so sour, your face will twist."
	icon_state = "lime"
	bitesize_mod = 2
	wine_power = 0.3

// Lime
/obj/item/seeds/lime
	name = "pack of lime seeds"
	desc = "These are very sour seeds."
	icon_state = "seed-lime"
	species = "lime"
	plantname = "Lime Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/citrus/lime
	lifespan = 55
	endurance = 50
	yield = 4
	potency = 15
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/orange)
	reagents_add = list("vitamin" = 0.04, "plantmatter" = 0.05)

/obj/item/reagent_containers/food/snacks/grown/citrus/lime
	seed = /obj/item/seeds/lime
	name = "lime"
	desc = "It's so sour, your face will twist."
	icon_state = "lime"
	filling_color = "#00FF00"
	distill_reagent = "triple_sec"

// Orange
/obj/item/seeds/orange
	name = "pack of orange seeds"
	desc = "Sour seeds."
	icon_state = "seed-orange"
	species = "orange"
	plantname = "Orange Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/citrus/orange
	lifespan = 60
	endurance = 50
	yield = 5
	potency = 20
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "lime-grow"
	icon_dead = "lime-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/lime, /obj/item/seeds/lemon, /obj/item/seeds/white)
	reagents_add = list("vitamin" = 0.04, "plantmatter" = 0.05)

/obj/item/reagent_containers/food/snacks/grown/citrus/orange
	seed = /obj/item/seeds/orange
	name = "orange"
	desc = "It's an tangy fruit."
	icon_state = "orange"
	filling_color = "#FFA500"

// White
/obj/item/seeds/white
	name = "pack of white seeds"
	desc = "Sweet seeds."
	icon_state = "seed-white"
	species = "white"
	plantname = "White Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/citrus/white
	lifespan = 70
	endurance = 20
	potency = 40
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "lime-grow"
	icon_dead = "lime-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/slip)
	mutatelist = list(/obj/item/seeds/goblin)
	reagents_add = list("vitamin" = 0.04, "plantmatter" = 0.05, "sodium" = 0.5, "sugar" = 0.1)

/obj/item/reagent_containers/food/snacks/grown/citrus/white
	seed = /obj/item/seeds/orange
	name = "white"
	desc = "It's a very sweet fruit. The color white was named after the fruit of this tree."
	icon_state = "white"
	filling_color = "#FFFFFF"

// Goblin Orange
/obj/item/seeds/goblin
	name = "pack of gnorange seeds"
	desc = "These seeds have a funny feeling to them."
	icon_state = "seed-goblin"
	species = "gnorange"
	plantname = "Gnorange Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/citrus/goblin
	lifespan = 70
	endurance = 20
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "lime-grow"
	icon_dead = "lime-dead"
	icon_harvest = "gnorange-harvest"
	genes = list(/datum/plant_gene/trait/slip, /datum/plant_gene/trait/squash, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list("potassium" = 0.2, "sugar" = 0.1, "sodium" = 0.4, "cyanide" = 0.1, "blood" = 0.2)
	rarity = 30

/obj/item/reagent_containers/food/snacks/grown/citrus/goblin
	seed = /obj/item/seeds/goblin
	name = "gnorange"
	desc = "You think you hear a faint honk coming from within the fruit. That or the clown is stuck in the vents again."
	icon_state = "gnorange"
	var/awakening = 0
	filling_color = "#FFFFFF"
	distill_reagent = "demonsblood"

/obj/item/reagent_containers/food/snacks/grown/citrus/goblin/attack(mob/M, mob/user, def_zone)
	if(awakening)
		to_chat(user, "<span class='warning'>The gnorange is twitching and shaking, preventing you from eating it.</span>")
		return
	..()

/obj/item/reagent_containers/food/snacks/grown/citrus/goblin/attack_self(mob/user)
	if(awakening || istype(user.loc, /turf/space))
		return
	to_chat(user, "<span class='notice'>You begin to awaken the goblin...</span>")
	awakening = 1

	spawn(30)
		if(!QDELETED(src))
			var/mob/living/simple_animal/hostile/retaliate/clown/goblin/lessergoblin/G = new /mob/living/simple_animal/hostile/retaliate/clown/goblin/lessergoblin(get_turf(loc))
			G.maxHealth += round(seed.endurance / 6)
			G.melee_damage_lower += round(seed.potency / 30)
			G.melee_damage_upper += round(seed.potency / 30)
			G.move_to_delay -= round(seed.production / 50)
			G.health = G.maxHealth
			G.visible_message("<span class='notice'>The goblin starts shaking it's feet viciously as it opens it's eyes.</span>")
			if(user)
				user.unEquip(src)
			qdel(src)

// Lemon
/obj/item/seeds/lemon
	name = "pack of lemon seeds"
	desc = "These are sour seeds."
	icon_state = "seed-lemon"
	species = "lemon"
	plantname = "Lemon Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/citrus/lemon
	lifespan = 55
	endurance = 45
	yield = 4
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "lime-grow"
	icon_dead = "lime-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/firelemon)
	reagents_add = list("vitamin" = 0.04, "plantmatter" = 0.05)

/obj/item/reagent_containers/food/snacks/grown/citrus/lemon
	seed = /obj/item/seeds/lemon
	name = "lemon"
	desc = "When life gives you lemons, make lemonade."
	icon_state = "lemon"
	filling_color = "#FFD700"

// Combustible lemon
/obj/item/seeds/firelemon //combustible lemon is too long so firelemon
	name = "pack of combustible lemon seeds"
	desc = "When life gives you lemons, don't make lemonade. Make life take the lemons back! Get mad! I don't want your damn lemons!"
	icon_state = "seed-firelemon"
	species = "firelemon"
	plantname = "Combustible Lemon Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/firelemon
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "lime-grow"
	icon_dead = "lime-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	lifespan = 55
	endurance = 45
	yield = 4
	reagents_add = list("plantmatter" = 0.05)

/obj/item/reagent_containers/food/snacks/grown/firelemon
	seed = /obj/item/seeds/firelemon
	name = "Combustible Lemon"
	desc = "Made for burning houses down."
	icon_state = "firelemon"
	bitesize_mod = 2
	wine_power = 0.7
	wine_flavor = "fire"

/obj/item/reagent_containers/food/snacks/grown/firelemon/attack_self(mob/living/user)
	var/area/A = get_area(user)
	user.visible_message("<span class='warning'>[user] primes the [src]!</span>", "<span class='userdanger'>You prime the [src]!</span>")
	var/message = "[ADMIN_LOOKUPFLW(user)] primed a combustible lemon for detonation at [A] [ADMIN_COORDJMP(user)]"
	investigate_log("[key_name(user)] primed a combustible lemon for detonation at [A] [COORD(user)].", INVESTIGATE_BOMB)
	message_admins(message)
	log_game("[key_name(user)] primed a combustible lemon for detonation at [A] [COORD(user)].")
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.throw_mode_on()
	icon_state = "firelemon_active"
	playsound(loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)
	addtimer(CALLBACK(src, .proc/prime), rand(10, 60))

/obj/item/reagent_containers/food/snacks/grown/firelemon/burn()
	prime()
	..()

/obj/item/reagent_containers/food/snacks/grown/firelemon/proc/update_mob()
	if(ismob(loc))
		var/mob/M = loc
		M.unEquip(src)

/obj/item/reagent_containers/food/snacks/grown/firelemon/ex_act(severity)
	qdel(src) //Ensuring that it's deleted by its own explosion

/obj/item/reagent_containers/food/snacks/grown/firelemon/proc/prime()
	switch(seed.potency) //Combustible lemons are alot like IEDs, lots of flame, very little bang.
		if(0 to 30)
			update_mob()
			explosion(loc,-1,-1,2, flame_range = 1)
			qdel(src)
		if(31 to 50)
			update_mob()
			explosion(loc,-1,-1,2, flame_range = 2)
			qdel(src)
		if(51 to 70)
			update_mob()
			explosion(loc,-1,-1,2, flame_range = 3)
			qdel(src)
		if(71 to 90)
			update_mob()
			explosion(loc,-1,-1,2, flame_range = 4)
			qdel(src)
		else
			update_mob()
			explosion(loc,-1,-1,2, flame_range = 5)
			qdel(src)
