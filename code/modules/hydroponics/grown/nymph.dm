/obj/item/seeds/nymph
	name = "pack of diona nymph seeds"
	desc = "These seeds grow into diona nymphs."
	icon_state = "seed-replicapod"
	species = "replicapod"
	plantname = "Nymph Pod"
	product = /obj/item/reagent_containers/food/snacks/grown/nymph_pod
	lifespan = 50
	endurance = 8
	maturation = 10
	production = 1
	yield = 1
	mutatelist = list(/obj/item/seeds/nymph/mystery)
	reagents_add = list("plantmatter" = 0.1)

/obj/item/reagent_containers/food/snacks/grown/nymph_pod
	seed = /obj/item/seeds/nymph
	name = "nymph pod"
	desc = "A peculiar wriggling pod with a grown nymph inside. Crack it open to let the nymph out."
	icon_state = "mushy"
	bitesize_mod = 2

/obj/item/reagent_containers/food/snacks/grown/nymph_pod/attack_self(mob/user)
	new /mob/living/simple_animal/diona(get_turf(user))
	to_chat(user, "<span class='notice'>You crack open [src] letting the nymph out.</span>")
	user.drop_item()
	qdel(src)

//Mystery Pod
/obj/item/seeds/nymph/mystery
	name = "pack of mystery pod seeds"
	desc = "These seeds grow into mystery pods. These seeds are said to have come from a dead singuloth."
	icon_state = "seed-mysterypod"
	species = "mysterypod"
	plantname = "Mystery Pod"
	product = /obj/item/reagent_containers/food/snacks/grown/nymph/mystery_pod
	lifespan = 40
	endurance = 20
	production = 1
	yield = 2
	icon_grow = "mysterypod-grow"
	icon_dead = "mysterypod-dead"
	reagents_add = list("nothing" = 0.4, "singulo" = 0.5)

/obj/item/reagent_containers/food/snacks/grown/nymph/mystery_pod
	seed = /obj/item/seeds/nymph/mystery
	name = "mystery pod"
	desc = "Feels extremely heavy. Whats inside this thing?"
	icon_state = "mystery"
	filling_color = "#000000"

