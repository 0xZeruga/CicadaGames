pragma solidity >=0.5.0 <0.6.0;

import "./Feeding.sol";

contract Utility is Feeding {

  Feeding instanceFeeding;
  //Requires feeding
  constructor(address _instanceFeeding) {
    instanceFeeding = Feeding(_instanceFeeding);
  }

  uint levelUpFee = 0.001 ether;

  modifier aboveLevel(uint _level, uint _creatureId) {
    require(creatures[_creatureId].level >= _level, "levelcheck");
    _;
  }

  function withdraw() external onlyOwner {
    address _owner = owner();
    _owner.transfer(address(this).balance);
  }

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp(uint _creatureId) external payable {
    require(msg.value == levelUpFee, "Value not correct");
    creatures[_creatureId].level = creatures[_creatureId].level.add(1);
  }

  function changeName(uint _creatureId, string calldata _newName) external aboveLevel(2, _creatureId) onlyOwnerOf(_creatureId) {
    creatures[_creatureId].name = _newName;
  }

  function changeDna(uint _creatureId, uint _newDna) external aboveLevel(20, _creatureId) onlyOwnerOf(_creatureId) {
    creatures[_creatureId].dna = _newDna;
  }

  function getCreaturesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerCreatureCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < creatures.length; i++) {
      if (creatureToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }
}
