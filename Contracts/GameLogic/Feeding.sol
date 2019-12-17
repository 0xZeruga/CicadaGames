pragma solidity >=0.5.0 <0.6.0;

import "./factory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract Feeding is Factory {

  KittyInterface kittyContract;

  modifier onlyOwnerOf(uint _creatureId) {
    require(msg.sender == creatureToOwner[_creatureId],  "User must own this creature");
    _;
  }

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
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
