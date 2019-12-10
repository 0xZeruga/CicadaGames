#### CicadaGames

### Introduction
CicadaGames is a decentralized gaming platform with the goal to revolutionize the blockchain space by enabling game developers to hook their own
smart contracts to our mothercontract and thereby interact in the same token economy and get free webhosting for frontend and publishing.
There are two currencies on the CicadaNetwork, one being a CicadaTokens, an ERC20 Token with a real-life value which is used for more
demanding functionality aswell as gold which is an ingame currency that player can earn by defeating AI-monsters.

The first game is aimed to be a collective cardgame where people collect creatures, attack other players/monsters in order to earn levels
and gold. The background will be a static image of a medieval town with some interactivity.

Each player has an UI with a list of all their creatures. By pressing on a creature they will get a new window with a bigger picture of the creature,
displaying stats such as health, damage, accuracy, evasion, level, tier and item slots for head, chest, legs, feet, mainhand and offhand.

### Attributes
Health: The amount of damage a creature can take before they end up in the Graveyard.
Damage: The amount of damage a creature can inflict on others.
Accuracy: The chance of hitting another creature.
Evasion: The chance of evading an attacking creature's attack.

Level displays how experienced a creature is and increases all basestats depending on the creatures tier and attribute modifier. One creature
may for instance be a real heavyhitter, but have a very hard time hitting their enemy, ex. Damage 10, Accuracy 2. This means that the
creature's Damage will increase by 10 per level but accuracy only by 2 (this is an extreme example, in reality this values would be much closer).

Health/Damage/Accuracy/Evasion = Attributebase * Tier * Level

However, a creature also have a chance to spawn with gear that improve their stats for helm, chest, legs, boots, mainhand and offhand.
All this is randomized by the bit values of a uint in relation to timestamp of blockproduction, or other data that may be of value.

Seed Id: 1111 1111 1111 1111
Tier Seed: 0000 0000 0000 0011 (1-99)
In-tier Seed: 0000 0000 0000 1100 (1-99)

Helm-tier: 0000 0000 0001 0000 (1-9)
Chest-tier: 0000 0000 0010 0000 (1-9)
Legs-tier: 0000 0000 0100 0000 (1-9) 
Boots-tier: 0000 0000 1000 0000 (1-9)
MainHand: 0000 0011 0000 0000 (1-99)
OffHand: 0000 1100 0000 0000 (1-99)
Level: 0011 0000 0000 0000 (1-99)

Just as the creature themselves each gearpiece is generated at separate tiers: common, uncommon, rare, epic and mythic. Granting more bonuses
for each tier and outlining the frame with white, green, blue, purple or orange border.

### City
In the city the player have multiple buildings that each start at level 1 granting basic functionality. Upgrading the buildings cost
Cicada Tokens.

Blacksmith -> Enables reroll of item tiers up to the itemlevel of the level of the blacksmith costs gold

Bar -> Recruit a new creature by the bar and earn a positive modifier to roll more rare creatures the higher the rank of the bar.

Arcanist -> Rerolls a creature with a positive modifier for every tier of the arcanist.

Mad Scientist -> Create a clone of a PvP creature you have slain. Each Scientist level enables a higher tier to be cloned. Costs a mixture of
  Cicada Tokens and Gold

Arena -> Attack PvE creatures. The higher level of the area, the more challenging creatures the owners can afford to bring in. Winning
  improves level and earns the player gold.
  
Hospital -> Heal a creature, the amount of healing increases by tier level of the hospital.
  
Graveyard -> Resurrect creatures up to a specific tier for CicadaTokens.

Market -> Auction a champion for gold or CicadaTokens to other players. Auction taxes 2% of the total price. 

Upgradable buildings costs approximatly 0.001 eth per tier (0.002+0.003+0.004+0.005 = 0.014 eth = 0.2$ per building maxupgraded in time of
  writing).

### Combat
PvP: A player attack a creature that must have the same level or higher as the creature attacking. A weighed random roll is created by comparing
  the attackers Accuracy to the Defenders Evasion. If the defender fail they take damage, if not the attacker takes damage. If any of the creatures
  health go below 0, they are sent to the graveyard. If the gear bits in any slot is higher for the dying creature than the winner. The loser will
  be stripped of their gear and the bits added to the winner. If they win, they earn a level and potentionally better gear. Attacking a player
  cost a tiny amount of cicada.

PvE: A player pay a tiny amount of Cicada to enter the arena against a monster which has premade stats. If they win, they earn gold and a level.
  If they die they are sent to the graveyard, with their gear.
  
In both PvE and PvP combat both creatures remain alive but with little health if the amount of damage isnt enough to kill of either of them.
 
## Critical priorities
Enable randomness by Oracle (critical but not urgent)
Create Character Selection UI.
Create Character Detail UI.
Create Auction Smart Contract.
Create Builds Smart Contract.
Create Gear Library.
Create Creature Library.
Create CicadaToken Smart Contract.
Create Attacking Functionality.
Create Healing Functionality.
Create Recruiting Functionality.
Create Blacksmith Functionality.
Create Arcanist Functionality.
Create Mad Scientist Functionality.
Create Resurrection Functilaity.

## Moderate priorites
Make/find a picture which contains all elements of the city.
Finish the sprite animation renderer.
Filter the 936 creature images to choose which ones to use. https://docs.google.com/spreadsheets/d/1V-rn40dYmb5Da2hNzrCGENrYxbt1ms5XDr5ClYLXnKg/edit?folder=0ABL_kzJhkBDRUk9PVA#gid=0
Sort the creatures into tiers and determine their base attribute mods.
Find images for head, chest, legs, boots, offhand and mainhand sprites (10 each for all except off/mainhand which has 20).

## Wishlist (no current priority)
Set defenders for incoming attacks.
Attack with multiple attackers.

## Inspiration
CryptoZombies
MagicTheGathering
Diablo2


