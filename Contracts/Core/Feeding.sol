pragma solidity >=0.5.0 <0.6.0;

import "./Factory.sol";

contract Feeding is Factory {

  Factory instanceFactory;

  //Requires factory
  constructor(address _factory) {
    instanceFactory = Factory(_factory);
  }

  modifier onlyOwnerOf(uint _creatureId) {
    require(msg.sender == creatureToOwner[_creatureId],  "User must own this creature");
    _;
  }

  function _triggerCooldown(Creature storage _creature) internal {
    _creature.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Creature storage _creature) internal view returns (bool) {
      return (_creature.readyTime <= now);
  }

  function feedAndMultiply(uint _creatureId, uint _targetDna, string memory _species) internal onlyOwnerOf(_creatureId) {
    Creature storage myCreature = creatures[_creatureId];
    require(_isReady(myCreature), "Creature is not ready");
    uint tDna = _targetDna % dnaModulus;
    uint newDna = (myCreature.dna + tDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createCreature("NoName", newDna);
    _triggerCooldown(myCreature);
  }

  function feedOnKitty(uint _creatureId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_creatureId, kittyDna, "kitty");
  }
}
