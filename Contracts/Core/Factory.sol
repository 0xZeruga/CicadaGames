pragma solidity >=0.5.0 <0.6.0;

import "../Tools/Ownable.sol";
import "../Tools/Safemath.sol";
import "../Tools/SolidityHelper.sol";
import "../Data/Creatures.sol";
import "../Data/Gear.sol";
import "./Versioning.sol";


contract Factory is Ownable, SolidityHelper, Creatures, Versioning, Gear {

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
    uint16 kills;
    uint16 deaths;
    uint16 winCount;
    uint16 lossCount;
    uint16 health;
    uint16 maxhealth;
    uint16 damage;
    uint16 accuracy;
    uint16 evasion;
    uint16 tier;
    uint16 element;
    uint16 fightingstyle;
    uint16 honor;
  }

  Creature[] public creatures;

  mapping (uint => address) public creatureToOwner;
  mapping (address => uint) ownerCreatureCount;
  mapping(uint => bool) public graveyard;

  mapping(address => uint[]) public defendingCreatures;
  mapping(address => uint[]) public attackingCreatures;

  mapping(address => uint) public defendingChallengeRating;
  mapping(address => uint) public attackingChallengeRating;

  function withinChallengeRange(uint a, uint b) public returns(bool) {
    if(a.sub(b) >= a.mul(0.1) && a.sub(b) <= a.mul(-0.1)){
      return true;
    }
    else {
      return false;
    }
  }

  function getattackingChallengeRating(address _attacker) public returns(uint) {
    uint rating = 0;
    for(int i = 0; i < _attacker[attackCreatures.length]-1; i++) {
      rating.add(getCreatureChallengerating(_attacker[attackingCreatures][i]));
    }
    return rating;
  }

  function getdefendingChallengeRating(address _defender) public returns(uint) {
    uint rating = 0;
    for(int i = 0; i < _defender[defendingCreatures.length]-1; i++) {
      rating.add(getCreatureChallengerating(_defender[defendingCreatures][i]));
    }
    return rating;
  }

  function getCreatureChallengerating(uint _id) public returns(uint){
    return creatures[_id].health + creatures[_id].damage + creatures[_id].accuracy + creatures[_id].evasion;
  }
  function addDefender(uint _id) public {
    require(creatureToOwner[id] == msg.sender, "Can only stage your own creatures");
    require(notAttacker(_id), "Creature already staged as attacker");
    require(isAlive(_id), "Creature is dead");
    require(msg.sender[defendingCreatures].length < 5, "Defenders are full");
    msg.sender[defendingCreatures].push(creatures[_id]);
  }
  function removeDefender(uint _id) public {
    require(creatureToOwner[id] == msg.sender, "Can only stage your own creatures");
    require(notAttacker(_id), "Creature already staged as attacker");
    require(msg.sender[defendingCreatures].length > 0, "Defenders are empty");
    remove(_id, msg.sender[defendingCreatures]);
  }
  function addAttacker(uint _id) public {
    require(creatureToOwner[id] == msg.sender, "Can only stage your own creatures");
    require(notDefender(_id), "Creature already staged as attacker");
    require(isAlive(_id), "Creature is dead");
    require(msg.sender[attackingCreatures].length < 5, "Defenders are full");
    msg.sender[attackingCreatures].push(creatures[_id]);
  }
  function removeAttacker(uint _id) public {
    require(creatureToOwner[id] == msg.sender, "Can only stage your own creatures");
    require(notDefender(_id), "Creature already staged as attacker");
    require(msg.sender[attackingCreatures].length > 0, "Defenders are empty");
    remove(_id, msg.sender[attackingCreatures]);
  }

  function remove(uint index, uint[] array) public returns(uint[]) {
    if (index >= array.length) return;

    for (uint i = index; i<array.length-1; i++){
        array[i] = array[i+1];
    }
    delete array[array.length-1];
    array.length--;
    return array;
  }

  function notAttacker(uint _id) public returns (bool) {
    for (uint i = 0; i < msg.sender[attackingCreatures].length-1; i++){
        array[i] = array[i+1];
        if(msg.sender[attackingCreatures][i] == _id) {
          return false;
        }
    }
    return true;
  }

  function notDefender(uint _id) public returns (bool) {
    for (uint i = 0; i < msg.sender[defendingCreatures].length-1; i++){
        array[i] = array[i+1];
        if(msg.sender[defendingCreatures][i] == _id) {
          return false;
        }
    }
    return true;
  }

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

    (uint hp, uint dmg, uint acc, uint eva, uint tier, uint element, uint fightingstyle) = dnaToStats(_dna);

    uint id = creatures.push(Creature(_name, _dna, 1, uint32(now + cooldownTime), 0, 0, 0, 0,
    uint16(hp), uint16(hp), uint16(dmg), uint16(acc), uint16(eva), uint16(tier), uint16(element), uint16(fightingstyle),0)) - 1;

    creatureToOwner[id] = msg.sender;
    ownerCreatureCount[msg.sender] = ownerCreatureCount[msg.sender].add(1);
    emit NewCreature(id, _name, _dna);
  }

  function dnaToStats(uint _dna) public pure returns (uint hp, uint dmg, uint acc, uint eva, uint tier, uint element, uint fightinstyle)  {
    string memory dna = uintToString(_dna);
    string memory id = getSlice(0,3, dna);
    string memory gear = getSlice(3, 9, dna);

    (uint h, uint d, uint a, uint e, uint t, uint elem, uint fightingstyle) = getCreatureMold(id);
    (uint gH, uint gD, uint gA, uint gE) = getCreatureArmorMods(gear);

    return(
      getHealth(h,t,1) + gH,
      getDamage(d,t,1) + gD,
      getAccuracy(a,t,1) + gA,
      getEvasion(e,t,1) + gE,
      t,
      elem,
      fightingstyle
    );
  }

  function getHealth(uint _baseHealthModifier, uint _tier, uint _level) public pure returns (uint) {
    return _baseHealthModifier.mul(_level);
  }
  function getDamage(uint _baseDamageModifier, uint _tier, uint _level) public pure returns (uint) {
    return _baseDamageModifier.mul(_level);
  }
  function getAccuracy(uint _baseAccuracyModifier, uint _tier, uint _level) public pure returns (uint) {
    return _baseAccuracyModifier.mul(_level);
  }
  function getEvasion(uint _baseEvasionModifier, uint _tier, uint _level) public pure returns (uint) {
    return _baseEvasionModifier.mul(_level);
  }
  function getLevel(uint _id) public pure returns (uint) {
    return creatures[_id].level;
  }
  function getFightingStyle(uint _id) public pure returns (uint) {
    return creatures[_id].fightingstyle;
  }
  function getElement(uint _id) public pure returns (uint) {
    return creatures[_id].element;
  }
  function recycle(uint _id) public pure returns (uint) {
    require(isAlive(_id), "Creature is not alive");
    require(creatureToOwner[_id] == msg.sender, "You must own this creature");
    require(notAttacker(_id), "Creature is staged as attacker");
    require(notDefender(_id), "Creature is staged as defender");
    uint memory tokens = getCreatureChallengerating(_id);
    delete creatures[_id];
    delete attackingCreatures[_id];
    delete defendingCreatures[_id];
  }
}
