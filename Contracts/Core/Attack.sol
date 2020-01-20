pragma solidity >=0.5.0 <0.6.0;

import "./Utility.sol";
import "./Factory.sol";

contract Attack is Utility, Factory {

  Utility instanceUtility;
  //Requires Utility contract.
  constructor(address _utility) public {
    instanceUtility = Utility(_utility);
  }

  uint randNonce = 0;
  uint attackVictoryProbability = 70;

  function randMod(uint _modulus) internal returns(uint) {
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }

  function attack(uint _creatureId, uint _targetId) external onlyOwnerOf(_creatureId) {
    require(creatures[_creatureId].level <= creatures[_targetId]);
    Creature storage myCreature = creatures[_creatureId];
    Creature storage enemyCreature = creatures[_targetId];

    uint rand = randMod(100);
    uint hc = myCreature.accuracy / enemyCreature.evasion;
    uint hitchance = hc + elementModifer(myCreature.element, enemyCreature.element) +
    fightingStyleModifer(myCreature.fightingstyle, enemyCreature.fightingstyle);

    if(hitchance > 100) { hitchance = 100;}
    if(hitchance < 0) { hitchance = 0;}

    if (rand <= hitchance) {
      enemyCreature.health.sub(myCreature.damage);
      //Hit creature and it dies
      if(isDead(enemyCreature.health)) {
        graveyard[_targetId] = true;
        myCreature.kills = myCreature.kills.add(1);
        enemyCreature.deaths = enemyCreature.deaths.add(1);
        if(myCreature.level < enemyCreature.level) {
          //emit honor
          myCreature.honor.add(enemyCreature.level - myCreature.level);
        }
      }
      //Hit creature but doesnt die
      myCreature.winCount = myCreature.winCount.add(1);
      myCreature.level = myCreature.level.add(1);
      enemyCreature.lossCount = enemyCreature.lossCount.add(1);
      _triggerCooldown(myCreature);
    }
    else {
      myCreature.health.sub(enemyCreature.damage);
      //Miss creature and retaliation kills you
      if(isDead(myCreature.health)) {
        graveyard[_creatureId] = true;
        enemyCreature.kills = myCreature.kills.add(1);
        myCreature.deaths = enemyCreature.deaths.add(1);
      }
      //Miss creature and retaliation doesn't kill you
      myCreature.lossCount = myCreature.lossCount.add(1);
      enemyCreature.winCount = enemyCreature.winCount.add(1);
      _triggerCooldown(myCreature);
    }
  }

  function isDead(int _hp) internal returns (bool) {
    return _hp <= 0;
  }

  function elementModifer(uint a, uint d) public returns(uint) {
    //Earth, Fire, Construct, Water, Lightning (1-5)
    if(a == 1 && b == 2 || a == 2 && b == 3 || a == 3 && b == 4 || a == 4 && b = 5
    || a == 5 && b == 1 || a == 6 && b == 7 || a == 7 && b == 8 || a == 8 && b == 9
    || a == 9 && b == 10 || a == 10 && b == 6) {return -10;}

    //Arcane, Cosmic, Divine, Abyssal (6-9)
    else if(b == 1 && a == 2 || b == 2 && a == 3 || b == 3 && a == 4 || b == 4 && a = 5
    || b == 5 && a == 1 || b == 6 && a == 7 || b == 7 && a == 8 || b == 8 && a == 9
    || b == 9 && a == 6) {return 10;}

    else { return 0;}
  }

  function fightingStyleModifier(uint a, uint d) public returns(uint) {
    if(a == 1 && b == 2 || a == 2 && b == 3 || a == 3 && b == 4 || a == 4 && b = 1) {return -10;}

    else if(b == 1 && a == 2 || b == 2 && a == 3 || b == 3 && a == 4 || b == 4 && a = 1) {return 10;}

    else { return 0;}
  }

//feedAndMultiply(_creatureId, enemyCreature.dna, "zombie");

}