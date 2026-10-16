# Changelog

## 1.2.1
- **Online fix:** the game uploads a snapshot of your Arisen's equipment (with upgrade levels and stats) together
  with your main pawn. Earlier versions only kept the dragonforge out of the save file and off pawn items, so your own
  forged items could appear in that snapshot. Now every dragonforge is taken off while the upload is built and put
  back right after; checked in game: the uploaded data of a forged item is the same as an unforged one.
- **Save fix:** one save can write several save files (e.g. three slots at once). 1.2 could put the dragonforge back
  between them, so an extra save file could contain it. Now the whole save is guarded and the forges return only
  when it has finished.
- The menu shows an online check ("built N times from plain items, 0 leaks") next to the save file check.

## 1.2
- Three dragonforge levels like the first game: each adds a third of the bonus; the 3rd also halves the weight.
- Chances like the first game: every equipped spoil rolls on each dragon kill, by dragon type and the item's level
  (Drake 10/15/25%, Lesser Dragon 12/18/30%, Fimbl 30/40/55%, Dragon, Nex and Fallen Dragon 100%). One kill can forge
  several items; each gets its notice, with the level ("(2/3)").
- The dragonforge mark's colour shows the level: teal, orange, magenta.
- A forged item handed to a pawn counts as plain while the pawn has it (the game uploads your main pawn's equipment).
- Items forged with 1.0 / 1.1 count as level 3 (full bonus, half weight).

## 1.1
- Only the dragonforge bonus: the three smith steps the game needs underneath give no bonus any more (1.0 also
  added the bonuses of three smith upgrades). Already forged items change with it; your save is not affected.
- A dragonforged spoil weighs half its base weight (the dragonforge level's 50% weight rate, as in the base game).
- Updating from 1.0 keeps your dragonforges (only data from the pre-release test builds is reset).

## 1.0
- First release. Dragon kills dragonforge one random equipped DLC spoil (appraised or Smithed weapon, shield,
  helmet, body or leg armour) of your character; the game's notice announces it; the dragonforge stays out of the
  save file (per-slot list in reframework/data/DLCDragonforge.json).
