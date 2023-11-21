# Noah: The Apocalypse Expansion Design Notes

### Noah [Character]
1 heart + 1 soul heart  
Nerfed damage scaling (x0.85 - x0.9?)  
2 luck

- Gains increased fire rate (~1.25x?) when the room is flooded.  
- Holds Deluge as a pocket active [see below]  
- Has innate Shepherd's Crook [see below]  

```
Scripting: In Progress
Menu Graphics: Not Started
Character Costume: Not Started
Boss Intro Graphics: Not Started
```

---

### Deluge [Active Item]
3 room charge

- Fills the room with water
- Kills enemies in the room so that there are only 2 enemies of any given type
  - Enemies without a pair will die
  - Enemy types with more than 2 will be randomly killed, only leaving 2
- Does not effect bosses

```
Scripting: Testable
Item Sprite: Not Started
Item Activation Graphic: Not Started
SFX: Not Started
```

---

### Tainted Noah [Character]

Starts with a one-time use item, Progeny. While Progeny is held, Tainted Noah has very high stats, capable of tearing through most of the early floors in the game. These stats wear off over time, and Tainted Noah visibly ages as time passes.

While Progeny is held, Tainted Noah can pick up passive items, but they do not do anything. He must rely on the base stats to collect as many items as possible.

When Progeny is used, the run restarts with a young Tainted Noah. This Noah no longer holds Progeny and has reduced stats across the board (75% multiplier?). Tainted Noah now can use all of the passive items that have been collected during the first phase of the run.

```
Scripting: In Progress
Menu Graphics: Not Started
Character Costume: Not Started
Boss Intro Graphics: Not Started
```

---

### Progeny [Passive Item]
*"Pass on your inheritance"*  

+1 Damage

- After completing a floor, a random passive item with quality less than 3 is removed.
- All removed items will be given to the next run.

---

### Shepherd's Crook [Passive Item] 
*"Be fruitful and multiply"*

Gives a luck-based chance to fire a tear that splits enemies in two, similar to Meat Cleaver.

```
Scripting: In Progress
Item Sprite: Not Started
Tear Sprite: Not Started
```

---

### Plank of the Ark [Passive Item]

- Tear-blocking orbital, orbits relatively far away from the player.
- Gain another plank for each boss defeated without taking damage.
- When a plank touches fire, it lights, dealing contact damage for the rest of the room and lighting enemies it touches on fire.

```
Scripting: Not Started
Item Sprite: Not Started
Orbital Sprite: Not Started
```

---

### Pawn Shop [Machine]

- Shop that can rarely replace Donation Machines. Interacting with it will sell your trinket and pocket items (cards, runes, etc.). - Chance to explode on use.
- When blown up or exploded via usage, the machine can drop coins, trinkets, and pocket items.

```
Scripting: Not Started
Sprite: Not Started
```

---

### Soul of Noah [Rune]

- Triggers Deluge and Noah's increased fire rate for the rest of the room. Grants 8 (?) stacks of Plank of the Ark for the rest of the room.
- If this is used in a boss room, and the boss is defeated without taking damage, gain a permanent plank. (This plank will NOT cause more to be created from future bosses)

```
Scripting: Not Started
Sprite: Not Started
```

---

### Glowing Pocket Watch [Trinket]

10%(?) chance to trigger the glowing hourglass effect upon taking damage from an enemy. Can only trigger once per unique room (cannot retry a room multiple times).

```
Scripting: Not Started
Sprite: Complete!
```

---

### ?? [Active Item]

Leaves something behind on the ground that can be summoned back to Isaac

Needle and Thread?

---

### ?? [Passive Item]

Inverts the effect of curses, causing them to be floor-long buffs:

- Curse of the Blind: Guppy's Eye and reveal alt-path unknown items
- Curse of Darkness: 
- Curse of the Lost: Reveal the map
- Curse of the Maze: Entering an unexplored room has a chance to teleport Isaac to a red room
- Curse of the Unknown: See health bars of enemies
- Curse of the Labyrinth: Normally sized floor, guarantee that a 5-pip dice room spawns on the floor.

---

### Hearthstone Cards

---


