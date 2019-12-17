pragma solidity >=0.5.0 <0.6.0;

import "../Ownership/ownable.sol";
import "../SafeMath/safemath.sol";

contract Factory is Ownable {

  using SafeMath for uint256;
  using SafeMath32 for uint32;
  using SafeMath16 for uint16;

  event NewCreature(uint creatureId, string name, uint dna);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;

  struct Creature {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
    uint16 health;
    uint16 maxhealth;
    uint16 damage;
    uint16 accuracy;
    uint16 evasion;
    uint16 tier;
  }

  Creature[] public creatures;

  mapping (uint => address) public creatureToOwner;
  mapping (address => uint) ownerCreatureCount;

  function createRandomCreature(string memory _name) public {
    require(ownerCreatureCount[msg.sender] == 0, "creature has no owner");
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createCreature(_name, randDna);
  }

  function _generateRandomDna(string memory _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  function _createCreature(string memory _name, uint _dna) internal {

    (uint hp, uint dmg, uint acc, uint eva, uint tier) = dnaToStats(_dna);

    uint id = creatures.push(Creature(_name, _dna, 1, uint32(now + cooldownTime), 0, 0,
    uint16(hp), uint16(hp), uint16(dmg), uint16(acc), uint16(eva), uint16(tier))) - 1;

    creatureToOwner[id] = msg.sender;
    ownerCreatureCount[msg.sender] = ownerCreatureCount[msg.sender].add(1);
    emit NewCreature(id, _name, _dna);
  }

  function dnaToStats(uint _dna) public pure returns (uint hp, uint dmg, uint acc, uint eva, uint tier)  {
    string memory dna = uintToString(_dna);
    string memory id = getSlice(0,3, dna);

    (uint h, uint d, uint a, uint e, uint t) = getCreatureMold(id);

    return(
      getHealth(h,t,1),
      getDamage(d,t,1),
      getAccuracy(a,t,1),
      getEvasion(e,t,1),
      t
      );
    }

//TODO Populate all creature stats
  function getCreatureMold(string memory _dnaID) public pure returns (uint healthMod,
   uint damageMod, uint accuracyMod, uint evasionMod, uint tier) {

    if(compareStrings(_dnaID, "000")) {return (0, 0, 0, 0, 1);}
    if(compareStrings(_dnaID, "001")) {return (0, 0, 0, 0, 2);}
    if(compareStrings(_dnaID, "002")) {return (0, 0, 0, 0, 3);}
  }

  function uintToString(uint i) internal pure returns (string memory _uintAsString) {
    uint _i = i;
   if (_i == 0) {
        return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
        len++;
        j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (_i != 0) {
        bstr[k--] = byte(uint8(48 + _i % 10));
        _i /= 10;
    }
    return string(bstr);
}

  function getHealth(uint _baseHealthModifier, uint _tier, uint _level) public pure returns (uint) {
    return _baseHealthModifier.mul(_tier) + _baseHealthModifier.mul(_level);
  }
  function getDamage(uint _baseDamageModifier, uint _tier, uint _level) public pure returns (uint) {
    return _baseDamageModifier.mul(_tier) + _baseDamageModifier.mul(_level);
  }
  function getAccuracy(uint _baseAccuracyModifier, uint _tier, uint _level) public pure returns (uint) {
    return _baseAccuracyModifier.mul(_tier) + _baseAccuracyModifier.mul(_level);
  }
  function getEvasion(uint _baseEvasionModifier, uint _tier, uint _level) public pure returns (uint) {
    return _baseEvasionModifier.mul(_tier) + _baseEvasionModifier.mul(_level);
  }

  function append(string memory a, string memory b, string memory c) internal pure returns (string memory) {
    return string(abi.encodePacked(a, b, c));
  }

  function getSlice(uint256 begin, uint256 end, string memory text) public pure returns (string memory) {
    bytes memory a = new bytes(end-begin+1);
    for(uint i = 0; i <= end-begin; i++){
      a[i] = bytes(text)[i+begin-1];
    }
  return string(a);
  }

  function compareStrings (string memory a, string memory b) public pure returns (bool) {
    return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );
  }

  function toBytes(uint256 x) public pure returns (bytes memory b) {
    b = new bytes(32);
    assembly {
      mstore(add(b, 32), x)
    }
  }
}
