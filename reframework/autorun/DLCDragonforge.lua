-- DLC Dragonforge 1.0 - Dragon's Dogma 2 (REFramework script)
-- Dragonforging like in the first game, for the Dark Arisen DLC spoils: when you or your pawns slay a dragon-type
-- enemy, one random equipped, not yet dragonforged DLC spoil of yours (appraised or Smithed weapon, shield, helmet,
-- body or leg armour) is dragonforged. Those items have no upgrade tables in the game, so this script adds tables
-- for them: the game only allows the dragonforge level on top of three smith steps, so the three smith steps give no
-- bonus and the dragonforge level gives the bonus the official DLC tables give it, scaled to the item.
-- The dragonforge is NOT written to your save file: the list is kept per save slot in
-- reframework/data/DLCDragonforge.json, taken off the items while the game writes a save and put back right after.
-- Without the mod your items are plain DLC items again. Uninstall with the game closed.
-- Menu: REFramework (Insert) > Script Generated UI > DLC Dragonforge
local VERSION = "1.1"
local DATA = "DLCDragonforge.json"
local ENH_DRAGON, ENH_UNLIMIT = 3, 4

-- [item id] = { "w"/"a", name, { dragonforge (Unlimit) bonus } } - generated from the game's own DLC upgrade tables
local FORGE = {
    [9003]={"w","Smithed Barbaric Axe",{_WeightRate=50, _PhysicalAttack=193}},
    [9004]={"w","Smithed Lost Commander's Blade",{_WeightRate=50, _PhysicalAttack=236}},
    [9005]={"w","Smithed Fiendish Messer",{_WeightRate=50, _PhysicalAttack=400}},
    [9006]={"w","Smithed Rimed Needle",{_WeightRate=50, _PhysicalAttack=342}},
    [9007]={"w","Barbaric Axe",{_WeightRate=50, _PhysicalAttack=196}},
    [9008]={"w","Lost Commander's Blade",{_WeightRate=50, _PhysicalAttack=236}},
    [9009]={"w","Fiendish Messer",{_WeightRate=50, _PhysicalAttack=400}},
    [9010]={"w","Rimed Needle",{_WeightRate=50, _PhysicalAttack=342}},
    [9011]={"w","Barbaric Axe",{_WeightRate=50, _PhysicalAttack=218}},
    [9012]={"w","Lost Commander's Blade",{_WeightRate=50, _PhysicalAttack=265}},
    [9013]={"w","Fiendish Messer",{_WeightRate=50, _PhysicalAttack=418}},
    [9014]={"w","Rimed Needle",{_WeightRate=50, _PhysicalAttack=356}},
    [9015]={"w","Polar Night",{_WeightRate=50, _PhysicalAttack=356}},
    [9016]={"w","Laevateinn",{_WeightRate=50, _PhysicalAttack=462}},
    [9017]={"w","Laevateinn",{_WeightRate=50, _PhysicalAttack=462}},
    [9019]={"w","Tyrving",{_WeightRate=50, _PhysicalAttack=287}},
    [9020]={"w","Tyrving",{_WeightRate=50, _PhysicalAttack=302}},
    [9021]={"w","Fiendish Messer",{_WeightRate=50, _PhysicalAttack=418}},
    [9023]={"w","Brand of Fealty",{_WeightRate=50, _PhysicalAttack=473}},
    [9024]={"w","Smithed Patterned Brand",{_WeightRate=50, _PhysicalAttack=236}},
    [9025]={"w","Patterned Brand",{_WeightRate=50, _PhysicalAttack=236}},
    [9026]={"w","Patterned Brand",{_WeightRate=50, _PhysicalAttack=265}},
    [9027]={"w","Smithed Lost Commander's Blade",{_WeightRate=50, _PhysicalAttack=287}},
    [9028]={"w","Lost Commander's Blade",{_WeightRate=50, _PhysicalAttack=287}},
    [9029]={"w","Lost Commander's Blade",{_WeightRate=50, _PhysicalAttack=302}},
    [9031]={"w","Smithed Ruin-Bringer's Woe",{_WeightRate=50, _PhysicalAttack=400}},
    [9032]={"w","Ruin-Bringer's Woe",{_WeightRate=50, _PhysicalAttack=400}},
    [9033]={"w","Ruin-Bringer's Woe",{_WeightRate=50, _PhysicalAttack=418}},
    [9034]={"w","Ruin-Bringer's Woe",{_WeightRate=50, _PhysicalAttack=418}},
    [9103]={"w","Smithed Three-Fanged Axe",{_WeightRate=50, _PhysicalAttack=183}},
    [9104]={"w","Smithed Guardian's Stoutblade",{_WeightRate=50, _PhysicalAttack=221}},
    [9105]={"w","Smithed Samyaza's Flatblade",{_WeightRate=50, _PhysicalAttack=365}},
    [9106]={"w","Smithed Spinechiller",{_WeightRate=50, _PhysicalAttack=314}},
    [9107]={"w","Three-Fanged Axe",{_WeightRate=50, _PhysicalAttack=187}},
    [9108]={"w","Guardian's Stoutblade",{_WeightRate=50, _PhysicalAttack=221}},
    [9109]={"w","Samyaza's Flatblade",{_WeightRate=50, _PhysicalAttack=365}},
    [9110]={"w","Spinechiller",{_WeightRate=50, _PhysicalAttack=314}},
    [9111]={"w","Three-Fanged Axe",{_WeightRate=50, _PhysicalAttack=208}},
    [9112]={"w","Guardian's Stoutblade",{_WeightRate=50, _PhysicalAttack=247}},
    [9113]={"w","Samyaza's Flatblade",{_WeightRate=50, _PhysicalAttack=381}},
    [9114]={"w","Spinechiller",{_WeightRate=50, _PhysicalAttack=327}},
    [9115]={"w","Absolute Zero",{_WeightRate=50, _PhysicalAttack=327}},
    [9116]={"w","Damocles",{_WeightRate=50, _PhysicalAttack=423}},
    [9117]={"w","Damocles",{_WeightRate=50, _PhysicalAttack=423}},
    [9118]={"w","Smithed Dainsleif",{_WeightRate=50, _PhysicalAttack=266}},
    [9119]={"w","Dainsleif",{_WeightRate=50, _PhysicalAttack=266}},
    [9120]={"w","Dainsleif",{_WeightRate=50, _PhysicalAttack=279}},
    [9121]={"w","Samyaza's Flatblade",{_WeightRate=50, _PhysicalAttack=381}},
    [9123]={"w","Smithed Brand of the Beast",{_WeightRate=50, _PhysicalAttack=221}},
    [9124]={"w","Brand of the Beast",{_WeightRate=50, _PhysicalAttack=221}},
    [9125]={"w","Brand of the Beast",{_WeightRate=50, _PhysicalAttack=247}},
    [9126]={"w","Smithed Guardian's Stoutblade",{_WeightRate=50, _PhysicalAttack=266}},
    [9127]={"w","Guardian's Stoutblade",{_WeightRate=50, _PhysicalAttack=266}},
    [9128]={"w","Guardian's Stoutblade",{_WeightRate=50, _PhysicalAttack=279}},
    [9129]={"w","Smithed Knight's Grandblade",{_WeightRate=50, _PhysicalAttack=365}},
    [9130]={"w","Knight's Grandblade",{_WeightRate=50, _PhysicalAttack=365}},
    [9131]={"w","Knight's Grandblade",{_WeightRate=50, _PhysicalAttack=433}},
    [9132]={"w","Knight's Grandblade",{_WeightRate=50, _PhysicalAttack=433}},
    [9203]={"w","Smithed Spearpoint Daggers",{_WeightRate=50, _PhysicalAttack=206}},
    [9204]={"w","Smithed Footpad's Blades",{_WeightRate=50, _PhysicalAttack=261}},
    [9205]={"w","Smithed Horns of Penemue",{_WeightRate=50, _PhysicalAttack=459}},
    [9206]={"w","Smithed Ice Talons",{_WeightRate=50, _PhysicalAttack=390}},
    [9207]={"w","Spearpoint Daggers",{_WeightRate=50, _PhysicalAttack=210}},
    [9208]={"w","Footpad's Blades",{_WeightRate=50, _PhysicalAttack=261}},
    [9209]={"w","Horns of Penemue",{_WeightRate=50, _PhysicalAttack=459}},
    [9210]={"w","Ice Talons",{_WeightRate=50, _PhysicalAttack=390}},
    [9211]={"w","Spearpoint Daggers",{_WeightRate=50, _PhysicalAttack=236}},
    [9212]={"w","Footpad's Blades",{_WeightRate=50, _PhysicalAttack=296}},
    [9213]={"w","Horns of Penemue",{_WeightRate=50, _PhysicalAttack=482}},
    [9214]={"w","Ice Talons",{_WeightRate=50, _PhysicalAttack=407}},
    [9215]={"w","Shards of Nilas",{_WeightRate=50, _PhysicalAttack=407}},
    [9216]={"w","Acrimony",{_WeightRate=50, _PhysicalAttack=536}},
    [9217]={"w","Acrimony",{_WeightRate=50, _PhysicalAttack=536}},
    [9218]={"w","Smithed Butcher's Barbs",{_WeightRate=50, _PhysicalAttack=324}},
    [9219]={"w","Butcher's Barbs",{_WeightRate=50, _PhysicalAttack=324}},
    [9220]={"w","Butcher's Barbs",{_WeightRate=50, _PhysicalAttack=341}},
    [9221]={"w","Horns of Penemue",{_WeightRate=50, _PhysicalAttack=482}},
    [9223]={"w","Smithed Taloned Steel",{_WeightRate=50, _PhysicalAttack=261}},
    [9224]={"w","Taloned Steel",{_WeightRate=50, _PhysicalAttack=261}},
    [9225]={"w","Taloned Steel",{_WeightRate=50, _PhysicalAttack=296}},
    [9226]={"w","Smithed Footpad's Blades",{_WeightRate=50, _PhysicalAttack=324}},
    [9227]={"w","Footpad's Blades",{_WeightRate=50, _PhysicalAttack=324}},
    [9228]={"w","Footpad's Blades",{_WeightRate=50, _PhysicalAttack=341}},
    [9229]={"w","Smithed Shadow Skivers",{_WeightRate=50, _PhysicalAttack=459}},
    [9230]={"w","Shadow Skivers",{_WeightRate=50, _PhysicalAttack=459}},
    [9231]={"w","Shadow Skivers",{_WeightRate=50, _PhysicalAttack=482}},
    [9232]={"w","Shadow Skivers",{_WeightRate=50, _PhysicalAttack=482}},
    [9303]={"w","Smithed Yewen Cane",{_WeightRate=50, _PhysicalAttack=344, _MagicAttack=193, _ShakeGuard=22, _BlowGuard=22}},
    [9304]={"w","Smithed Broken Cage",{_WeightRate=50, _PhysicalAttack=380, _MagicAttack=223, _ShakeGuard=22, _BlowGuard=22}},
    [9305]={"w","Smithed Spellstaff of Armaros",{_WeightRate=50, _PhysicalAttack=439, _MagicAttack=354, _ShakeGuard=22, _BlowGuard=22}},
    [9306]={"w","Smithed Dimpled Crystal",{_WeightRate=50, _PhysicalAttack=424, _MagicAttack=303, _ShakeGuard=22, _BlowGuard=22}},
    [9307]={"w","Yewen Cane",{_WeightRate=50, _PhysicalAttack=344, _MagicAttack=196, _ShakeGuard=22, _BlowGuard=22}},
    [9308]={"w","Broken Cage",{_WeightRate=50, _PhysicalAttack=380, _MagicAttack=223, _ShakeGuard=22, _BlowGuard=22}},
    [9309]={"w","Spellstaff of Armaros",{_WeightRate=50, _PhysicalAttack=446, _MagicAttack=354, _ShakeGuard=22, _BlowGuard=22}},
    [9310]={"w","Dimpled Crystal",{_WeightRate=50, _PhysicalAttack=424, _MagicAttack=303, _ShakeGuard=22, _BlowGuard=22}},
    [9311]={"w","Yewen Cane",{_WeightRate=50, _PhysicalAttack=359, _MagicAttack=211, _ShakeGuard=22, _BlowGuard=22}},
    [9312]={"w","Broken Cage",{_WeightRate=50, _PhysicalAttack=388, _MagicAttack=244, _ShakeGuard=22, _BlowGuard=22}},
    [9313]={"w","Spellstaff of Armaros",{_WeightRate=50, _PhysicalAttack=446, _MagicAttack=369, _ShakeGuard=22, _BlowGuard=22}},
    [9314]={"w","Dimpled Crystal",{_WeightRate=50, _PhysicalAttack=432, _MagicAttack=315, _ShakeGuard=22, _BlowGuard=22}},
    [9315]={"w","Permafrost",{_WeightRate=50, _PhysicalAttack=439, _MagicAttack=315, _ShakeGuard=22, _BlowGuard=22}},
    [9316]={"w","Dian Cecht",{_WeightRate=50, _PhysicalAttack=461, _MagicAttack=407, _ShakeGuard=22, _BlowGuard=22}},
    [9317]={"w","Dian Cecht",{_WeightRate=50, _PhysicalAttack=461, _MagicAttack=407, _ShakeGuard=22, _BlowGuard=22}},
    [9318]={"w","Smithed Draconic Quatrain",{_WeightRate=50, _PhysicalAttack=395, _MagicAttack=259, _ShakeGuard=22, _BlowGuard=22}},
    [9319]={"w","Draconic Quatrain",{_WeightRate=50, _PhysicalAttack=410, _MagicAttack=259, _ShakeGuard=22, _BlowGuard=22}},
    [9320]={"w","Draconic Quatrain",{_WeightRate=50, _PhysicalAttack=417, _MagicAttack=271, _ShakeGuard=22, _BlowGuard=22}},
    [9321]={"w","Spellstaff of Armaros",{_WeightRate=50, _PhysicalAttack=454, _MagicAttack=369, _ShakeGuard=22, _BlowGuard=22}},
    [9323]={"w","Smithed Gargoyle's Perch",{_WeightRate=50, _PhysicalAttack=380, _MagicAttack=223, _ShakeGuard=22, _BlowGuard=22}},
    [9324]={"w","Gargoyle's Perch",{_WeightRate=50, _PhysicalAttack=380, _MagicAttack=223, _ShakeGuard=22, _BlowGuard=22}},
    [9325]={"w","Gargoyle's Perch",{_WeightRate=50, _PhysicalAttack=388, _MagicAttack=244, _ShakeGuard=22, _BlowGuard=22}},
    [9326]={"w","Smithed Broken Cage",{_WeightRate=50, _PhysicalAttack=395, _MagicAttack=259, _ShakeGuard=22, _BlowGuard=22}},
    [9327]={"w","Broken Cage",{_WeightRate=50, _PhysicalAttack=410, _MagicAttack=259, _ShakeGuard=22, _BlowGuard=22}},
    [9328]={"w","Broken Cage",{_WeightRate=50, _PhysicalAttack=417, _MagicAttack=271, _ShakeGuard=22, _BlowGuard=22}},
    [9329]={"w","Smithed Chicaner's Bonestaff",{_WeightRate=50, _PhysicalAttack=439, _MagicAttack=354, _ShakeGuard=22, _BlowGuard=22}},
    [9330]={"w","Chicaner's Bonestaff",{_WeightRate=50, _PhysicalAttack=446, _MagicAttack=354, _ShakeGuard=22, _BlowGuard=22}},
    [9331]={"w","Chicaner's Bonestaff",{_WeightRate=50, _PhysicalAttack=446, _MagicAttack=369, _ShakeGuard=22, _BlowGuard=22}},
    [9332]={"w","Chicaner's Bonestaff",{_WeightRate=50, _PhysicalAttack=446, _MagicAttack=369, _ShakeGuard=22, _BlowGuard=22}},
    [9403]={"w","Smithed Coiled Wyrm",{_WeightRate=50, _PhysicalAttack=155, _MagicAttack=200, _ShakeGuard=22, _BlowGuard=22}},
    [9404]={"w","Smithed Chronicler's Scepter",{_WeightRate=50, _PhysicalAttack=209, _MagicAttack=227, _ShakeGuard=22, _BlowGuard=22}},
    [9405]={"w","Smithed Bezariel's Spiral",{_WeightRate=50, _PhysicalAttack=337, _MagicAttack=353, _ShakeGuard=22, _BlowGuard=22}},
    [9406]={"w","Smithed Dendrite",{_WeightRate=50, _PhysicalAttack=300, _MagicAttack=304, _ShakeGuard=22, _BlowGuard=22}},
    [9407]={"w","Coiled Wyrm",{_WeightRate=50, _PhysicalAttack=159, _MagicAttack=203, _ShakeGuard=22, _BlowGuard=22}},
    [9408]={"w","Chronicler's Scepter",{_WeightRate=50, _PhysicalAttack=218, _MagicAttack=227, _ShakeGuard=22, _BlowGuard=22}},
    [9409]={"w","Bezariel's Spiral",{_WeightRate=50, _PhysicalAttack=355, _MagicAttack=353, _ShakeGuard=22, _BlowGuard=22}},
    [9410]={"w","Dendrite",{_WeightRate=50, _PhysicalAttack=309, _MagicAttack=304, _ShakeGuard=22, _BlowGuard=22}},
    [9411]={"w","Coiled Wyrm",{_WeightRate=50, _PhysicalAttack=200, _MagicAttack=215, _ShakeGuard=22, _BlowGuard=22}},
    [9412]={"w","Chronicler's Scepter",{_WeightRate=50, _PhysicalAttack=246, _MagicAttack=248, _ShakeGuard=22, _BlowGuard=22}},
    [9413]={"w","Bezariel's Spiral",{_WeightRate=50, _PhysicalAttack=382, _MagicAttack=365, _ShakeGuard=22, _BlowGuard=22}},
    [9414]={"w","Dendrite",{_WeightRate=50, _PhysicalAttack=346, _MagicAttack=316, _ShakeGuard=22, _BlowGuard=22}},
    [9415]={"w","Whiteout",{_WeightRate=50, _PhysicalAttack=346, _MagicAttack=316, _ShakeGuard=22, _BlowGuard=22}},
    [9416]={"w","Caesura",{_WeightRate=50, _PhysicalAttack=400, _MagicAttack=410, _ShakeGuard=22, _BlowGuard=22}},
    [9417]={"w","Caesura",{_WeightRate=50, _PhysicalAttack=400, _MagicAttack=410, _ShakeGuard=22, _BlowGuard=22}},
    [9418]={"w","Smithed Wyrmsrune",{_WeightRate=50, _PhysicalAttack=255, _MagicAttack=263, _ShakeGuard=22, _BlowGuard=22}},
    [9419]={"w","Wyrmsrune",{_WeightRate=50, _PhysicalAttack=264, _MagicAttack=263, _ShakeGuard=22, _BlowGuard=22}},
    [9420]={"w","Wyrmsrune",{_WeightRate=50, _PhysicalAttack=291, _MagicAttack=274, _ShakeGuard=22, _BlowGuard=22}},
    [9421]={"w","Bezariel's Spiral",{_WeightRate=50, _PhysicalAttack=382, _MagicAttack=365, _ShakeGuard=22, _BlowGuard=22}},
    [9423]={"w","Smithed Numinous Conductor",{_WeightRate=50, _PhysicalAttack=209, _MagicAttack=227, _ShakeGuard=22, _BlowGuard=22}},
    [9424]={"w","Numinous Conductor",{_WeightRate=50, _PhysicalAttack=218, _MagicAttack=227, _ShakeGuard=22, _BlowGuard=22}},
    [9425]={"w","Numinous Conductor",{_WeightRate=50, _PhysicalAttack=246, _MagicAttack=248, _ShakeGuard=22, _BlowGuard=22}},
    [9426]={"w","Smithed Chronicler's Scepter",{_WeightRate=50, _PhysicalAttack=255, _MagicAttack=263, _ShakeGuard=22, _BlowGuard=22}},
    [9427]={"w","Chronicler's Scepter",{_WeightRate=50, _PhysicalAttack=264, _MagicAttack=263, _ShakeGuard=22, _BlowGuard=22}},
    [9428]={"w","Chronicler's Scepter",{_WeightRate=50, _PhysicalAttack=291, _MagicAttack=274, _ShakeGuard=22, _BlowGuard=22}},
    [9429]={"w","Smithed Sealstaff of Ruin",{_WeightRate=50, _PhysicalAttack=337, _MagicAttack=353, _ShakeGuard=22, _BlowGuard=22}},
    [9430]={"w","Sealstaff of Ruin",{_WeightRate=50, _PhysicalAttack=355, _MagicAttack=353, _ShakeGuard=22, _BlowGuard=22}},
    [9431]={"w","Sealstaff of Ruin",{_WeightRate=50, _PhysicalAttack=219, _MagicAttack=386, _ShakeGuard=13, _BlowGuard=13}},
    [9432]={"w","Sealstaff of Ruin",{_WeightRate=50, _PhysicalAttack=219, _MagicAttack=386, _ShakeGuard=13, _BlowGuard=13}},
    [9503]={"w","Smithed Deerhorn Bow",{_WeightRate=50, _PhysicalAttack=200}},
    [9504]={"w","Smithed Survivor's Ebonbow",{_WeightRate=50, _PhysicalAttack=248}},
    [9505]={"w","Smithed Gadrel's Mercy",{_WeightRate=50, _PhysicalAttack=426}},
    [9506]={"w","Smithed Snowstorm Seeker",{_WeightRate=50, _PhysicalAttack=363}},
    [9507]={"w","Deerhorn Bow",{_WeightRate=50, _PhysicalAttack=204}},
    [9508]={"w","Survivor's Ebonbow",{_WeightRate=50, _PhysicalAttack=248}},
    [9509]={"w","Gadrel's Mercy",{_WeightRate=50, _PhysicalAttack=426}},
    [9510]={"w","Snowstorm Seeker",{_WeightRate=50, _PhysicalAttack=363}},
    [9511]={"w","Deerhorn Bow",{_WeightRate=50, _PhysicalAttack=228}},
    [9512]={"w","Survivor's Ebonbow",{_WeightRate=50, _PhysicalAttack=279}},
    [9513]={"w","Gadrel's Mercy",{_WeightRate=50, _PhysicalAttack=448}},
    [9514]={"w","Snowstorm Seeker",{_WeightRate=50, _PhysicalAttack=379}},
    [9515]={"w","Hailstorm Hunter",{_WeightRate=50, _PhysicalAttack=379}},
    [9516]={"w","Misteltein",{_WeightRate=50, _PhysicalAttack=495}},
    [9517]={"w","Misteltein",{_WeightRate=50, _PhysicalAttack=495}},
    [9518]={"w","Smithed Bloodhunter",{_WeightRate=50, _PhysicalAttack=303}},
    [9519]={"w","Bloodhunter",{_WeightRate=50, _PhysicalAttack=303}},
    [9520]={"w","Bloodhunter",{_WeightRate=50, _PhysicalAttack=318}},
    [9521]={"w","Gadrel's Mercy",{_WeightRate=50, _PhysicalAttack=448}},
    [9523]={"w","Smithed Zephyr's Arc",{_WeightRate=50, _PhysicalAttack=248}},
    [9524]={"w","Zephyr's Arc",{_WeightRate=50, _PhysicalAttack=248}},
    [9525]={"w","Zephyr's Arc",{_WeightRate=50, _PhysicalAttack=279}},
    [9526]={"w","Smithed Survivor's Ebonbow",{_WeightRate=50, _PhysicalAttack=303}},
    [9527]={"w","Survivor's Ebonbow",{_WeightRate=50, _PhysicalAttack=303}},
    [9528]={"w","Survivor's Ebonbow",{_WeightRate=50, _PhysicalAttack=318}},
    [9529]={"w","Smithed Foretoken",{_WeightRate=50, _PhysicalAttack=426}},
    [9530]={"w","Foretoken",{_WeightRate=50, _PhysicalAttack=426}},
    [9531]={"w","Foretoken",{_WeightRate=50, _PhysicalAttack=595, _ShakeGuard=13, _BlowGuard=13}},
    [9532]={"w","Foretoken",{_WeightRate=50, _PhysicalAttack=595, _ShakeGuard=13, _BlowGuard=13}},
    [9603]={"w","Smithed Rowan Arc",{_WeightRate=50, _MagicAttack=188}},
    [9604]={"w","Smithed Altruist's Bow",{_WeightRate=50, _MagicAttack=218}},
    [9605]={"w","Smithed Starsight Bow",{_WeightRate=50, _MagicAttack=344}},
    [9606]={"w","Smithed Frost Marrow",{_WeightRate=50, _MagicAttack=297}},
    [9607]={"w","Rowan Arc",{_WeightRate=50, _MagicAttack=191}},
    [9608]={"w","Altruist's Bow",{_WeightRate=50, _MagicAttack=218}},
    [9609]={"w","Starsight Bow",{_WeightRate=50, _MagicAttack=344}},
    [9610]={"w","Frost Marrow",{_WeightRate=50, _MagicAttack=297}},
    [9611]={"w","Rowan Arc",{_WeightRate=50, _MagicAttack=206}},
    [9612]={"w","Altruist's Bow",{_WeightRate=50, _MagicAttack=239}},
    [9613]={"w","Starsight Bow",{_WeightRate=50, _MagicAttack=359}},
    [9614]={"w","Frost Marrow",{_WeightRate=50, _MagicAttack=309}},
    [9615]={"w","Haglel",{_WeightRate=50, _MagicAttack=309}},
    [9616]={"w","Failnaught",{_WeightRate=50, _MagicAttack=398}},
    [9617]={"w","Failnaught",{_WeightRate=50, _MagicAttack=398}},
    [9618]={"w","Smithed Sanguine Radiance",{_WeightRate=50, _MagicAttack=254}},
    [9619]={"w","Sanguine Radiance",{_WeightRate=50, _MagicAttack=254}},
    [9620]={"w","Sanguine Radiance",{_WeightRate=50, _MagicAttack=266}},
    [9621]={"w","Starsight Bow",{_WeightRate=50, _MagicAttack=359}},
    [9623]={"w","Smithed Soothstone",{_WeightRate=50, _MagicAttack=218}},
    [9624]={"w","Soothstone",{_WeightRate=50, _MagicAttack=218}},
    [9625]={"w","Soothstone",{_WeightRate=50, _MagicAttack=239}},
    [9626]={"w","Smithed Altruist's Bow",{_WeightRate=50, _MagicAttack=254}},
    [9627]={"w","Altruist's Bow",{_WeightRate=50, _MagicAttack=254}},
    [9628]={"w","Altruist's Bow",{_WeightRate=50, _MagicAttack=266}},
    [9629]={"w","Smithed Fiendsbane",{_WeightRate=50, _MagicAttack=344}},
    [9630]={"w","Fiendsbane",{_WeightRate=50, _MagicAttack=344}},
    [9631]={"w","Fiendsbane",{_WeightRate=50, _MagicAttack=359}},
    [9632]={"w","Fiendsbane",{_WeightRate=50, _MagicAttack=359}},
    [9703]={"w","Smithed Twin Sarissae",{_WeightRate=50, _PhysicalAttack=198, _MagicAttack=198}},
    [9704]={"w","Smithed Blades of Rye",{_WeightRate=50, _PhysicalAttack=239, _MagicAttack=238}},
    [9705]={"w","Smithed Suriyel's Moonblade",{_WeightRate=50, _PhysicalAttack=395, _MagicAttack=394}},
    [9706]={"w","Smithed Gelid Branch",{_WeightRate=50, _PhysicalAttack=340, _MagicAttack=338}},
    [9707]={"w","Twin Sarissae",{_WeightRate=50, _PhysicalAttack=202, _MagicAttack=201}},
    [9708]={"w","Blades of Rye",{_WeightRate=50, _PhysicalAttack=239, _MagicAttack=238}},
    [9709]={"w","Suriyel's Moonblade",{_WeightRate=50, _PhysicalAttack=395, _MagicAttack=394}},
    [9710]={"w","Gelid Branch",{_WeightRate=50, _PhysicalAttack=340, _MagicAttack=338}},
    [9711]={"w","Twin Sarissae",{_WeightRate=50, _PhysicalAttack=222, _MagicAttack=221}},
    [9712]={"w","Blades of Rye",{_WeightRate=50, _PhysicalAttack=266, _MagicAttack=265}},
    [9713]={"w","Suriyel's Moonblade",{_WeightRate=50, _PhysicalAttack=412, _MagicAttack=410}},
    [9714]={"w","Gelid Branch",{_WeightRate=50, _PhysicalAttack=353, _MagicAttack=352}},
    [9715]={"w","Snowsquall",{_WeightRate=50, _PhysicalAttack=353, _MagicAttack=352}},
    [9716]={"w","Double-Crosser",{_WeightRate=50, _PhysicalAttack=454, _MagicAttack=452}},
    [9717]={"w","Double-Crosser",{_WeightRate=50, _PhysicalAttack=454, _MagicAttack=452}},
    [9718]={"w","Smithed Bloodeagle",{_WeightRate=50, _PhysicalAttack=289, _MagicAttack=288}},
    [9719]={"w","Bloodeagle",{_WeightRate=50, _PhysicalAttack=289, _MagicAttack=288}},
    [9720]={"w","Bloodeagle",{_WeightRate=50, _PhysicalAttack=303, _MagicAttack=301}},
    [9721]={"w","Suriyel's Moonblade",{_WeightRate=50, _PhysicalAttack=412, _MagicAttack=410}},
    [9723]={"w","Smithed Anointed Edge",{_WeightRate=50, _PhysicalAttack=239, _MagicAttack=238}},
    [9724]={"w","Anointed Edge",{_WeightRate=50, _PhysicalAttack=239, _MagicAttack=238}},
    [9725]={"w","Anointed Edge",{_WeightRate=50, _PhysicalAttack=266, _MagicAttack=265}},
    [9726]={"w","Smithed Blades of Rye",{_WeightRate=50, _PhysicalAttack=289, _MagicAttack=288}},
    [9727]={"w","Blades of Rye",{_WeightRate=50, _PhysicalAttack=289, _MagicAttack=288}},
    [9728]={"w","Blades of Rye",{_WeightRate=50, _PhysicalAttack=303, _MagicAttack=301}},
    [9729]={"w","Smithed Vice Versa",{_WeightRate=50, _PhysicalAttack=395, _MagicAttack=394}},
    [9730]={"w","Vice Versa",{_WeightRate=50, _PhysicalAttack=395, _MagicAttack=394}},
    [9731]={"w","Vice Versa",{_WeightRate=50, _PhysicalAttack=412, _MagicAttack=410}},
    [9732]={"w","Vice Versa",{_WeightRate=50, _PhysicalAttack=412, _MagicAttack=410}},
    [9803]={"w","Smithed Primal Orison",{_WeightRate=50, _PhysicalAttack=162, _MagicAttack=168}},
    [9804]={"w","Smithed Inverted Dogma",{_WeightRate=50, _PhysicalAttack=196, _MagicAttack=214}},
    [9805]={"w","Smithed Dream Eater",{_WeightRate=50, _PhysicalAttack=283, _MagicAttack=428}},
    [9806]={"w","Smithed Frostflake Mirage",{_WeightRate=50, _PhysicalAttack=259, _MagicAttack=351}},
    [9807]={"w","Primal Orison",{_WeightRate=50, _PhysicalAttack=166, _MagicAttack=175}},
    [9808]={"w","Inverted Dogma",{_WeightRate=50, _PhysicalAttack=202, _MagicAttack=214}},
    [9809]={"w","Dream Eater",{_WeightRate=50, _PhysicalAttack=289, _MagicAttack=428}},
    [9810]={"w","Frostflake Mirage",{_WeightRate=50, _PhysicalAttack=265, _MagicAttack=351}},
    [9811]={"w","Primal Orison",{_WeightRate=50, _PhysicalAttack=187, _MagicAttack=196}},
    [9812]={"w","Inverted Dogma",{_WeightRate=50, _PhysicalAttack=223, _MagicAttack=253}},
    [9813]={"w","Dream Eater",{_WeightRate=50, _PhysicalAttack=301, _MagicAttack=438}},
    [9814]={"w","Frostflake Mirage",{_WeightRate=50, _PhysicalAttack=271, _MagicAttack=365}},
    [9815]={"w","Shivering Anamnesis",{_WeightRate=50, _PhysicalAttack=271, _MagicAttack=365}},
    [9816]={"w","Devilish Mirth",{_WeightRate=50, _PhysicalAttack=325, _MagicAttack=474}},
    [9817]={"w","Devilish Mirth",{_WeightRate=50, _PhysicalAttack=325, _MagicAttack=474}},
    [9818]={"w","Smithed Mesmeric Glamor",{_WeightRate=50, _PhysicalAttack=235, _MagicAttack=274}},
    [9819]={"w","Mesmeric Glamor",{_WeightRate=50, _PhysicalAttack=238, _MagicAttack=277}},
    [9820]={"w","Mesmeric Glamor",{_WeightRate=50, _PhysicalAttack=253, _MagicAttack=298}},
    [9821]={"w","Dream Eater",{_WeightRate=50, _PhysicalAttack=301, _MagicAttack=438}},
    [9823]={"w","Smithed Raptorial Liturgy",{_WeightRate=50, _PhysicalAttack=196, _MagicAttack=214}},
    [9824]={"w","Raptorial Liturgy",{_WeightRate=50, _PhysicalAttack=202, _MagicAttack=214}},
    [9825]={"w","Raptorial Liturgy",{_WeightRate=50, _PhysicalAttack=223, _MagicAttack=253}},
    [9826]={"w","Smithed Inverted Dogma",{_WeightRate=50, _PhysicalAttack=235, _MagicAttack=274}},
    [9827]={"w","Inverted Dogma",{_WeightRate=50, _PhysicalAttack=238, _MagicAttack=277}},
    [9828]={"w","Inverted Dogma",{_WeightRate=50, _PhysicalAttack=253, _MagicAttack=298}},
    [9829]={"w","Smithed Sagacious Epode",{_WeightRate=50, _PhysicalAttack=283, _MagicAttack=428}},
    [9830]={"w","Sagacious Epode",{_WeightRate=50, _PhysicalAttack=289, _MagicAttack=428}},
    [9831]={"w","Sagacious Epode",{_WeightRate=50, _PhysicalAttack=301, _MagicAttack=438}},
    [9832]={"w","Sagacious Epode",{_WeightRate=50, _PhysicalAttack=301, _MagicAttack=438}},
    [9903]={"w","Smithed Norgandian Shield",{_WeightRate=50, _PhysicalAttack=165, _ShakeGuard=67, _BlowGuard=67}},
    [9904]={"w","Smithed Ancestral Shield",{_WeightRate=50, _PhysicalAttack=253, _ShakeGuard=67, _BlowGuard=67}},
    [9905]={"w","Smithed Fatted Calf",{_WeightRate=50, _PhysicalAttack=559, _ShakeGuard=67, _BlowGuard=67}},
    [9906]={"w","Smithed Stellar Plate",{_WeightRate=50, _PhysicalAttack=459, _ShakeGuard=67, _BlowGuard=67}},
    [9908]={"w","Norgandian Shield",{_WeightRate=50, _PhysicalAttack=168, _ShakeGuard=67, _BlowGuard=67}},
    [9909]={"w","Ancestral Shield",{_WeightRate=50, _PhysicalAttack=253, _ShakeGuard=67, _BlowGuard=67}},
    [9910]={"w","Fatted Calf",{_WeightRate=50, _PhysicalAttack=559, _ShakeGuard=67, _BlowGuard=67}},
    [9911]={"w","Stellar Plate",{_WeightRate=50, _PhysicalAttack=459, _ShakeGuard=67, _BlowGuard=67}},
    [9913]={"w","Norgandian Shield",{_WeightRate=50, _PhysicalAttack=194, _ShakeGuard=67, _BlowGuard=67}},
    [9914]={"w","Ancestral Shield",{_WeightRate=50, _PhysicalAttack=306, _ShakeGuard=67, _BlowGuard=67}},
    [9915]={"w","Fatted Calf",{_WeightRate=50, _PhysicalAttack=588, _ShakeGuard=67, _BlowGuard=67}},
    [9916]={"w","Stellar Plate",{_WeightRate=50, _PhysicalAttack=482, _ShakeGuard=67, _BlowGuard=67}},
    [9918]={"w","Verglas",{_WeightRate=50, _PhysicalAttack=482, _ShakeGuard=67, _BlowGuard=67}},
    [9919]={"w","Zlatorog's Aegis",{_WeightRate=50, _PhysicalAttack=665, _ShakeGuard=67, _BlowGuard=67}},
    [9920]={"w","Zlatorog's Aegis",{_WeightRate=50, _PhysicalAttack=665, _ShakeGuard=67, _BlowGuard=67}},
    [9921]={"w","Smithed Dragon's Sternum",{_WeightRate=50, _PhysicalAttack=359, _ShakeGuard=67, _BlowGuard=67}},
    [9932]={"w","Firebird Ensign",{_WeightRate=50, _PhysicalAttack=177, _ShakeGuard=13, _BlowGuard=13}},
    [9933]={"w","Dragon's Sternum",{_WeightRate=50, _PhysicalAttack=359, _ShakeGuard=67, _BlowGuard=67}},
    [9934]={"w","Dragon's Sternum",{_WeightRate=50, _PhysicalAttack=388, _ShakeGuard=67, _BlowGuard=67}},
    [9935]={"w","Fatted Calf",{_WeightRate=50, _PhysicalAttack=588, _ShakeGuard=67, _BlowGuard=67}},
    [9936]={"w","Dragon's Greater Aegis",{_WeightRate=50, _PhysicalAttack=176, _ShakeGuard=67, _BlowGuard=67}},
    [9937]={"w","Aegis of Allegiance",{_WeightRate=50, _PhysicalAttack=682, _ShakeGuard=67, _BlowGuard=67}},
    [9938]={"w","Smithed Volucrine Hardshield",{_WeightRate=50, _PhysicalAttack=253, _ShakeGuard=67, _BlowGuard=67}},
    [9939]={"w","Volucrine Hardshield",{_WeightRate=50, _PhysicalAttack=253, _ShakeGuard=67, _BlowGuard=67}},
    [9940]={"w","Volucrine Hardshield",{_WeightRate=50, _PhysicalAttack=306, _ShakeGuard=67, _BlowGuard=67}},
    [9941]={"w","Smithed Ancestral Shield",{_WeightRate=50, _PhysicalAttack=359, _ShakeGuard=67, _BlowGuard=67}},
    [9942]={"w","Ancestral Shield",{_WeightRate=50, _PhysicalAttack=359, _ShakeGuard=67, _BlowGuard=67}},
    [9943]={"w","Ancestral Shield",{_WeightRate=50, _PhysicalAttack=388, _ShakeGuard=67, _BlowGuard=67}},
    [9944]={"w","Smithed Spiralscale Shield",{_WeightRate=50, _PhysicalAttack=559, _ShakeGuard=67, _BlowGuard=67}},
    [9945]={"w","Spiralscale Shield",{_WeightRate=50, _PhysicalAttack=559, _ShakeGuard=67, _BlowGuard=67}},
    [9946]={"w","Spiralscale Shield",{_WeightRate=50, _PhysicalAttack=588, _ShakeGuard=67, _BlowGuard=67}},
    [9947]={"w","Spiralscale Shield",{_WeightRate=50, _PhysicalAttack=588, _ShakeGuard=67, _BlowGuard=67}},
    [10314]={"a","Spirit-Tree Helm",{_WeightRate=50, _PhysicalDefence=64, _MagicDefence=56}},
    [10315]={"a","Wintertide Parka",{_WeightRate=50, _PhysicalDefence=40, _MagicDefence=42}},
    [10316]={"a","Smithed Band of Equilibrium",{_WeightRate=50, _PhysicalDefence=43, _MagicDefence=37}},
    [10317]={"a","Smithed Prophetic Diadem",{_WeightRate=50, _PhysicalDefence=55, _MagicDefence=46}},
    [10318]={"a","Enigma Chain",{_WeightRate=50, _PhysicalDefence=42, _MagicDefence=47}},
    [10319]={"a","Smithed Warding Hood",{_WeightRate=50, _PhysicalDefence=52, _MagicDefence=60}},
    [10321]={"a","Smithed Ashen-White Hood",{_WeightRate=50, _PhysicalDefence=55, _MagicDefence=47}},
    [10322]={"a","Smithed Band of Requiem",{_WeightRate=50, _PhysicalDefence=44, _MagicDefence=42}},
    [10323]={"a","Smithed Feathercrown of Folly",{_WeightRate=50, _PhysicalDefence=64, _MagicDefence=55}},
    [10324]={"a","Firewhorl Headband",{_WeightRate=50, _PhysicalDefence=40, _MagicDefence=43}},
    [10326]={"a","Smithed Thermal Bevor",{_WeightRate=50, _PhysicalDefence=44, _MagicDefence=40}},
    [10327]={"a","Smithed Rivet-Studded Circlet",{_WeightRate=50, _PhysicalDefence=37, _MagicDefence=31}},
    [10328]={"a","Smithed Duskplume Headband",{_WeightRate=50, _PhysicalDefence=36, _MagicDefence=33}},
    [10329]={"a","Smithed Oathtaker's Hood",{_WeightRate=50, _PhysicalDefence=40, _MagicDefence=51}},
    [10330]={"a","Smithed Inkleaf Circlet",{_WeightRate=50, _PhysicalDefence=33, _MagicDefence=44}},
    [10331]={"a","Rivet-Studded Circlet",{_WeightRate=50, _PhysicalDefence=37, _MagicDefence=32}},
    [10332]={"a","Duskplume Headband",{_WeightRate=50, _PhysicalDefence=37, _MagicDefence=33}},
    [10333]={"a","Inkleaf Circlet",{_WeightRate=50, _PhysicalDefence=34, _MagicDefence=45}},
    [10334]={"a","Rivet-Studded Circlet",{_WeightRate=50, _PhysicalDefence=38, _MagicDefence=33}},
    [10335]={"a","Duskplume Headband",{_WeightRate=50, _PhysicalDefence=38, _MagicDefence=34}},
    [10336]={"a","Inkleaf Circlet",{_WeightRate=50, _PhysicalDefence=35, _MagicDefence=46}},
    [10340]={"a","Thermal Bevor",{_WeightRate=50, _PhysicalDefence=45, _MagicDefence=41}},
    [10341]={"a","Band of Equilibrium",{_WeightRate=50, _PhysicalDefence=44, _MagicDefence=38}},
    [10342]={"a","Oathtaker's Hood",{_WeightRate=50, _PhysicalDefence=39, _MagicDefence=52}},
    [10343]={"a","Feathercrown of Folly",{_WeightRate=50, _PhysicalDefence=64, _MagicDefence=55}},
    [10344]={"a","Thermal Bevor",{_WeightRate=50, _PhysicalDefence=47, _MagicDefence=43}},
    [10345]={"a","Band of Equilibrium",{_WeightRate=50, _PhysicalDefence=46, _MagicDefence=41}},
    [10346]={"a","Oathtaker's Hood",{_WeightRate=50, _PhysicalDefence=43, _MagicDefence=54}},
    [10347]={"a","Feathercrown of Folly",{_WeightRate=50, _PhysicalDefence=64, _MagicDefence=55}},
    [10348]={"a","Ashen-White Hood",{_WeightRate=50, _PhysicalDefence=56, _MagicDefence=48}},
    [10349]={"a","Prophetic Diadem",{_WeightRate=50, _PhysicalDefence=56, _MagicDefence=47}},
    [10350]={"a","Warding Hood",{_WeightRate=50, _PhysicalDefence=53, _MagicDefence=62}},
    [10351]={"a","Band of Requiem",{_WeightRate=50, _PhysicalDefence=44, _MagicDefence=42}},
    [10352]={"a","Ashen-White Hood",{_WeightRate=50, _PhysicalDefence=57, _MagicDefence=51}},
    [10353]={"a","Prophetic Diadem",{_WeightRate=50, _PhysicalDefence=57, _MagicDefence=51}},
    [10354]={"a","Warding Hood",{_WeightRate=50, _PhysicalDefence=55, _MagicDefence=63}},
    [10355]={"a","Band of Requiem",{_WeightRate=50, _PhysicalDefence=44, _MagicDefence=43}},
    [10356]={"a","Coroin Seaca",{_WeightRate=50, _PhysicalDefence=57, _MagicDefence=63}},
    [10357]={"a","Rapacious Jaws",{_WeightRate=50, _PhysicalDefence=60, _MagicDefence=54}},
    [10358]={"a","Glacial Antlers",{_WeightRate=50, _PhysicalDefence=67, _MagicDefence=54}},
    [10359]={"a","Moonskin Crown",{_WeightRate=50, _PhysicalDefence=62, _MagicDefence=70}},
    [10360]={"a","Tribe-Lord's Horns",{_WeightRate=50, _PhysicalDefence=40, _MagicDefence=24}},
    [10361]={"a","Tribe-Lord's Horns",{_WeightRate=50, _PhysicalDefence=41, _MagicDefence=24}},
    [10362]={"a","Sacrificial Twine",{_WeightRate=50, _PhysicalDefence=32, _MagicDefence=48}},
    [10363]={"a","Sacrificial Twine",{_WeightRate=50, _PhysicalDefence=33, _MagicDefence=49}},
    [10364]={"a","Talisman Band",{_WeightRate=50, _PhysicalDefence=29, _MagicDefence=39}},
    [10365]={"a","Talisman Band",{_WeightRate=50, _PhysicalDefence=30, _MagicDefence=41}},
    [10366]={"a","Smithed Frost-Hunter's Band",{_WeightRate=50, _PhysicalDefence=31, _MagicDefence=22}},
    [10367]={"a","Frost-Hunter's Band",{_WeightRate=50, _PhysicalDefence=31, _MagicDefence=22}},
    [10368]={"a","Frost-Hunter's Band",{_WeightRate=50, _PhysicalDefence=33, _MagicDefence=25}},
    [10369]={"a","Smithed Hood of the Inextant",{_WeightRate=50, _PhysicalDefence=56, _MagicDefence=53}},
    [10370]={"a","Hood of the Inextant",{_WeightRate=50, _PhysicalDefence=56, _MagicDefence=53}},
    [10371]={"a","Hood of the Inextant",{_WeightRate=50, _PhysicalDefence=57, _MagicDefence=54}},
    [10372]={"a","Smithed Talisman Band",{_WeightRate=50, _PhysicalDefence=29, _MagicDefence=39}},
    [10411]={"a","Hibernal Armor",{_WeightRate=50, _PhysicalDefence=137, _MagicDefence=179}},
    [10412]={"a","Leoithne Cuirass",{_WeightRate=50, _PhysicalDefence=118, _MagicDefence=209}},
    [10413]={"a","Smithed Swifthunt Half-Jacket",{_WeightRate=50, _PhysicalDefence=109, _MagicDefence=129}},
    [10414]={"a","Smithed Windclad Deel",{_WeightRate=50, _PhysicalDefence=118, _MagicDefence=158}},
    [10415]={"a","Gown of the Matriarch",{_WeightRate=50, _PhysicalDefence=124, _MagicDefence=230}},
    [10416]={"a","Smithed Sovran-Sigil Robe",{_WeightRate=50, _PhysicalDefence=113, _MagicDefence=209}},
    [10417]={"a","Winged Wisdom Dress",{_WeightRate=50, _PhysicalDefence=104, _MagicDefence=152}},
    [10418]={"a","Smithed Ancient Kingdom Plate",{_WeightRate=50, _PhysicalDefence=125, _MagicDefence=153}},
    [10419]={"a","Smithed Diametric Armor",{_WeightRate=50, _PhysicalDefence=105, _MagicDefence=127}},
    [10420]={"a","Smithed Shrieking Armor",{_WeightRate=50, _PhysicalDefence=131, _MagicDefence=188}},
    [10421]={"a","Hearthwarm Anorak",{_WeightRate=50, _PhysicalDefence=90, _MagicDefence=136}},
    [10423]={"a","Smithed Northbound Cuirass",{_WeightRate=50, _PhysicalDefence=113, _MagicDefence=123}},
    [10424]={"a","Smithed Raider's Tunic",{_WeightRate=50, _PhysicalDefence=96, _MagicDefence=84}},
    [10425]={"a","Smithed Snowraven Vest",{_WeightRate=50, _PhysicalDefence=93, _MagicDefence=88}},
    [10426]={"a","Smithed Robe of Hallowing",{_WeightRate=50, _PhysicalDefence=96, _MagicDefence=187}},
    [10427]={"a","Smithed Indigo Coat",{_WeightRate=50, _PhysicalDefence=78, _MagicDefence=158}},
    [10428]={"a","Raider's Tunic",{_WeightRate=50, _PhysicalDefence=97, _MagicDefence=86}},
    [10429]={"a","Snowraven Vest",{_WeightRate=50, _PhysicalDefence=94, _MagicDefence=90}},
    [10430]={"a","Indigo Coat",{_WeightRate=50, _PhysicalDefence=79, _MagicDefence=160}},
    [10431]={"a","Raider's Tunic",{_WeightRate=50, _PhysicalDefence=99, _MagicDefence=89}},
    [10432]={"a","Snowraven Vest",{_WeightRate=50, _PhysicalDefence=95, _MagicDefence=93}},
    [10433]={"a","Indigo Coat",{_WeightRate=50, _PhysicalDefence=81, _MagicDefence=164}},
    [10434]={"a","Northbound Cuirass",{_WeightRate=50, _PhysicalDefence=114, _MagicDefence=125}},
    [10435]={"a","Swifthunt Half-Jacket",{_WeightRate=50, _PhysicalDefence=110, _MagicDefence=131}},
    [10436]={"a","Robe of Hallowing",{_WeightRate=50, _PhysicalDefence=97, _MagicDefence=189}},
    [10437]={"a","Shrieking Armor",{_WeightRate=50, _PhysicalDefence=131, _MagicDefence=188}},
    [10438]={"a","Northbound Cuirass",{_WeightRate=50, _PhysicalDefence=115, _MagicDefence=128}},
    [10439]={"a","Swifthunt Half-Jacket",{_WeightRate=50, _PhysicalDefence=112, _MagicDefence=133}},
    [10440]={"a","Robe of Hallowing",{_WeightRate=50, _PhysicalDefence=98, _MagicDefence=190}},
    [10441]={"a","Shrieking Armor",{_WeightRate=50, _PhysicalDefence=131, _MagicDefence=188}},
    [10442]={"a","Hearthwarm Anorak",{_WeightRate=50}},
    [10443]={"a","Sageleaf Vestment",{_WeightRate=50, _PhysicalDefence=120, _MagicDefence=205}},
    [10444]={"a","Ancient Kingdom Plate",{_WeightRate=50, _PhysicalDefence=127, _MagicDefence=156}},
    [10445]={"a","Windclad Deel",{_WeightRate=50, _PhysicalDefence=119, _MagicDefence=160}},
    [10446]={"a","Sovran-Sigil Robe",{_WeightRate=50, _PhysicalDefence=114, _MagicDefence=211}},
    [10447]={"a","Diametric Armor",{_WeightRate=50, _PhysicalDefence=106, _MagicDefence=129}},
    [10448]={"a","Ancient Kingdom Plate",{_WeightRate=50, _PhysicalDefence=130, _MagicDefence=161}},
    [10449]={"a","Windclad Deel",{_WeightRate=50, _PhysicalDefence=122, _MagicDefence=163}},
    [10450]={"a","Sovran-Sigil Robe",{_WeightRate=50, _PhysicalDefence=116, _MagicDefence=213}},
    [10451]={"a","Diametric Armor",{_WeightRate=50, _PhysicalDefence=108, _MagicDefence=132}},
    [10452]={"a","Conqueror's Steelhide",{_WeightRate=50, _PhysicalDefence=139, _MagicDefence=162}},
    [10453]={"a","Frost-Sigil Silvermail",{_WeightRate=50, _PhysicalDefence=139, _MagicDefence=175}},
    [10454]={"a","Plumes of Niflhel",{_WeightRate=50, _PhysicalDefence=126, _MagicDefence=228}},
    [10455]={"a","Indurate Chains",{_WeightRate=50, _PhysicalDefence=102, _MagicDefence=69}},
    [10456]={"a","Indurate Chains",{_WeightRate=50, _PhysicalDefence=104, _MagicDefence=72}},
    [10457]={"a","Gravecloth Wrap",{_WeightRate=50, _PhysicalDefence=72, _MagicDefence=167}},
    [10458]={"a","Gravecloth Wrap",{_WeightRate=50, _PhysicalDefence=73, _MagicDefence=170}},
    [10459]={"a","Highland Coat",{_WeightRate=50, _PhysicalDefence=64, _MagicDefence=113}},
    [10460]={"a","Highland Coat",{_WeightRate=50, _PhysicalDefence=67, _MagicDefence=117}},
    [10461]={"a","Smithed Norgandian Tunic",{_WeightRate=50, _PhysicalDefence=78, _MagicDefence=61}},
    [10462]={"a","Norgandian Tunic",{_WeightRate=50, _PhysicalDefence=78, _MagicDefence=61}},
    [10463]={"a","Norgandian Tunic",{_WeightRate=50, _PhysicalDefence=81, _MagicDefence=63}},
    [10464]={"a","Smithed Deviant Battle Garb",{_WeightRate=50, _PhysicalDefence=120, _MagicDefence=173}},
    [10465]={"a","Deviant Battle Garb",{_WeightRate=50, _PhysicalDefence=120, _MagicDefence=173}},
    [10466]={"a","Deviant Battle Garb",{_WeightRate=50, _PhysicalDefence=121, _MagicDefence=175}},
    [10467]={"a","Smithed Highland Coat",{_WeightRate=50, _PhysicalDefence=64, _MagicDefence=113}},
    [10469]={"a","Lost-Arts Gambeson",{_WeightRate=50, _PhysicalDefence=81, _MagicDefence=67}},
    [10470]={"a","Arcuate Magus Coat",{_WeightRate=50, _PhysicalDefence=66, _MagicDefence=115}},
    [10471]={"a","Supernal Armor",{_WeightRate=50, _PhysicalDefence=153, _MagicDefence=252}},
    [10472]={"a","Lost-Arts Gambeson - Crimson",{_WeightRate=50, _PhysicalDefence=81, _MagicDefence=67}},
    [10473]={"a","Lost-Arts Gambeson - Indigo",{_WeightRate=50, _PhysicalDefence=81, _MagicDefence=67}},
    [10474]={"a","Arcuate Magus Coat - Crimson",{_WeightRate=50, _PhysicalDefence=66, _MagicDefence=115}},
    [10475]={"a","Arcuate Magus Coat - Indigo",{_WeightRate=50, _PhysicalDefence=66, _MagicDefence=115}},
    [10513]={"a","Girdle of Sagacity",{_WeightRate=50, _PhysicalDefence=123, _MagicDefence=165}},
    [10515]={"a","Smithed Infiltrator's Hosen",{_WeightRate=50, _PhysicalDefence=139, _MagicDefence=128}},
    [10516]={"a","Smithed Spectral-Hide Hosen",{_WeightRate=50, _PhysicalDefence=192, _MagicDefence=161}},
    [10518]={"a","Smithed Fiend Tramplers",{_WeightRate=50, _PhysicalDefence=186, _MagicDefence=214}},
    [10520]={"a","Smithed Argent Cuisses",{_WeightRate=50, _PhysicalDefence=205, _MagicDefence=156}},
    [10521]={"a","Smithed Two-Tone Chausses",{_WeightRate=50, _PhysicalDefence=167, _MagicDefence=161}},
    [10522]={"a","Smithed Boots of the Damned",{_WeightRate=50, _PhysicalDefence=222, _MagicDefence=187}},
    [10523]={"a","Stormproof Boots",{_WeightRate=50, _PhysicalDefence=118, _MagicDefence=155}},
    [10525]={"a","Smithed Coldmarch Cuisses",{_WeightRate=50, _PhysicalDefence=144, _MagicDefence=137}},
    [10526]={"a","Smithed Skirmisher's Breeches",{_WeightRate=50, _PhysicalDefence=115, _MagicDefence=99}},
    [10527]={"a","Smithed Cragsman's Boots",{_WeightRate=50, _PhysicalDefence=111, _MagicDefence=104}},
    [10528]={"a","Smithed Snowskip Skirt",{_WeightRate=50, _PhysicalDefence=135, _MagicDefence=174}},
    [10529]={"a","Smithed Whitesilk Breeches",{_WeightRate=50, _PhysicalDefence=103, _MagicDefence=124}},
    [10530]={"a","Skirmisher's Breeches",{_WeightRate=50, _PhysicalDefence=116, _MagicDefence=101}},
    [10531]={"a","Cragsman's Boots",{_WeightRate=50, _PhysicalDefence=112, _MagicDefence=106}},
    [10532]={"a","Whitesilk Breeches",{_WeightRate=50, _PhysicalDefence=105, _MagicDefence=128}},
    [10533]={"a","Skirmisher's Breeches",{_WeightRate=50, _PhysicalDefence=120, _MagicDefence=104}},
    [10534]={"a","Cragsman's Boots",{_WeightRate=50, _PhysicalDefence=116, _MagicDefence=109}},
    [10535]={"a","Whitesilk Breeches",{_WeightRate=50, _PhysicalDefence=108, _MagicDefence=132}},
    [10536]={"a","Coldmarch Cuisses",{_WeightRate=50, _PhysicalDefence=148, _MagicDefence=138}},
    [10537]={"a","Infiltrator's Hosen",{_WeightRate=50, _PhysicalDefence=141, _MagicDefence=131}},
    [10538]={"a","Snowskip Skirt",{_WeightRate=50, _PhysicalDefence=137, _MagicDefence=177}},
    [10539]={"a","Boots of the Damned",{_WeightRate=50, _PhysicalDefence=222, _MagicDefence=187}},
    [10540]={"a","Coldmarch Cuisses",{_WeightRate=50, _PhysicalDefence=153, _MagicDefence=142}},
    [10541]={"a","Infiltrator's Hosen",{_WeightRate=50, _PhysicalDefence=145, _MagicDefence=135}},
    [10542]={"a","Snowskip Skirt",{_WeightRate=50, _PhysicalDefence=141, _MagicDefence=183}},
    [10543]={"a","Boots of the Damned",{_WeightRate=50, _PhysicalDefence=222, _MagicDefence=187}},
    [10544]={"a","Beorcan Battle-Gaiters",{_WeightRate=50, _PhysicalDefence=107, _MagicDefence=116}},
    [10545]={"a","Beorcan Battle-Gaiters",{_WeightRate=50, _PhysicalDefence=111, _MagicDefence=119}},
    [10546]={"a","Snowstrider Boots",{_WeightRate=50, _PhysicalDefence=94, _MagicDefence=93}},
    [10547]={"a","Snowstrider Boots",{_WeightRate=50, _PhysicalDefence=98, _MagicDefence=96}},
    [10548]={"a","Leacan-Eighre",{_WeightRate=50, _PhysicalDefence=215, _MagicDefence=254}},
    [10549]={"a","Smithed Snowstrider Boots",{_WeightRate=50, _PhysicalDefence=94, _MagicDefence=93}},
    [10551]={"a","Argent Cuisses",{_WeightRate=50, _PhysicalDefence=216, _MagicDefence=161}},
    [10552]={"a","Spectral-Hide Hosen",{_WeightRate=50, _PhysicalDefence=197, _MagicDefence=167}},
    [10553]={"a","Fiend Tramplers",{_WeightRate=50, _PhysicalDefence=190, _MagicDefence=220}},
    [10554]={"a","Two-Tone Chausses",{_WeightRate=50, _PhysicalDefence=167, _MagicDefence=161}},
    [10555]={"a","Argent Cuisses",{_WeightRate=50, _PhysicalDefence=216, _MagicDefence=167}},
    [10556]={"a","Spectral-Hide Hosen",{_WeightRate=50, _PhysicalDefence=202, _MagicDefence=173}},
    [10557]={"a","Fiend Tramplers",{_WeightRate=50, _PhysicalDefence=196, _MagicDefence=226}},
    [10558]={"a","Two-Tone Chausses",{_WeightRate=50, _PhysicalDefence=172, _MagicDefence=164}},
    [10559]={"a","Smithed Hunter's Snowboots",{_WeightRate=50, _PhysicalDefence=99, _MagicDefence=90}},
    [10560]={"a","Hunter's Snowboots",{_WeightRate=50, _PhysicalDefence=99, _MagicDefence=90}},
    [10561]={"a","Hunter's Snowboots",{_WeightRate=50, _PhysicalDefence=103, _MagicDefence=93}},
    [10562]={"a","Smithed Boots of Deviltry",{_WeightRate=50, _PhysicalDefence=195, _MagicDefence=196}},
    [10563]={"a","Boots of Deviltry",{_WeightRate=50, _PhysicalDefence=200, _MagicDefence=196}},
    [10564]={"a","Boots of Deviltry",{_WeightRate=50, _PhysicalDefence=205, _MagicDefence=202}},
    [10565]={"a","Unyielding Gaiters",{_WeightRate=50, _PhysicalDefence=220, _MagicDefence=164}},
    [10566]={"a","Gleipnir Greaves",{_WeightRate=50, _PhysicalDefence=229, _MagicDefence=175}},
    [10567]={"a","Sabbath Nightsilks",{_WeightRate=50, _PhysicalDefence=210, _MagicDefence=276}},
    [10569]={"a","Antiquated Cuisses",{_WeightRate=50, _PhysicalDefence=102, _MagicDefence=90}},
    [10570]={"a","Roamer's Boots",{_WeightRate=50, _PhysicalDefence=95, _MagicDefence=101}},
    [10571]={"a","Antiquated Cuisses - Crimson",{_WeightRate=50, _PhysicalDefence=102, _MagicDefence=90}},
    [10572]={"a","Antiquated Cuisses - Indigo",{_WeightRate=50, _PhysicalDefence=102, _MagicDefence=90}},
    [10573]={"a","Roamer's Boots - Crimson",{_WeightRate=50, _PhysicalDefence=95, _MagicDefence=101}},
    [10574]={"a","Roamer's Boots - Indigo",{_WeightRate=50, _PhysicalDefence=95, _MagicDefence=101}}
}

