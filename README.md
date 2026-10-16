# DLC Dragonforge

A Dragon's Dogma 2 mod (REFramework Lua script) that brings back **dragonforging from the first game** for the
**Dark Arisen DLC spoils**.

In the DLC, appraised spoils (Lv 1 to 5) and their Smithed versions can't be enhanced or dragonforged at all. With this
mod, every time **you or your pawns slay a dragon-type enemy**, one random piece of DLC spoil gear you have equipped is
dragonforged, like in Dragon's Dogma (2012).

- **Which dragons:** Drake, Lesser Dragon, Fimbl, Dragon, Nex and Fallen Dragon (and their variants).
- **What gets forged:** one random equipped, not yet dragonforged DLC spoil of your own character: weapon, shield,
  helmet, body or leg armour. Cloaks and rings can't be upgraded in the base game either, so they're left out.
  Your pawns' gear is not touched.
- **What it does to the item:** it becomes a real dragonforged item with the dragonforge mark on its card. The game
  only allows the dragonforge level on top of three smith upgrade steps, so the mod fills those in **without any
  bonus**: the item only gets what dragonforging itself adds. That bonus is scaled from the game's own tables for the
  DLC weapons and armour that *can* be upgraded, by weapon type and armour slot:

  | Type | Dragonforge bonus |
  |---|---|
  | Sword / Greatsword / Daggers / Bow | Strength +36% / +32% / +43% / +39% |
  | Magick bow | Magick +30% |
  | Staff / Archistaff | Magick +30% (Strength +73% / +91% on a small base) |
  | Duospear | Strength +34%, Magick +34% |
  | Censer | Magick +35% (Strength +60%) |
  | Shield | Strength +59%, more guard against stagger and knockdown |
  | Helmet / Body / Legs | Defence +21% / +27% / +64%, Magick Defence +23% / +43% / +75% |

  The item also becomes **half as heavy**, like dragonforging in the base game. For example, Rimed Needle goes from
  940 to about 1280 Strength and from 2.5 to 1.25 weight.
- **The game's own notice** tells you: "*Rimed Needle* has been **DRAGONFORGED**!" with the item's icon.
- Base-game gear and the DLC items that can already be upgraded are not changed. Blacksmiths still can't upgrade
  spoils: only dragons forge them. A dragonforged spoil's card shows only the dragonforge mark (the three upgrade
  slots before it would otherwise show smith-style marks).

## Your save file stays clean

The dragonforge is **never written into your save file**. The mod keeps its own list per save slot in
`reframework/data/DLCDragonforge.json`. While the game writes a save, the mod takes the dragonforge off the items and
puts it back right after. When you load a save, the mod puts back the dragonforges that belong to that save.

- Every save keeps its own state, like in the first game: load an Inn save from before a dragon fight and that item is
  not forged there; load a later save and it is.
- Different characters never mix: each save file has its own list.
- **Uninstalling:** with the mod removed, your DLC items are plain DLC items again. Remove it **with the game closed**.
- On every load the menu shows a "save file check" that confirms no DLC spoil in the save carries an upgrade.

Current version: **1.1**. Download it from [Releases](../../releases).

## Requirements

| What | Needed? | Why |
|---|---|---|
| Dragon's Dogma 2 (PC) with the Dark Arisen DLC | Required | Tested on DD2.exe 4.0.0.0 (Steam build 25290080). |
| [REFramework](https://github.com/praydog/REFramework) by praydog | **Required** | Loads the Lua script (`dinput8.dll` in the game folder). |

No other mods are needed. No game files are included or replaced.

## Install

1. Install REFramework.
2. Copy the `reframework` folder from this repository (or the release zip) into your Dragon's Dogma 2 folder, next to
   `DD2.exe`, merging folders. Fluffy Mod Manager can install the release zip directly.
3. Start the game. Back up your saves before trying any new mod.

## Menu

Press **Insert** → *Script Generated UI* → **DLC Dragonforge**:

- which DLC items are dragonforged in the loaded save (with an Undo button each)
- the save file check
- a short log of dragon kills and forges

## Uninstall

With the game closed, delete `reframework/autorun/DLCDragonforge.lua` (and `reframework/data/DLCDragonforge.json`).

## Known limits

- Single-player: only your own character's equipped items are forged.
- One item per dragon kill.
- Kills count when you or a pawn land the killing blow; a dragon that dies without an attacker counts when it is
  within 60 m of you.

## Credits

- **Capcom** for Dragon's Dogma 2. The upgrade tables, marks and notices used are the game's own.
- **praydog** for [REFramework](https://github.com/praydog/REFramework).
- **SonicaKP** for [QuestCore](https://www.nexusmods.com/dragonsdogma2/mods/1662): the idea of letting the game build its
  own notice and rewriting its text came from there.
- Built with AI assistance: [Claude Code](https://claude.com/claude-code) and the
  [universal-modder](https://github.com/rehan-remade/universal-modder) toolkit by rehan-remade.
