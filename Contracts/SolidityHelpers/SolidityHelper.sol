pragma solidity >=0.5.0 <0.6.0;

contract SolidityHelper {

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

function uintToString(uint i) public pure returns (string memory _uintAsString) {
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
}