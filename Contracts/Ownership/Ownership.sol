pragma solidity >=0.5.0 <0.6.0;

import "../GameLogic/attack.sol";
import "../Token/erc721.sol";
import "../SafeMath/safemath.sol";

contract Ownership is Attack, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) creatureApprovals;

  function balanceOf(address _owner) external view returns (uint256) {
    return creatureCreatureCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return creatureToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerCreatureCount[_to] = ownerCreatureCount[_to].add(1);
    ownerCreatureCount[msg.sender] = ownerCreatureCount[msg.sender].sub(1);
    creatureToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
      require(creatureToOwner[_tokenId] == msg.sender || creatureApprovals[_tokenId] == msg.sender);
      _transfer(_from, _to, _tokenId);
    }

  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
      creatureApprovals[_tokenId] = _approved;
      emit Approval(msg.sender, _approved, _tokenId);
    }

}