local db = json.load_file(DATA) or {}
if db.version == nil then          -- data from the test builds (before 1.0): start clean; later versions keep it
    db = {}
end
db.version = VERSION
db.slots = db.slots or {}
db.log = db.log or {}
local function save_db() json.dump_file(DATA, db) end
local function log(s)
    table.insert(db.log, os.date("%Y-%m-%d %H:%M:%S") .. "  " .. s)
    while #db.log > 40 do table.remove(db.log, 1) end
    save_db()
end
local status = "load a save"

------------------------------------------------------------------------
-- upgrade tables: a 13-entry table (4 smith types x 3 steps without bonus + the dragonforge level) for every spoil,
-- added to ItemManager._WeaponEnhanceDict / _ArmorEnhanceDict like the game's own tables. Spoils have no tables of
-- their own, so an existing entry for one of them is ours (an earlier script instance) and is replaced.
------------------------------------------------------------------------
local TD = { w = sdk.find_type_definition("app.WeaponEnhanceParam"), a = sdk.find_type_definition("app.ArmorEnhanceParam") }
local DICT = { w = "_WeaponEnhanceDict", a = "_ArmorEnhanceDict" }
local ready = { w = 0, a = 0 }
-- the smith steps underneath: no bonus, weight rate 100% (neutral). The dragonforge level's own entry has weight
-- rate 50%: the game computes (base weight + step weights) x 50%, so a forged spoil weighs half, as in the base game.
local NO_BONUS = { _WeightRate = 100 }
local function make_param(kind, id, typ, no, fields)
    local p = sdk.create_instance(TD[kind]:get_full_name()):add_ref()
    p:set_field("_ItemId", id); p:set_field("_Type", typ); p:set_field("_EnhanceNo", no)
    for k, v in pairs(fields) do p:set_field(k, v) end
    return p
