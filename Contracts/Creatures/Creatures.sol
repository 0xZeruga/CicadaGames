pragma solidity >=0.5.0 <0.6.0;

import "../GameLogic/Helper.sol";


contract Creatures is Helper {

   function getCreatureMold(string memory _dnaID) public pure returns (uint healthMod,
   uint damageMod, uint accuracyMod, uint evasionMod, uint tier, uint element, uint fightingstyle) {
      require(bytes(_dnaID).length == 3, "ID length doesn't match");

      /*
      Element
      1       2      3          4       5                      0
      Earth > Fire > Contruct > Water > Lightning > earth    Neutral
      6        7        8        9
      Arcane > Cosmic > Divine > Abyssal > arcane

      */

      /*
      Fighting Style 3421
      1      2         3          4
      Tank < Caster < Assassin < Bruiser
      */

   /*
   Common
   */

  //Abyssal
   if(compareStrings(_dnaID, "001")) {return (3, 5, 8, 4, 5, 9, 3);}//Soulsearcher
   if(compareStrings(_dnaID, "002")) {return (5, 4, 4, 6, 5, 9, 4);}//Gargoyle
   if(compareStrings(_dnaID, "003")) {return (4, 8, 5, 3, 5, 9, 2);}//Bloodmancer
   if(compareStrings(_dnaID, "004")) {return (11, 4, 3, 2, 5, 9, 1);}//Ghoul

  //Arcane
   if(compareStrings(_dnaID, "005")) {return (3, 7, 7, 3, 5, 6, 3);}//Cursed Book
   if(compareStrings(_dnaID, "006")) {return (3, 4, 5, 8, 5, 6, 4);}//Witch's Familiar
   if(compareStrings(_dnaID, "007")) {return (4, 6, 5, 5, 5, 6, 2);}//Witch Adept
   if(compareStrings(_dnaID, "008")) {return (10, 4, 4, 2, 5, 6, 1);}//Animated pumpkin

  //Construct
   if(compareStrings(_dnaID, "009")) {return (2, 6, 6, 6, 5, 3, 3);}//Mechatron Assault Eagle
   if(compareStrings(_dnaID, "010")) {return (5, 5, 5, 5, 5, 3, 4);}//Mechatron Slicer
   if(compareStrings(_dnaID, "011")) {return (6, 8, 4, 2, 5, 3, 2);}//Nanotron
   if(compareStrings(_dnaID, "012")) {return (9, 4, 3, 4, 5, 3, 1);}//Deepmine Warden

  //Cosmic
   if(compareStrings(_dnaID, "013")) {return (3, 7, 4, 6, 5, 7, 3);}//Psorith
   if(compareStrings(_dnaID, "014")) {return (6, 4, 5, 5, 5, 7, 4);}//Adorablob
   if(compareStrings(_dnaID, "015")) {return (3, 8, 5, 4, 5, 7, 2);}//Mitsaiga
   if(compareStrings(_dnaID, "016")) {return (11, 4, 2, 3, 5, 7, 1);}//Vhornock

  //Divine
   if(compareStrings(_dnaID, "017")) {return (3, 6, 5, 6, 5, 8, 3);}//Angel of Judgement
   if(compareStrings(_dnaID, "018")) {return (4, 5, 5, 6, 5, 8, 4);}//Angel of Justice
   if(compareStrings(_dnaID, "019")) {return (4, 4, 5, 7, 5, 8, 2);}//Angel of Mercy
   if(compareStrings(_dnaID, "020")) {return (8, 2, 3, 7, 5, 8, 1);}//Celestial Warden

  //Earth
   if(compareStrings(_dnaID, "021")) {return (6, 7, 4, 3, 5, 1, 3);}//Carnifex
   if(compareStrings(_dnaID, "022")) {return (7, 6, 3, 4, 5, 1, 4);}//Crawler
   if(compareStrings(_dnaID, "023")) {return (4, 5, 5, 6, 5, 1, 2);}//Hoto
   if(compareStrings(_dnaID, "024")) {return (12, 3, 4, 1, 5, 1, 1);}//Treefolk Warden

  //Fire
   if(compareStrings(_dnaID, "025")) {return (3, 7, 4, 6, 5, 2, 3);}//Flameborn Imp
   if(compareStrings(_dnaID, "026")) {return (3, 5, 6, 6, 5, 2, 4);}//Ragefire Bat
   if(compareStrings(_dnaID, "027")) {return (4, 6, 6, 4, 5, 2, 2);}//Firedancer
   if(compareStrings(_dnaID, "028")) {return (6, 6, 4, 4, 5, 2, 1);}//Magmus

  //Lightning
   if(compareStrings(_dnaID, "029")) {return (3, 8, 6, 3, 5, 5, 3);}//Charged vortex
   if(compareStrings(_dnaID, "030")) {return (3, 7, 6, 4, 5, 5, 4);}//Voltuff
   if(compareStrings(_dnaID, "031")) {return (3, 8, 6, 3, 5, 5, 2);}//Prism of Neth
   if(compareStrings(_dnaID, "032")) {return (6, 4, 6, 4, 5, 5, 1);}//Warden of Neth

  //Neutral
   if(compareStrings(_dnaID, "033")) {return (4, 5, 6, 5, 5, 0, 3);}//Huntress
   if(compareStrings(_dnaID, "034")) {return (5, 5, 5, 5, 5, 0, 4);}//Dogo
   if(compareStrings(_dnaID, "035")) {return (3, 6, 6, 5, 5, 0, 2);}//Follower of Croco
   if(compareStrings(_dnaID, "036")) {return (7, 3, 4, 6, 5, 0, 1);}//Pharock Warrior
   if(compareStrings(_dnaID, "037")) {return (4, 6, 5, 5, 5, 0, 3);}//Slicer
   if(compareStrings(_dnaID, "038")) {return (5, 5, 5, 5, 5, 0, 4);}//Croco Impaler
   if(compareStrings(_dnaID, "039")) {return (7, 3, 4, 6, 5, 0, 2);}//Arcane Blob
   if(compareStrings(_dnaID, "040")) {return (8, 3, 3, 6, 5, 0, 1);}//Ninjaro

  //Water
   if(compareStrings(_dnaID, "041")) {return (3, 7, 4, 6, 5, 4, 3);}//Fangz
   if(compareStrings(_dnaID, "042")) {return (7, 3, 5, 5, 5, 4, 4);}//Boldice
   if(compareStrings(_dnaID, "043")) {return (4, 4, 6, 6, 5, 4, 2);}//Loraqua
   if(compareStrings(_dnaID, "044")) {return (11, 3, 4, 2, 5, 4, 1);}//Frost Warden

  /*
  Uncommon
  */

  //Abyss
   if(compareStrings(_dnaID, "045")) {return (8, 6, 6, 5, 4, 9, 4);}//Swordwalker
   if(compareStrings(_dnaID, "046")) {return (5, 9, 5, 6, 4, 9, 2);}//Mindeater
   if(compareStrings(_dnaID, "047")) {return (12, 5, 4, 4, 4, 9, 1);}//Undead Warden

  //Arcane
   if(compareStrings(_dnaID, "048")) {return (4, 7, 7, 7, 4, 6, 3);}//Jabs
   if(compareStrings(_dnaID, "049")) {return (5, 5, 6, 9, 4, 6, 4);}//Conjurer
   if(compareStrings(_dnaID, "050")) {return (4, 9, 6, 6, 4, 6, 2);}//Old Hag

  //Construct
   if(compareStrings(_dnaID, "051")) {return (6, 8, 7, 4, 4, 3, 3);}//Manhunter
   if(compareStrings(_dnaID, "052")) {return (9, 6, 5, 5, 4, 3, 4);}//Scrapyard Construct
   if(compareStrings(_dnaID, "053")) {return (12, 7, 4, 2, 4, 3, 1);}//Mechablast

  //Cosmic
   if(compareStrings(_dnaID, "054")) {return (4, 8, 8, 5, 4, 7, 3);}//Voidling Snatcher
   if(compareStrings(_dnaID, "055")) {return (3, 10, 10, 2, 4, 7, 2);}//Hivemind
   if(compareStrings(_dnaID, "056")) {return (8, 5, 5, 7, 4, 7, 1);}//Psagorath

  //Divine
   if(compareStrings(_dnaID, "057")) {return (7, 6, 5, 7, 4, 8, 4);}//Centaurion
   if(compareStrings(_dnaID, "058")) {return (5, 8, 6, 7, 4, 8, 2);}//Shadowdancer
   if(compareStrings(_dnaID, "059")) {return (9, 8, 4, 6, 4, 8, 1);}//Capra

  //Earth
   if(compareStrings(_dnaID, "060")) {return (6, 7, 6, 6, 4, 1, 3);}//Petalya
   if(compareStrings(_dnaID, "061")) {return (8, 7, 5, 5, 4, 1, 4);}//Bamboo Elite
   if(compareStrings(_dnaID, "062")) {return (13, 5, 4, 3, 4, 1, 1);}//Enforcer

  //Fire
   if(compareStrings(_dnaID, "063")) {return (4, 8, 7, 6, 4, 2, 3);}//Valkyrion
   if(compareStrings(_dnaID, "064")) {return (5, 8, 7, 5, 4, 2, 4);}//Tormenter
   if(compareStrings(_dnaID, "065")) {return (4, 10, 6, 5, 4, 2, 2);}//Blazer

  //Lightning
   if(compareStrings(_dnaID, "066")) {return (5, 7, 6, 7, 4, 5, 3);}//Chargoyle
   if(compareStrings(_dnaID, "067")) {return (9, 5, 5, 6, 4, 5, 4);}//Thorax
   if(compareStrings(_dnaID, "068")) {return (11, 12, 2, 2, 4, 5, 2);}//Manaburst

  //Neutral
   if(compareStrings(_dnaID, "069")) {return (5, 7, 7, 6, 4, 0, 3);}//Guildmaster
   if(compareStrings(_dnaID, "070")) {return (5, 8, 8, 4, 4, 0, 4);}//Pirate Captain
   if(compareStrings(_dnaID, "071")) {return (4, 10, 7, 4, 4, 0, 2);}//Goblin Shaman
   if(compareStrings(_dnaID, "072")) {return (5, 6, 6, 8, 4, 0, 3);}//Tough Cookie
   if(compareStrings(_dnaID, "073")) {return (8, 7, 6, 4, 4, 0, 4);}//Orc Berserk
   if(compareStrings(_dnaID, "074")) {return (10, 9, 3, 3, 4, 0, 1);}//Gluttony

  //Water
   if(compareStrings(_dnaID, "075")) {return (5, 9, 7, 4, 4, 4, 3);}//Creepy Snowman
   if(compareStrings(_dnaID, "076")) {return (6, 6, 6, 7, 4, 4, 4);}//Harperion
   if(compareStrings(_dnaID, "077")) {return (12, 3, 5, 5, 4, 4, 1);}//Glob-glob


  /*
   Rare
  */

  //Abyss
   if(compareStrings(_dnaID, "078")) {return (9, 10, 8, 8, 3, 9, 4);}//Demonic Axemaster

  //Arcane
   if(compareStrings(_dnaID, "079")) {return (7, 12, 9, 6, 3, 6, 4);}//Arcane Shifter

  //Construct
   if(compareStrings(_dnaID, "080")) {return (8, 13, 8, 6, 3, 3, 2);}//Tempest

  //Cosmic
   if(compareStrings(_dnaID, "081")) {return (9, 14, 4, 8, 3, 7, 2);}//Voidmancer

  //Divine
   if(compareStrings(_dnaID, "082")) {return (7, 8, 8, 12, 3, 8, 2);}//Sacred Djinn

  //Earth
   if(compareStrings(_dnaID, "083")) {return (12, 10, 8, 5, 3, 1, 2);}//Worldeater

  //Fire
   if(compareStrings(_dnaID, "084")) {return (9, 15, 5, 7, 3, 2, 1);}//Ignitius

  //Lightning
   if(compareStrings(_dnaID, "085")) {return (7, 10, 11, 7, 3, 5, 3);}//Static Zealot

  //Neutral
   if(compareStrings(_dnaID, "086")) {return (10, 9, 8, 8, 3, 0, 4);}//Chimera
   if(compareStrings(_dnaID, "087")) {return (13, 9, 7, 6, 3, 0, 1);}//Stalagtuss

  //Water
   if(compareStrings(_dnaID, "088")) {return (15, 10, 4, 6, 3, 4, 1);}//Hydrodon

  /*
   Epic
  */

  //Abyss
   if(compareStrings(_dnaID, "089")) {return (22, 12, 10, 6, 2, 9, 1);}//Bone Cairn

  //Arcane
   if(compareStrings(_dnaID, "090")) {return (10, 18, 12, 10, 2, 6, 2);}//Xanandor, the Eternal

  //Construct
   if(compareStrings(_dnaID, "091")) {return (20, 8, 10, 12, 2, 3, 1);}//Cogface

  //Cosmic
   if(compareStrings(_dnaID, "092")) {return (16, 14, 10, 10, 2, 7, 4);}//Amhaodrru

  //Divine
   if(compareStrings(_dnaID, "093")) {return (13, 13, 11, 13, 2, 8, 4);}//Torald, the Celestial Blacksmith

  //Earth
   if(compareStrings(_dnaID, "094")) {return (14, 14, 12, 10, 2, 1, 3);}//Vihara, Watcher of the Wilds

  //Fire
   if(compareStrings(_dnaID, "095")) {return (16, 18, 12, 8, 2, 2, 2);}//Nazar, the Infernal King

  //Lightning
   if(compareStrings(_dnaID, "096")) {return (10, 16, 20, 10, 2, 5, 3);}//Blitz, Rider of the Storm

  //Neutral
   if(compareStrings(_dnaID, "097")) {return (18, 16, 14, 4, 2, 0, 1);}//Yorn, the Possessed

  //Water
   if(compareStrings(_dnaID, "098")) {return (13, 14, 14, 10, 2, 4, 4);}//Acra, Queen of the Frozen Wastes
  /*
   Mythic
  */
      /*
      Fighting Style
      1      2         3          4
      Tank < Mage < Assassin < Bruiser
      */



  //Abyss
   if(compareStrings(_dnaID, "099")) {return (16, 23, 16, 15, 1, 9, 3);}//Reaper of Souls

  //Arcane
   if(compareStrings(_dnaID, "100")) {return (12, 22, 18, 18, 1, 6, 3);}//Nostra, Immortal Spellblade

  //Construct
   if(compareStrings(_dnaID, "101")) {return (23, 17, 16, 14, 1, 3, 4);}//Singularity

  //Cosmic
   if(compareStrings(_dnaID, "102")) {return (38, 14, 12, 6, 1, 7, 1);}//Elesh Madea, Watcher of Worlds

  //Divine
   if(compareStrings(_dnaID, "103")) {return (19, 19, 14, 18, 1, 8, 1);}//Hand of God

  //Earth
   if(compareStrings(_dnaID, "104")) {return (44, 12, 12, 2, 1, 1, 1);}//Teldra´sin, God of Creation

  //Fire
   if(compareStrings(_dnaID, "105")) {return (20, 28, 12, 10, 1, 2, 4);}//Ifrit, Destroyer of Worlds

  //Lightning
   if(compareStrings(_dnaID, "106")) {return (14, 20, 20, 16, 1, 5, 4);}//Wolt, God of Thunder

  //Neutral
   if(compareStrings(_dnaID, "107")) {return (10, 16, 14, 30, 1, 0, 2);}//Avatar of Time

  //Water
   if(compareStrings(_dnaID, "108")) {return (20, 22, 14, 14, 1, 4, 2);}//Aqua, God of the Ocean

   else {
      var( myuint, hasBadBytes ) = stringToUint(_dnaID);
      if( hasBadBytes == false ) {
         // revert transaction
         revert("Expected numerical value");
      }
      else {
         myuint = 1000.sub(myuint);
         string memory dna = uintToString(myuint);
         string memory newid = getSlice(0,3, dna);
         getCreatureMold(newid);
      }

   }
}
}