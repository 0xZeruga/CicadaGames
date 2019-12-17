pragma solidity >=0.5.0 <0.6.0;

import "../SolidityHelpers/solidityHelper.sol";


contract Creatures is SolidityHelper {

      function getCreatureMold(string memory _dnaID) public pure returns (uint healthMod,
   uint damageMod, uint accuracyMod, uint evasionMod, uint tier, uint element, uint fightingstyle) {
      /*
      Element

      Earth > Lightning > Water > Construct > Fire > Earth + Neutral

      Arcane < Abyssal < Divine < Cosmic < Arcane

      */

      /*
      Fighting Style

      Tank > Bruiser > Assassin > Caster >
      */


    if(compareStrings(_dnaID, "000")) {return (0, 0, 0, 0, 1, 0, 0);}
    if(compareStrings(_dnaID, "001")) {return (0, 0, 0, 0, 2, 0, 0);}
    if(compareStrings(_dnaID, "002")) {return (0, 0, 0, 0, 3, 0, 0);}
    
  }
}