end
local function aset(arr, i, v)
    if not pcall(function() arr[i] = v end) then arr:call("SetValue(System.Object, System.Int32)", v, i) end
end
local function inject_tables()
    local im = sdk.get_managed_singleton("app.ItemManager")
    if not im then return end
    local r = { w = 0, a = 0 }
    for _, kind in ipairs({ "w", "a" }) do
        local dict = im:get_field(DICT[kind])
        if not dict or (dict:call("get_Count") or 0) == 0 then return end
        for id, f in pairs(FORGE) do
            if f[1] == kind then
                local arr = sdk.create_managed_array(TD[kind], 13):add_ref()
                local i = 0
                for typ = 0, 3 do
                    for no = 0, 2 do aset(arr, i, make_param(kind, id, typ, no, NO_BONUS)); i = i + 1 end
                end
                aset(arr, 12, make_param(kind, id, ENH_UNLIMIT, 0, f[3]))
                dict:call("set_Item", id, arr)
                r[kind] = r[kind] + 1
            end
        end
    end
    ready = r
end

-- blacksmiths and the Dragonforged don't offer upgrades for spoils: while one of their menus is open
-- (TalkEventPlayer ...EnhancementNode / ...DragonForgeNode run every frame then) the game is told a spoil has no
-- upgrade data. Everywhere else the truth, because the inventory uses the same question for the upgrade marks.
local smithSeen = -100
local function smith_open() return os.clock() - smithSeen < 0.5 end
for _, m in ipairs({ "startEnhancementNode", "updateEnhancementNode", "startDragonForgeNode", "updateDragonForgeNode" }) do
    pcall(function()
        sdk.hook(sdk.find_type_definition("app.TalkEventPlayer"):get_method(m), function() smithSeen = os.clock() end,
            function(r) return r end)
    end)