/obj/item/reagent_containers/food/snacks/grown/nymph/mystery_pod/attack_self(mob/user)
	var/B
	var/num = 1
	switch(rand(0,213))
		if(0 to 19)  B = pick(/obj/item/seeds/ambrosia,/obj/item/seeds/ambrosia/deus,/obj/item/seeds/ambrosia/gaia,
 					/obj/item/seeds/apple/bung,/obj/item/seeds/apple/gold, /obj/item/seeds/apple,
 					/obj/item/seeds/banana,/obj/item/seeds/banana/mime, /obj/item/seeds/banana/bluespace,
 					/obj/item/seeds/soya/koi,/obj/item/seeds/soya, /obj/item/seeds/berry,
 					/obj/item/seeds/berry/poison,/obj/item/seeds/berry, /obj/item/seeds/berry/death,
 					/obj/item/seeds/berry/glow,/obj/item/seeds/cherry/blue, /obj/item/seeds/cherry/bomb,
 					/obj/item/seeds/cherry,/obj/item/seeds/grape, /obj/item/seeds/grape/green,
 					/obj/item/seeds/cannabis/rainbow,/obj/item/seeds/cannabis, /obj/item/seeds/cannabis/death,
 					/obj/item/seeds/cannabis/white,/obj/item/seeds/cannabis/ultimate, /obj/item/seeds/wheat,
 					/obj/item/seeds/wheat/oat, /obj/item/seeds/wheat/rice, /obj/item/seeds/wheat/meat,
 					/obj/item/seeds/chili, /obj/item/seeds/chili/ice, /obj/item/seeds/chili/ghost,
 					/obj/item/seeds/lime, /obj/item/seeds/orange, /obj/item/seeds/white,
 					/obj/item/seeds/goblin, /obj/item/seeds/lemon, /obj/item/seeds/firelemon,
 					/obj/item/seeds/cocoapod, /obj/item/seeds/cocoapod/vanillapod, /obj/item/seeds/corn,
 					/obj/item/seeds/corn/snapcorn, /obj/item/seeds/eggplant, /obj/item/seeds/eggplant/eggy,
 					/obj/item/seeds/poppy, /obj/item/seeds/poppy/lily, /obj/item/seeds/poppy/geranium,
 					/obj/item/seeds/harebell, /obj/item/seeds/sunflower, /obj/item/seeds/sunflower/moonflower,
 					/obj/item/seeds/sunflower/novaflower, /obj/item/seeds/grass, /obj/item/seeds/grass/carpet,
 					/obj/item/seeds/comfrey,/obj/item/seeds/aloe, /obj/item/seeds/watermelon,
 					/obj/item/seeds/watermelon/holy, /obj/item/seeds/starthistle, /obj/item/seeds/cabbage,
 					/obj/item/seeds/sugarcane, /obj/item/seeds/reishi, /obj/item/seeds/amanita,
 					/obj/item/seeds/angel, /obj/item/seeds/liberty, /obj/item/seeds/plump/walkingmushroom,
 					/obj/item/seeds/plump, /obj/item/seeds/chanter, /obj/item/seeds/glowshroom/glowcap,
 					/obj/item/seeds/glowshroom/shadowshroom, /obj/item/seeds/glowshroom, /obj/item/seeds/fungus,
 					/obj/item/seeds/nettle, /obj/item/seeds/nettle/death, /obj/item/seeds/nymph/mystery,
 					/obj/item/seeds/nymph,/obj/item/seeds/onion,/obj/item/seeds/onion/red,
 					/obj/item/seeds/peanuts,/obj/item/seeds/pineapple,/obj/item/seeds/potato,
 					/obj/item/seeds/potato/sweet,/obj/item/seeds/pumpkin,/obj/item/seeds/pumpkin/blumpkin,
 					/obj/item/seeds/replicapod,/obj/item/seeds/carrot,/obj/item/seeds/carrot/parsnip,
 					/obj/item/seeds/whitebeet,/obj/item/seeds/redbeet,/obj/item/seeds/tea/astra,
 					/obj/item/seeds/tea,/obj/item/seeds/coffee/robusta,/obj/item/seeds/coffee,
 					/obj/item/seeds/tobacco/space,/obj/item/seeds/tobacco,/obj/item/seeds/tomato/blue,
 					/obj/item/seeds/tomato/blood,/obj/item/seeds/tomato/blue/bluespace,/obj/item/seeds/tomato/killer,
 					/obj/item/seeds/tomato,/obj/item/seeds/tower,/obj/item/seeds/tower/steel)

		if(20 to 50) B = pick(/obj/item/seeds/random, /obj/item/seeds/random/labelled)

		if(51) B = /obj/item/seeds/gatfruit

		if(52 to 62) B = pick(/obj/random/tool, /obj/random/tech_supply, /obj/random/tech_supply, /obj/item/multitool)

		if(63 to 93) B = pick(/obj/structure/closet/critter/butterfly, /mob/living/simple_animal/cockroach, /mob/living/simple_animal/pet/corgi/Ian/borgi,
					/mob/living/simple_animal/pet/corgi/puppy, /mob/living/simple_animal/pet/corgi,  /mob/living/simple_animal/crab,
					/mob/living/simple_animal/deer, /mob/living/simple_animal/cow, /mob/living/carbon/human/diona,
					/mob/living/simple_animal/diona, /mob/living/simple_animal/chicken, /mob/living/simple_animal/pig,
					/mob/living/simple_animal/hostile/retaliate/goat, /mob/living/simple_animal/pet/fox, /mob/living/simple_animal/pet/fox/Syndifox,
					/mob/living/simple_animal/lizard, /mob/living/simple_animal/mouse, /mob/living/simple_animal/,
					/mob/living/simple_animal/pet/penguin/eldrich, /mob/living/simple_animal/pet/penguin/baby, /mob/living/simple_animal/pet/penguin/emperor,
					/mob/living/simple_animal/pet/penguin/emperor/shamebrero, /mob/living/simple_animal/pet/sloth, /mob/living/simple_animal/pet/pug,
					/mob/living/simple_animal/spiderbot)

		if(94 to 114) B = pick(/mob/living/simple_animal/hostile/alien/drone,
					/mob/living/simple_animal/hostile/alien/sentinel, /mob/living/simple_animal/hostile/scarybat/batswarm,
					/mob/living/simple_animal/hostile/scarybat,/mob/living/simple_animal/hostile/bear,
					/mob/living/simple_animal/hostile/carp, /mob/living/simple_animal/hostile/creature,
					/mob/living/simple_animal/hostile/hivebot, /mob/living/simple_animal/hostile/winter/reindeer,
					/mob/living/simple_animal/hostile/feral_cat, /mob/living/simple_animal/hostile/poison/giant_spider,
					/mob/living/simple_animal/hostile/poison/giant_spider/nurse, /mob/living/simple_animal/hostile/illusion/escape,
					/mob/living/simple_animal/hostile/panther, /mob/living/simple_animal/hostile/snake,
					/mob/living/simple_animal/hostile/killertomato, /mob/living/simple_animal/hostile/viscerator,
					/mob/living/simple_animal/hostile/retaliate/clown/goblin/lessergoblin, /mob/living/simple_animal/hostile/winter/snowman)

		if(115 to 125) B = pick(/mob/living/simple_animal/hostile/carp/megacarp,
					/mob/living/simple_animal/hostile/faithless, /mob/living/simple_animal/hostile/poison/giant_spider,
					/mob/living/simple_animal/hostile/hivebot/range,
					/mob/living/simple_animal/hostile/mimic/copy, /mob/living/simple_animal/hostile/retaliate/clown/goblin,
					/mob/living/simple_animal/hostile/venus_human_trap)

		if (126 to 136) B = /obj/item/storage/pill_bottle/random_drug_bottle

		if (137) B = /obj/spacepod/random

		if (138 to 148) B = /obj/item/reagent_containers/food/drinks/bottle/random_drink

		if (149 to 159) B = pick(/obj/item/reagent_containers/glass/bottle/random_reagent, /obj/item/reagent_containers/glass/bottle/random_chem)

		if (160 to 180) B = pick(/obj/item/stack/sheet/animalhide/random, /obj/item/poster/random_official,
						/obj/item/poster/random_contraband, /obj/item/toy/random, /obj/item/toy/crayon/random,
						/obj/item/tape/random, /obj/item/lipstick/random, /obj/item/lighter/random,
						/obj/item/clothing/under/color/random, /obj/item/flashlight/flare/glowstick/random,
						/obj/effect/decal/cleanable/random, /obj/random/therapy, /obj/random/carp_plushie,
						/obj/random/figure, /obj/random/powercell, /obj/random/bomb_supply,
						/obj/structure/closet/secure_closet/random_drinks)

		if (181) B = /obj/machinery/anomalous_crystal/random

		if (182 to 202)
			B = pick(/obj/item/stack/sheet/mineral/sandstone, /obj/item/stack/sheet/mineral/diamond,
			/obj/item/stack/sheet/mineral/uranium, /obj/item/stack/sheet/mineral/plasma,
			/obj/item/stack/sheet/mineral/gold, /obj/item/stack/sheet/mineral/silver,
			/obj/item/stack/sheet/mineral/bananium, /obj/item/stack/sheet/mineral/tranquillite,
			/obj/item/stack/sheet/mineral/titanium, /obj/item/stack/sheet/mineral/plastitanium,
			/obj/item/stack/sheet/mineral/abductor, /obj/item/stack/sheet/mineral/adamantine)
			num = 25

		if (203 to 213)
			new /obj/item/clothing/mask/gas/clown_hat(get_turf(user), num)
			new /obj/item/clothing/shoes/clown_shoes(get_turf(user), num)
			new /obj/item/clothing/under/rank/clown(get_turf(user), num)
			new /obj/item/toy/crayon/rainbow(get_turf(user), num)
			new /obj/item/flag/clown(get_turf(user), num)
			new /obj/item/bikehorn(get_turf(user), num)
			new /obj/structure/statue/bananium/clown(get_turf(user), num)
			new /obj/item/reagent_containers/food/drinks/bottle/bottleofbanana(get_turf(user), num)
			new /obj/item/reagent_containers/food/snacks/pie(get_turf(user), num)
			new /obj/item/reagent_containers/food/snacks/pie(get_turf(user), num)
			new /obj/item/reagent_containers/food/snacks/pie(get_turf(user), num)
			new /obj/item/reagent_containers/food/snacks/pie(get_turf(user), num)
			new /obj/item/reagent_containers/food/snacks/pie(get_turf(user), num)
			new /obj/item/reagent_containers/spray/waterflower(get_turf(user), num)
			new /obj/item/storage/backpack/clown(get_turf(user), num)
			new /obj/item/seeds/banana(get_turf(user), num)
			new /obj/item/stamp/clown(get_turf(user), num)
			new /obj/item/restraints/handcuffs/toy(get_turf(user), num)
			B = /obj/item/grenade/clusterbuster/lube

	to_chat(user, "<span class='notice'>You forcefully crack open the purple pod.</span>")
	new B(get_turf(user), num)
	user.drop_item()
	qdel(src)