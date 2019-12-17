pragma solidity >=0.5.0 <0.6.0;

import "./helper.sol";

contract Attack is Helper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;

  function randMod(uint _modulus) internal returns(uint) {
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }

  function attack(uint _creatureId, uint _targetId) external onlyOwnerOf(_creatureId) {
    Creature storage myZombie = creatures[_creatureId];
    Creature storage enemyZombie = creatures[_creatureId];
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability) {
      myCreature.winCount = myCreature.winCount.add(1);
      myCreature.level = myCreature.level.add(1);
      enemyCreature.lossCount = enemyCreature.lossCount.add(1);
      feedAndMultiply(_creatureId, enemyCreature.dna, "zombie");
    } else {
      myCreature.lossCount = myCreature.lossCount.add(1);
      enemyCreature.winCount = enemyCreature.winCount.add(1);
      _triggerCooldown(myCreature);
    }
  }

  function checkHitchance(uint _zombieId, uint _targetId) internal onlyOwnerOf(_creatureId) {
    
}