end
-- item ids whose card is being built right now for an unforged copy (no upgrade rings for those)
local uiUnforged = {}
for _, m in ipairs({ "isExistWeaponEnhanceData", "isExistArmorEnhanceData" }) do
    pcall(function()
        local hideNext = false
        sdk.hook(sdk.find_type_definition("app.ItemManager"):get_method(m), function(args)
            local id = sdk.to_int64(args[3]) & 0xFFFFFFFF
            hideNext = FORGE[id] ~= nil and (uiUnforged[id] ~= nil or smith_open())
        end, function(r)
            if hideNext then hideNext = false; return sdk.to_ptr(0) end
            return r
        end)
    end)
end

------------------------------------------------------------------------
-- items: StorageMasterData._Param (StorageData)._Enhance (_Num, _Type0.._Type2), written in place.
-- A dragonforged item is upgrade level 4 with three Dragon steps, like a normal dragonforged item.
------------------------------------------------------------------------
local SM_T = sdk.find_type_definition("app.ItemManager.StorageMasterData")
local SD_T = sdk.find_type_definition("app.ItemDefine.StorageData")
local EP_T = sdk.find_type_definition("app.ItemDefine.EnhanceParam")
local OFF_ENH = SM_T:get_field("_Param"):get_offset_from_base() + SD_T:get_field("_Enhance"):get_offset_from_fieldptr()
local OFF_E = {}
for _, f in ipairs({ "_Num", "_Type0", "_Type1", "_Type2" }) do OFF_E[f] = OFF_ENH + EP_T:get_field(f):get_offset_from_fieldptr() end
local FORGED = { 4, ENH_DRAGON, ENH_DRAGON, ENH_DRAGON }
local PLAYER = "ch000000_00"

