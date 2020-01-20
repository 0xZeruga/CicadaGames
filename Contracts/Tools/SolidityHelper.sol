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

  function stringToUint(string memory s) public pure returns (uint, bool) {
    bool hasError = false;
      bytes memory b = bytes(s);
      uint result = 0;
      uint oldResult = 0;
      for (uint i = 0; i < b.length; i++) { // c = b[i] was not needed
         if (b[i] >= 48 && b[i] <= 57) {
               // store old value so we can check for overflows
               oldResult = result;
               result = result * 10 + (uint(b[i]) - 48); // bytes and int are not compatible with the operator -.
               // prevent overflows
               if(oldResult > result ) {
                  // we can only get here if the result overflowed and is smaller than last stored value
                  hasError = true;
               }
         } else {
               hasError = true;
         }
      }
      return (result, hasError);
   }
}