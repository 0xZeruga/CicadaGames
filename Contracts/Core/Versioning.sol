pragma solidity >=0.5.0 <0.6.0;


import "../Tools/Ownable.sol";
import "../Tools/SafeMath.sol";

/*
This contract is used to patch the code by pointers to the storage of creature and gear data.
*/

contract Versioning is Ownable {

    //initialize this after creature and gear has been deployed. 
    constructor(address _creatureAddress, address _gearAddress) {
        creatureAddress = _creatureAddress;
        gearAddress = _gearAddress;
    }

    public address creatureAddress;
    public address gearAddress;
    public address[] previousCreatureAddresses;
    public address[] previousGearAddresses;

    public uint creatureAddressLastUpdated;
    public uint gearAddressLastUpdated;

    public uint patchCounter = 0;

    constructor() public onlyOwner() {
        owner = msg.sender;
    }

    function setCreatureUpdateCompleted() public onlyOwner() {
        creatureAddressLastUpdated = block.timestamp;
    }
    function setGearUpdateCompleted() public onlyOwner() {
        gearAddressLastUpdated = block.timestamp;
    }

    function upgradeCreatureAddress(address new_address) public onlyOwner() {
        Migrations upgraded = Migrations(new_address);
        setCreatureUpdateCompleted();
        patchCounter.add(1);
    }

    function upgradeGearAddress(address new_address) public onlyOwner() {
        creatureAddressLastUpdated = new_address;
        setGearUpdateCompleted();
        patchCounter.add(1);
    }
}