local CHARA = {}
pcall(function()
    for _, f in ipairs(sdk.find_type_definition("app.CharacterID"):get_fields()) do
        if f:is_static() then local ok, v = pcall(f.get_data, f, nil); if ok and type(v) == "number" then CHARA[v] = f:get_name() end end
    end
end)

local function list_each(list, fn)
    if not list then return end
    for i = 0, (list:call("get_Count") or 0) - 1 do
        local ok, e = pcall(list.call, list, "get_Item", i)
        if ok and e ~= nil then fn(e) end
    end
end
-- every item of every storage member (you, pawns, storage box): { md, sid, item, chara, equipped }
local function all_items()
    local im = sdk.get_managed_singleton("app.ItemManager")
    local out = {}
    if not im then return out end
    list_each(im:call("getStorageMembers"), function(cid)
        list_each(im:call("getStorageMasterList(app.CharacterID)", cid), function(md)
            local sd = md:get_field("_Param")
            if sd then
                out[#out + 1] = { md = md, sid = sd:get_field("_StorageId"), item = sd:get_field("_ItemId"),
                    chara = CHARA[cid] or tostring(cid), equipped = sd:get_field("_IsEquipped") }
            end
        end)
    end)
    return out
end
local function by_sid()
    local by = {}
    for _, it in ipairs(all_items()) do by[tostring(it.sid)] = it end
    return by
