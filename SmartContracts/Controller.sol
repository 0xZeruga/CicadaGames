pragma solidity ^0.5.0;

import "./CMCEnabled.sol";
import "./Storage.sol";

contract Controller is CMCEnabled {

    function totalSupply() external isCMCEnabled("PixelCoin") returns (uint256) {
        Storage(ContractProvider(CMC).contracts("Storage")).totalSupply();
    }

    function balanceOf(address owner) external isCMCEnabled("PixelCoin") returns (uint256) {
        Storage(ContractProvider(CMC).contracts("Storage")).balanceOf(owner);
    }

    function allowance(address owner, address spender) external isCMCEnabled("PixelCoin") returns (uint256) {
        Storage(ContractProvider(CMC).contracts("Storage")).allowance(owner, spender);
    }

    function transfer(address to, uint256 value) external isCMCEnabled("PixelCoin") returns (bool) {
        Storage(ContractProvider(CMC).contracts("Storage")).transfer(to, value);
    }

    function approve(address spender, uint256 value) external isCMCEnabled("PixelCoin") returns (bool) {
        Storage(ContractProvider(CMC).contracts("Storage")).approve(spender, value);
    }

    function transferFrom(address from, address to, uint256 value) external isCMCEnabled("PixelCoin") returns (bool) {
        Storage(ContractProvider(CMC).contracts("Storage")).transferFrom(from, to, value);
    }

    function makeCreature(uint _id, uint _maxhealth, uint _damage, string _race, string _name)
    external isCMCEnabled("PixelCoin") returns (bool) {
        Storage(ContractProvider(CMC).contracts("Storage")).makeCreature(_id, _maxhealth, _damage, _race, _name);
    }

    function createFight(uint _stagedMonster, uint _stake, uint _expirationBlock) external isCMCEnabled("PixelCoin") returns (bool) {
        Storage(ContractProvider(CMC).contracts("Storage")).createFight(_stagedMonster, _stake, _expirationBlock);
    }

    function joinFight(uint256 f, uint256 c) external isCMCEnabled("PixelCoin") returns (bool) {
        Storage(ContractProvider(CMC).contracts("Storage")).joinFight(f, c);
    }

    function setHealth(uint _value, uint256 id) external isCMCEnabled("PixelCoin") {
      Storage(ContractProvider(CMC).contracts("Storage")).setHealth(_value, id);
    }

    function getCreatureByID(uint256 _id) external isCMCEnabled("PixelCoin") returns (uint256, uint256, uint256, uint256) {
        Storage(ContractProvider(CMC).contracts("Storage")).getCreatureByID(_id);
    }

    function getFightByID(uint256 _id) external isCMCEnabled("PixelCoin") returns (uint256, uint256, uint256, uint256, uint256) {
        Storage(ContractProvider(CMC).contracts("Storage")).getFightByID(_id);
    }

    function getOwnerByID(uint256 _id) external isCMCEnabled("PixelCoin") returns (address) {
        Storage(ContractProvider(CMC).contracts("Storage")).getFightByID(_id);
    }

    function announceWinner(uint256 _winner, uint256 _loser) external isCMCEnabled("PixelCoin") returns (address) {
        Storage(ContractProvider(CMC).contracts("Storage")).announceWinner(_winner, _loser);
    }

    function healCreature(uint256 _cID) external isCMCEnabled("PixelCoin") returns (bool) {
        Storage(ContractProvider(CMC).contracts("Storage")).healCreature(_cID);
    }

    function getPrice(uint256 auction) external isCMCEnabled("PixelCoin") returns (uint256) {
        Storage(ContractProvider(CMC).contracts("Storage")).getPrice(auction);
    }

    function buyAuction(uint256 c) external isCMCEnabled("PixelCoin") returns (bool) {
        Storage(ContractProvider(CMC).contracts("Storage")).buyAuction(c);
    }
}