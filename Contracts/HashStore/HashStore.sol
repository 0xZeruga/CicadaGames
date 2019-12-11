pragma solidity >=0.5.0 <0.6.0;

contract HashStore {
  /*
  *  Events
  */
  event OwnershipTransferred(address indexed _previousOwner, address indexed _newOwner);
  event NewHashStored(address indexed _hashSender, uint _hashId, string _hashContent, uint timestamp);
  event Withdrawn(address indexed _hashSender, uint amount);

  /*
  * Storage
  */

  struct Hash {
    // sender address
    address sender;
    // hash text
    string content;
    // creation timestamp
    uint timestamp;
  }

  // Hashes mapping
  mapping(uint => Hash) public hashes;
  // Contract owner
  address public owner;
  // Last stored Hash Id
  uint public lastHashId;
  // Service price in Wei
  uint public price;

  /*
  * Modifiers
  */

  modifier onlyOwner() {
    require(msg.sender == owner, "Only owner");
    _;
  }

  /*
  * Public functions
  */

  /**
  * @dev Contract constructor
  * @param _price Service price
  */
  constructor(uint _price) public {
    // check price valid
    require(_price > 0, "Price must be over 0");

    // assign owner
    owner = msg.sender;
    // assign price
    price = _price;
    // init ids
    lastHashId = 0;
  }

  /**
  * @dev Transfer contract ownership
  * @param _newOwner New owner address
  */
  function transferOwnership(address _newOwner) public onlyOwner() {
    // check address not null
    require(_newOwner != address(0), "New owner can't be same as current owner");

    // assign new owner
    owner = _newOwner;

    // Log event
    emit OwnershipTransferred(owner, _newOwner);
  }

  /**
  * @dev Withdraw contract accumulated Eth balance
  */
  function withdrawBalance() public onlyOwner() {
    uint256 amount = address(this).balance;

    // transfer balance
    owner.transfer(amount);

    // Log event
    emit Withdrawn(owner, amount);
  }

  /**
  * @dev save new hash
  * @param _hashContent Hash Content
  */
  function save(string memory _hashContent) public payable  {
    // only save if service price paid
    require(msg.value >= price, "Value must be higher than price");

    // create Hash
    uint hashId = ++lastHashId;
    hashes[hashId].sender = msg.sender;
    hashes[hashId].content = _hashContent;
    hashes[hashId].timestamp = block.timestamp;

    // Log event
    emit NewHashStored(hashes[hashId].sender, hashId, hashes[hashId].content, hashes[hashId].timestamp);
  }

  /**
  * @dev find hash by id
  * @param _hashId Hash Id
  */
  function find(uint _hashId) public view returns (address hashSender, string memory hashContent, uint hashTimestamp) {
    return (hashes[_hashId].sender, hashes[_hashId].content, hashes[_hashId].timestamp);
  }
}