end
local function read_enh(md)
    return { md:read_byte(OFF_E._Num), md:read_byte(OFF_E._Type0), md:read_byte(OFF_E._Type1), md:read_byte(OFF_E._Type2) }
end
local function write_enh(md, e)
    md:write_byte(OFF_E._Num, e[1]); md:write_byte(OFF_E._Type0, e[2]); md:write_byte(OFF_E._Type1, e[3]); md:write_byte(OFF_E._Type2, e[4])
end

-- equipped items also live as copies in each character's EquipData; refresh them like the blacksmith does
local function push_to_equipment(mds)
    local im = sdk.get_managed_singleton("app.ItemManager")
    if not im or #mds == 0 then return end
    list_each(im:call("getStorageMembers"), function(cid)
        local ok, ed = pcall(im.call, im, "getEquipData(app.CharacterID)", cid)
        local data = ok and ed and ed:get_field("Data")
        if data then
            for _, md in ipairs(mds) do
                pcall(data.call, data, "updateEnhanceEquip(app.ItemDefine.StorageData)", md:get_field("_Param"))
            end
        end
    end)
    pcall(function() im:call("applyEquipDataForCharacter()") end)
end

------------------------------------------------------------------------
-- forge list of the loaded save: cur[storage id] = { item, name, orig = {num, t0, t1, t2} }
-- db.slots[slot] = the list as it was when that save slot was written; db.live = the current list (for script resets)
------------------------------------------------------------------------
local cur, curSlot = {}, nil
local function copy(t) local o = {}; for k, v in pairs(t) do o[k] = type(v) == "table" and copy(v) or v end; return o end
local function remember_live() db.live = { slot = curSlot, items = copy(cur) }; save_db() end

