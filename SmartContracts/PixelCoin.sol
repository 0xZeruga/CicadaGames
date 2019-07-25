pragma solidity ^0.5.0;

import "./ERC/ERC20Detailed.sol";
import "./Controller.sol";
import "./CMCEnabled.sol";

contract PixelCoin is CMCEnabled {

  address public publisher;

  event Trace(bytes32 x, bytes16 a, bytes16 b);
  event Winner(string w, string l);

  using SafeMath for uint256;

  function PixelCoin() public {
      publisher = msg.sender;
  }

  function totalSupply() public returns (uint256) {
    Controller(ContractProvider(CMC).contracts("Controller")).totalSupply();
  }

  function balanceOf(address target) public returns (uint256) {
    Controller(ContractProvider(CMC).contracts("Controller")).balanceOf(target);
  }

  function allowance(address target, address spender) public returns (uint256) {
    Controller(ContractProvider(CMC).contracts("Controller")).allowance(target, spender);
  }

  function buyAuction(uint c) public returns (bool) {
    //TODO getPrice on auctionCreatures[c];
    uint256 price = getPrice(c);
    approve(this, price);
    transferFrom(msg.sender, this, price);
    require(buyAuction(c));
    require(transfer(Controller(ContractProvider(CMC).contracts("Controller")).getOwnerByID(c), price));
    return true;
  }

  function getPrice(uint auction) public returns (uint256) {
    uint256 price = Controller(ContractProvider(CMC).contracts("Controller")).getPrice(auction);
    return price;
  }

  function transfer(address to, uint256 value) public returns (bool) {
    Controller(ContractProvider(CMC).contracts("Controller")).transfer(to, value);
  }

  function approve(address spender, uint256 value) public returns (bool) {
    Controller(ContractProvider(CMC).contracts("Controller")).approve(spender, value);
  }

  function transferFrom(address from, address to, uint256 value) public returns (bool) {
    Controller(ContractProvider(CMC).contracts("Controller")).transferFrom(from, to, value);
  }

  function makeCreature (uint _id, uint _maxhealth, uint _damage, string _race, string _name) public returns (bool) {
    require(transfer(msg.sender, 100));
    Controller(ContractProvider(CMC).contracts("Controller")).makeCreature(_id, _maxhealth, _damage, _race, _name);
  }

  function createFight(uint256 _stagedMonster, uint _stake, uint _expirationBlock) public returns (bool) {
       if (transfer(this, _stake)) {
         Controller(ContractProvider(CMC).contracts("Controller")).createFight(_stagedMonster, _stake, _expirationBlock);
       }
  }

  function joinFight(uint256 f, uint256 c) public returns (bool) {
   // require(getCreatureByID(c).isStaged);
   // require(getFightByID(f).isOpen);
   // require(transfer(this, getFightByID(f).stake));
   // require(getFightByID(f).combatant.currenthealth >= 0);

    Controller(ContractProvider(CMC).contracts("Controller")).joinFight(f, c);
    //Staging monster
    var (id, stake, cHP, dmg,init) = Controller(ContractProvider(CMC).contracts("Controller")).getFightByID(f);
    //Challenging monster
    var (id2, cHP2, dmg2, init2) = Controller(ContractProvider(CMC).contracts("Controller")).getCreatureByID(f);
    _fight(id, stake, cHP, dmg, init, id2, cHP2, dmg2, init2);
  }

  function _fight(uint id, uint stake, uint cHP, uint dmg, uint init, uint id2, uint cHP2, uint dmg2, uint init2) internal {
    uint currentHP = cHP;
    uint currentHP2 = cHP2;
    while (currentHP > 0 || currentHP2 > 0) {
      if (checkInitiative(init, init2)) {
        currentHP2 = currentHP2.sub(dmg);
        currentHP = currentHP.sub(dmg2);
      } else {
        currentHP = currentHP.sub(dmg2);
        currentHP2 = currentHP2.sub(dmg);
      }
      
      if (cHP > 0) {
        require(transfer(Controller(ContractProvider(CMC).contracts("Controller")).announceWinner(id, id2), stake * 2));
    } else if (cHP2 > 0) {
      require(transfer(Controller(ContractProvider(CMC).contracts("Controller")).announceWinner(id2, id), stake * 2));
    } else {
      //Event Draw.
    }

    setHealth(cHP, id);
    setHealth(cHP2, id2);
    }
  }

  function checkInitiative(uint256 a, uint256 b) private pure returns (bool) {
    return a > b;
  }

  function _announceWinner(uint256 _winner, uint256 _loser) private {
    Controller(ContractProvider(CMC).contracts("Controller")).announceWinner(_winner, _loser);
  }

  function setHealth(uint256 _value, uint256 id) private {
    Controller(ContractProvider(CMC).contracts("Controller")).setHealth(_value, id);
  }

  function healCreature(uint _cID) public returns (bool) {
    require(transfer(this, 100));
    Controller(ContractProvider(CMC).contracts("Controller")).healCreature(_cID);
  }
}