-- right after a load (before anything is applied) the items are exactly what the save file holds: a DLC spoil with
-- an upgrade there could only come from a forge that leaked into the save
local saveCheck = "save file check: no save loaded since the scripts started"
local function check_save_file(slot)
    local bad = {}
    for _, it in ipairs(all_items()) do
        local n = FORGE[it.item] and read_enh(it.md)[1] or 0
        if n ~= 0 then bad[#bad + 1] = string.format("%s (level %d)", FORGE[it.item][2], n) end
    end
    saveCheck = #bad == 0 and string.format("save file check (slot %s): clean", tostring(slot))
        or string.format("save file check (slot %s): %d DLC spoil(s) with an upgrade in the save file: %s - they are kept out on the next save",
            tostring(slot), #bad, table.concat(bad, ", "))
    if #bad > 0 then log(saveCheck) end
end
-- the game itself never upgrades a spoil, so a spoil at level 4 that isn't on the list was forged by this mod
local function adopt_untracked()
    local n = 0
    for _, it in ipairs(all_items()) do
        if FORGE[it.item] and not cur[tostring(it.sid)] and read_enh(it.md)[1] == 4 then
            cur[tostring(it.sid)] = { item = it.item, name = FORGE[it.item][2], orig = { 0, 0, 0, 0 } }
            n = n + 1
        end
    end
    return n
end
-- put the forge on every listed item (after a load and after each save)
local function apply_all()
    local by = by_sid()
    local found, changed = 0, {}
    for sid, r in pairs(cur) do
        local it = by[sid]
        if it and it.item == r.item then
            local e = read_enh(it.md)
            if e[1] ~= 4 then r.orig = r.orig or e; write_enh(it.md, FORGED); changed[#changed + 1] = it.md end
            found = found + 1
        end
    end
    push_to_equipment(changed)
    return found
end
-- take the forge off again (while the game writes a save, and when the scripts unload); returns the found entries
local function strip_all()
    local by = by_sid()
    local kept, changed = {}, {}
    for sid, r in pairs(cur) do
        local it = by[sid]
        if it and it.item == r.item then
            write_enh(it.md, r.orig or { 0, 0, 0, 0 })
            changed[#changed + 1] = it.md
            kept[sid] = copy(r)
        end
    end
    push_to_equipment(changed)
    return kept, #changed
end

local function forge(it)
    local e = read_enh(it.md)
    cur[tostring(it.sid)] = { item = it.item, name = FORGE[it.item][2], orig = e }
    write_enh(it.md, FORGED)
    push_to_equipment({ it.md })
    remember_live()
end
local function unforge(sid)
    local r = cur[sid]
    if not r then return end
    local it = by_sid()[sid]
    if it and it.item == r.item then write_enh(it.md, r.orig or { 0, 0, 0, 0 }); push_to_equipment({ it.md }) end
    cur[sid] = nil
    remember_live()
    log("undid the dragonforge of " .. tostring(r.name))
end

------------------------------------------------------------------------
-- save / load
------------------------------------------------------------------------
local pendingSave, applyAt, checkPending = nil, nil, false
pcall(function()
    sdk.hook(sdk.find_type_definition("app.SaveDataManager"):get_method("requestSave"), function(args)
        local slot = sdk.to_int64(args[3]) & 0xFFFFFFFF
        if slot < 0x80000000 then pendingSave = slot end
    end, function(r) return r end)
    local im_t = sdk.find_type_definition("app.ItemManager")
    sdk.hook(im_t:get_method("saveGameSaveData"), function()
        local kept = strip_all()
        if pendingSave then
            db.slots[tostring(pendingSave)] = kept       -- only items that still exist
            pendingSave = nil
            save_db()
        end
    end, function(r)
        apply_all()
        return r
    end)
    sdk.hook(im_t:get_method("loadGameSaveData"), nil, function(r)
        local sm = sdk.get_managed_singleton("app.SaveDataManager")
        local ok, s = pcall(function() return sm:call("getLoadingGameSlotId") end)
        curSlot = ok and s or nil
        cur = copy(db.slots[tostring(curSlot)] or {})
        db.lastSlot = curSlot
        checkPending = true
        applyAt = os.clock() + 2
        return r
    end)
end)

-- scripts unloading (Reset scripts, or the mod removed mid-session): take the forges off, so the game's memory
-- matches the save file; the next script instance puts them back from db.live
pcall(re.on_script_reset, function() pcall(strip_all) end)

local tick, firstLook = 0, true
re.on_frame(function()
    tick = tick + 1
    if ready.w + ready.a == 0 and tick % 60 == 0 then pcall(inject_tables) end
    -- started while a save is already loaded (scripts reset): continue with the live list of that slot
    if firstLook and tick > 120 then
        firstLook = false
        if #all_items() > 0 then
            curSlot = curSlot or db.lastSlot
            if db.live and db.live.slot == curSlot then cur = copy(db.live.items or {})
            else cur = copy(db.slots[tostring(curSlot)] or {}) end
            applyAt = os.clock()
        end
    end
    if applyAt and os.clock() > applyAt then
        applyAt = nil
        if checkPending then checkPending = false; pcall(check_save_file, curSlot) end
        pcall(adopt_untracked)
        local ok, n = pcall(apply_all)
        status = ok and string.format("save slot %s: %d dragonforged DLC item(s)", tostring(curSlot), n) or ("error: " .. tostring(n))
        remember_live()
    end
end)

------------------------------------------------------------------------
-- in-game notice: the game's own notice log (app.ui023301) shows an equipment notice for the forged item (its icon)
-- and our text replaces the game's: "<item> has been DRAGONFORGED!". Technique as in QuestCore by SonicaKP: let the
-- game build its UI element, then rewrite the element's text.
------------------------------------------------------------------------
local NOTICE_EQUIP = 17                -- app.ui023301.NoticeEnum.EquipStatusChange
local pendingNotice = nil
local ourNotices = {}                  -- notice address -> { item, text }
local function notify_forged(item, name)
    local gm = sdk.get_managed_singleton("app.GuiManager")
    if not gm then return false end
    pendingNotice = { item = item, text = name .. " has been <COLOR D23A2A>DRAGONFORGED</COLOR>!", untilT = os.clock() + 10 }
    return pcall(gm.call, gm, "addEquipStatusChangeNotice(System.Int32)", item)
end
pcall(function()
    local stack = {}
    sdk.hook(sdk.find_type_definition("app.ui023301.Notice"):get_method("setupText"), function(args)
        stack[#stack + 1] = sdk.to_int64(args[2])
    end, function(r)
        local addr = table.remove(stack)
        pcall(function()
            local notice = sdk.to_managed_object(addr)
            local data = notice and notice:get_field("Data")
            if not data then ourNotices[addr] = nil; return end
            local item, typ = data:get_field("ItemId"), data:get_field("NoticeType")
            local mine = ourNotices[addr]
            if mine and (mine.item ~= item or typ ~= NOTICE_EQUIP) then ourNotices[addr] = nil; mine = nil end
            local p = pendingNotice
            if not mine and p and os.clock() < p.untilT and typ == NOTICE_EQUIP and item == p.item then
                mine = { item = item, text = p.text }
                ourNotices[addr] = mine
                pendingNotice = nil
            end
            local txt = mine and notice:get_field("TxtName")
            if txt then txt:call("set_Message", mine.text) end
        end)
        return r
    end)
end)

------------------------------------------------------------------------
-- dragon kills: when a dragon-type enemy dies by the hand of you or your pawns (or, with no attacker known, within
-- 60 m of you), one random equipped, not yet dragonforged DLC spoil of yours is dragonforged.
-- Dragon types: ch257 (Drake, Lesser Dragon, Fimbl) and ch258 (Dragon, Nex, Fallen Dragon and its variants).
------------------------------------------------------------------------
local DRAGON_PREFIX = { "ch257", "ch258" }
local lastDragonKill = -100
local function is_dragon(cid)
    local n = CHARA[cid]
    if not n then return false end
    for _, p in ipairs(DRAGON_PREFIX) do if n:sub(1, #p) == p then return true end end
    return false
end
local function chara_of(go)
    if not go then return nil end
    local ok, c = pcall(go.call, go, "getComponent(System.Type)", sdk.typeof("app.Character"))
    return ok and c or nil
end
local function is_party(chara)            -- you (ch000000_00) or a pawn (ch1xxxxx)
    local ok, cid = pcall(chara.call, chara, "get_CharaID")
    local n = ok and CHARA[cid]
    return n ~= nil and (n == PLAYER or n:sub(1, 3) == "ch1")
end
local function near_player(chara, dist)
    local cm = sdk.get_managed_singleton("app.CharacterManager")
    local p = cm and cm:get_field("<ManualPlayer>k__BackingField")
    local ok1, pp = pcall(function() return p:get_GameObject():get_Transform():get_Position() end)
    local ok2, pos = pcall(function() return chara:get_GameObject():get_Transform():get_Position() end)
    if not (ok1 and ok2 and pp and pos) then return false end
    return (pos - pp):length() <= dist
end

-- dragonforge one random equipped, not yet forged DLC spoil of yours; returns its name or nil
local function forge_random(reason)
    local pick = {}
    for _, it in ipairs(all_items()) do
        if it.chara == PLAYER and it.equipped and FORGE[it.item] and not cur[tostring(it.sid)] then pick[#pick + 1] = it end
    end
    if #pick == 0 then log(reason .. " - no equipped DLC spoil left to dragonforge"); status = "no equipped DLC spoil left to dragonforge"; return nil end
    local it = pick[math.random(#pick)]
    forge(it)
    notify_forged(it.item, FORGE[it.item][2])
    status = FORGE[it.item][2] .. " has been dragonforged"
    log(reason .. " - " .. FORGE[it.item][2] .. " dragonforged")
    return FORGE[it.item][2]
end
local function on_dragon_killed(name)
    if os.clock() - lastDragonKill < 5 then return end          -- one kill, several notifications
    lastDragonKill = os.clock()
    forge_random(name .. " slain")
end

pcall(function()
    sdk.hook(sdk.find_type_definition("app.Character"):get_method("onDieFromAttack"), function(args)
        pcall(function()
            local dead = sdk.to_managed_object(args[2])
            local cid = dead:call("get_CharaID")
            if not is_dragon(cid) then return end
            local info = sdk.to_managed_object(args[3])
            local attacker = info and chara_of(info:call("get_AttackOwnerObject"))
            if (attacker and is_party(attacker)) or (not attacker and near_player(dead, 60)) then
                on_dragon_killed(CHARA[cid])
            end
        end)
    end, function(r) return r end)
end)
-- fallback: the game's own defeat counter, for dragons that die some other way
pcall(function()
    sdk.hook(sdk.find_type_definition("app.EnemyDeadCountManager"):get_method("addDeadCount"), function(args)
        pcall(function()
            local cid = sdk.to_int64(args[3]) & 0xFFFFFFFF
            if is_dragon(cid) then on_dragon_killed(CHARA[cid]) end
        end)
    end, function(r) return r end)
end)

------------------------------------------------------------------------
-- item cards (ItemIcon3Ref): one hook per card-building method remembers which item the card shows; while the card
-- of an UNFORGED spoil is built, the game is told the item has no upgrade data, so it draws no upgrade rings
------------------------------------------------------------------------
local ICON_T = sdk.find_type_definition("app.GUIBase.ItemIcon3Ref")
local cardItem = {}            -- card address -> { item }
local restore = {}             -- card address -> list of { ctrl, property, old value }
local function unhide(addr)
    local r = restore[addr]
    if not r then return end
    for i = #r, 1, -1 do pcall(r[i][1].call, r[i][1], "set_" .. r[i][2], r[i][3]) end
    restore[addr] = nil
end
local function peek(ptr)       -- item id + upgrade level of a StorageData argument
    local ok, vt = pcall(sdk.to_valuetype, ptr, "app.ItemDefine.StorageData")
    if not ok or not vt then return nil end
    local en = vt:get_field("_Enhance")
    return vt:get_field("_ItemId"), en and en:get_field("_Num") or 0
end
for _, m in ipairs(ICON_T:get_methods()) do
    local name = m:get_name()
    if name == "setup" or name == "dispCategory" then
        local okP, p1 = pcall(function() return m:get_num_params() > 0 and m:get_param_types()[1]:get_full_name() or "" end)
        if not okP then p1 = "" end
        if p1 == "app.ItemDefine.StorageData" or p1 == "app.ItemCommonParam" or p1 == "System.Int32" then
            local stack = {}
            pcall(sdk.hook, m, function(args)
                local hideFor = false
                pcall(function()
                    local addr = sdk.to_int64(args[2])
                    local item, num
                    if p1 == "app.ItemDefine.StorageData" then item, num = peek(args[3])
                    elseif p1 == "app.ItemCommonParam" then
                        local o = sdk.to_managed_object(args[3]); item = o and o:get_field("_Id")
                    else item = sdk.to_int64(args[3]) & 0xFFFFFFFF end
                    unhide(addr)
                    cardItem[addr] = item and { item = item } or nil
                    if num and num ~= 4 and FORGE[item] then
                        hideFor = item
                        uiUnforged[item] = (uiUnforged[item] or 0) + 1
                    end
                end)
                stack[#stack + 1] = hideFor
            end, function(r)
                local item = table.remove(stack)
                if item then
                    uiUnforged[item] = (uiUnforged[item] or 1) - 1
                    if uiUnforged[item] <= 0 then uiUnforged[item] = nil end
                end
                return r
            end)
        end
    end
end

-- a dragonforged spoil's card shows only the dragonforge mark: the card (ItemIcon3Ref.PnlUpgrade) has four mark
-- images; tex_UpgradeIcon2 is the dragonforge one, the other three would show smith styles and are hidden
local SMITH_MARKS = { "tex_UpgradeIcon", "tex_UpgradeIcon0", "tex_UpgradeIcon1" }
local function gui_children(ctrl)
    local out = {}
    local ok, c = pcall(ctrl.call, ctrl, "get_Child")
    local guard = 0
    while ok and c and guard < 64 do
        out[#out + 1] = c
        ok, c = pcall(c.call, c, "get_Next")
        guard = guard + 1
    end
    return out
end
local function hide_smith_marks(card, addr)
    local up = card:get_field("PnlUpgrade")
    if not up then return end
    local by = {}
    for _, c in ipairs(gui_children(up)) do
        local ok, n = pcall(c.call, c, "get_Name")
        if ok and n then by[tostring(n)] = c end
    end
    for _, n in ipairs(SMITH_MARKS) do
        local m = by[n]
        if m then
            restore[addr] = restore[addr] or {}
            table.insert(restore[addr], { m, "Visible", true })
            pcall(m.call, m, "set_Visible", false)
        end
    end
end
pcall(function()
    local pending = nil
    sdk.hook(ICON_T:get_method("setUgIcon"), function(args)
        pending = nil
        local typ = sdk.to_int64(args[4]) & 0xFFFFFFFF
        local c = cardItem[sdk.to_int64(args[2])]
        -- the dragonforge mark (type 4) is drawn last; a spoil only has marks if this mod dragonforged it
        if typ == ENH_UNLIMIT and c and c.item and FORGE[c.item] then
            pending = { card = sdk.to_managed_object(args[2]), addr = sdk.to_int64(args[2]) }
        end
    end, function(r)
        local p = pending
        pending = nil
        if p then pcall(hide_smith_marks, p.card, p.addr) end
        return r
    end)
end)

------------------------------------------------------------------------
-- menu
------------------------------------------------------------------------
re.on_draw_ui(function()
    if not imgui.tree_node("DLC Dragonforge") then return end
    imgui.text("v" .. VERSION .. "  -  " .. status)
    imgui.text(saveCheck)
    if ready.w + ready.a == 0 then imgui.text("waiting for the game's upgrade tables...") end
    imgui.text("Dragonforged in this save:")
    local any = false
    for sid, r in pairs(cur) do
        any = true
        imgui.text("  " .. tostring(r.name))
        imgui.same_line()
        if imgui.button("Undo##" .. sid) then unforge(sid) end
    end
    if not any then imgui.text("  (none yet - slay a dragon with DLC spoils equipped)") end
    if imgui.tree_node("Log") then
        for i = #db.log, 1, -1 do imgui.text(db.log[i]) end
        imgui.tree_pop()
    end
    imgui.tree_pop()
end)
