pragma solidity ^0.5.0;

import "./CMCEnabled.sol";
import "./ERC/ERC20Detailed.sol";
import "./Tools/SafeMath.sol";
import "./Tools/Ownable.sol";

contract Storage is CMCEnabled, ERC20Detailed, Ownable {

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowed;
    mapping (address => Creature[]) public myCreatures;
    mapping (uint256 => address) public ownerOfCreatureId;
    mapping (uint256 => Creature) public allCreatures;
    mapping (uint256 => Fight) public fights;

    mapping(address=>uint) public healthcareLevel;
    mapping(address=>uint) public blacksmithLevel;
    mapping(address=>uint) public dinnerhallLevel;
    mapping(address=>uint) public practiveareaLevel;

    string private TOKEN_NAME = "PixelCoin";
    string private TOKEN_SYMBOL = "PXL";
    uint8 private TOKEN_DECIMALS = 0;
    uint256 private _totalSupply = 1000000 * (10 ** uint256(TOKEN_DECIMALS));
    uint256 private fightID = 0;

    uint256 private toughnessmodifier = 10;
    uint256 private strengthmodifier = 2;
    uint256 private agilitymodifier = 5;

    uint256 public constant BASE_EXP_THRESHHOLD = 1000;
    uint256 public constant WINNER_EXP = 500;
    uint256 public constant LOSER_EXP = 100;
    uint256 public constant MAX_FACILITY_LEVEL = 5;

    using SafeMath for uint256;

    /*
        Token Functionality
    */
    function etherSent() public payable {
        mint(msg.sender, msg.value * 100);
    }

    function totalSupply() external isCMCEnabled("Storage") view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address owner) external isCMCEnabled("Storage") view returns (uint256) {
        return _balances[owner];
    }

    function allowance(address owner, address spender) external isCMCEnabled("Storage") view returns (uint256) {
        return _allowed[owner][spender];
    }

    function transfer(address to, uint256 value) external isCMCEnabled("Storage") returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    function _transfer(address from, address to, uint256 value) internal {
        require(value <= _balances[from], "Sender must have sufficient balance");
        require(to != address(0), "Can't send to none");

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);

        Transfer(msg.sender, to, value);
    }

    function approve(address spender, uint256 value) external isCMCEnabled("Storage") returns (bool) {
        require(spender != address(0), "Can't approve THIS");

        _allowed[msg.sender][spender] = value;
        Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external isCMCEnabled("Storage") returns (bool) {
        require(value <= _balances[from], "Must have sufficient balance");
        require(value <= _allowed[from][msg.sender], "Must have sufficient allowance");
        require(to != address(0), "Can't send to none");

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);

        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
        Transfer(from, to, value);
        return true;
    }

    function mint(address account, uint256 amount) public isCMCEnabled("Storage") returns (bool) {
        require(amount != 0, "Can't mint zero");
        _mint(account, amount);
        return true;
    }

    function _mint(address account, uint256 amount) internal {
        require(amount != 0, "Can't mint 0 amount");
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        Transfer(address(0), account, amount);
    }

    /*
        Creature functionality
    */

    function makeCreature(uint _id, uint _maxhealth, uint _damage, string _race, string _name) external isCMCEnabled("Storage") returns (bool) {
      Creature memory c = Creature({
        owner: msg.sender,
        id: _id,
        maxhealth: _maxhealth,
        currenthealth: _maxhealth,
        damage: _damage,
        initiative: 10,
        race: _race,
        name: _name,
        isStaged : false,
        kills: 0,
        experience: 0,
        level: 1,
        skillpoint: 10,
        absorb: 0
      });
      myCreatures[msg.sender].push(c);
      ownerOfCreatureId[_id] = msg.sender;
      allCreatures[_id] = c;
    }

    function getOwnerOfCreature(uint256 _id) public isCMCEnabled("Storage") returns (address) {
        return ownerOfCreatureId[_id];
    }

    function destroyCreature(uint256 _id) external isCMCEnabled("Storage") returns (bool) {
        require(ownerOfCreatureId[_id] == msg.sender, "Can't destroy others creatures");
        delete ownerOfCreatureId[_id];
        delete allCreatures[_id];
        for (uint i = 0; i < myCreatures[msg.sender].length; i++) {
            if (myCreatures[msg.sender][i].id == _id) {
                delete myCreatures[msg.sender][i];
            }
        }
    }

    function healCreature(uint256 _cID) external isCMCEnabled("Storage") returns (bool) {
        addHealth(_cID, 100);
        return true;
    }


    /*
    Combat functionality
    */

  function createFight(uint _stagedMonster, uint _stake, uint _expirationBlock) external isCMCEnabled("Storage") returns (bool) {
   require(allCreatures[_stagedMonster].currenthealth > 0 && allCreatures[_stagedMonster].isStaged == false, "Creature already staged");
      Fight memory f = Fight({
        id : _incrementFightID(),
        combatant : allCreatures[_stagedMonster],
        stake : _stake,
        expirationBlock : _expirationBlock,
        isOpen : true
        });
    allCreatures[_stagedMonster].isStaged = true;
    fights[f.id] = f;
    //TODO Event Add fight to table
    return true;
    }

    function _incrementFightID() internal returns (uint256) {
        fightID = fightID.add(1);
        return fightID;
    }

    function getFightByID(uint256 _id) external isCMCEnabled("Storage") returns (uint256, uint256, uint256, uint256, uint256) {
        Fight memory f = fights[_id];
        return (f.combatant.id, f.stake, f.combatant.currenthealth, f.combatant.damage, f.combatant.initiative);
    }

    function getCreatureByID(uint256 _id) external isCMCEnabled("Storage") returns (uint256, uint256, uint256, uint256) {
        Creature memory c = allCreatures[_id];
        return (c.id, c.currenthealth, c.damage, c.initiative);
    }

    function openFight(Fight _f, Creature _c) external isCMCEnabled("Storage") returns (bool) {
        _f.isOpen = false;
        _c.isStaged = true;
        //TODO Event Ongoing fight
    }

    function announceWinner(uint256 _winner, uint256 _loser) external isCMCEnabled("Storage") returns (address) {
        allCreatures[_winner].isStaged = false;
        allCreatures[_loser].isStaged = false;
        allCreatures[_winner].kills = allCreatures[_winner].kills.add(1);
        allCreatures[_winner].experience = allCreatures[_winner].experience.add(WINNER_EXP);
        allCreatures[_loser].experience = allCreatures[_loser].experience.add(LOSER_EXP);
        return getOwnerOfCreature(_winner);
    }

    function setHealth(uint _value, uint256 id) external isCMCEnabled("Storage") {
         allCreatures[id].currenthealth = _value;
    }

    function addHealth(uint v, uint256 i) internal {
       allCreatures[i].currenthealth = allCreatures[i].currenthealth.add(v);
       if (allCreatures[i].currenthealth > allCreatures[i].maxhealth) {
           allCreatures[i].currenthealth = allCreatures[i].maxhealth;
       }
    }

    function joinFight(uint256 f, uint256 c) external isCMCEnabled("Storage") returns (bool) {
        fights[f].isOpen = false;
        allCreatures[c].isStaged = true;
        return true;
    }

    function setCombatCritChance(uint[] memory randomnumbers, uint round, uint critchance) public returns (bool) {
        return randomnumbers[round] < critchance;
    }

    function getCritDamageMultiplier(uint basedamage, uint critmult) public returns (uint) {
        return basedamage * critmult;
    }

    /*
    Levling functionality
    */

    function addExperience(uint256 _creatureID, uint256 _amount) private isCMCEnabled("Storage") returns (bool) {
        allCreatures[_creatureID].experience += allCreatures[_creatureID].experience.add(_amount);
    }

    function checkLevelUp(uint256 _creatureID) public returns (bool) {
        if (allCreatures[_creatureID].experience >= BASE_EXP_THRESHHOLD.mul(allCreatures[_creatureID].level)) {
            allCreatures[_creatureID].experience = allCreatures[_creatureID].experience.sub(BASE_EXP_THRESHHOLD);
            allCreatures[_creatureID].level.add(1);
            allCreatures[_creatureID].skillpoint.add(1);
        }
    }

    function expToNextLevel(uint256 _level) public pure returns (uint256 exp) {
        exp = BASE_EXP_THRESHHOLD.mul(_level);
    }

    function improveSkills(uint256 _toughness, uint256 _strength, uint256 _agility, uint256 _creatureID) public view returns (bool) {
        require(_toughness.add(_strength).add(_agility) <= allCreatures[_creatureID].skillpoint, "No skillpoint available for spending");
        require(allCreatures[_creatureID].owner == msg.sender, "Must be creature owner");
        allCreatures[_creatureID].skillpoint.sub(_toughness);
        allCreatures[_creatureID].skillpoint.sub(_strength);
        allCreatures[_creatureID].skillpoint.sub(_agility);

        allCreatures[_creatureID].currenthealth.add(_toughness.mul(toughnessmodifier));
        allCreatures[_creatureID].damage.add(_strength.mul(strengthmodifier));
        allCreatures[_creatureID].initiative.add(_agility.mul(agilitymodifier));
    }

    function setSkillModifiers(uint256 _t, uint256 _s, uint256 _a) public {
        require(isOwner(), "Require ownership");
        toughnessmodifier = _t;
        strengthmodifier = _s;
        agilitymodifier = _a;
    }
    /*-
    Gear functionality
    */

    mapping(uint256=>Gear) public allGears; //GearID -> Gear
    mapping(uint256=>uint256[]) public creatureGears; //creatureID -> GearIDs
    mapping(address=>uint256[]) public ownedGears; //owner -> GearIDs

    uint public gearID;

    function addGear(uint8 slot, uint256 price, uint8 absorb, uint8 damage, uint8 healthbonus, uint8 initbonus) public {
        require(isOwner(), "Require ownership");
        gearID = gearID.add(1);
        Gear memory g = Gear(gearID, slot, price, absorb, damage, healthbonus, initbonus);
        allGears[gearID] = g;
    }

    function removeGear(uint g) public {
        require(isOwner(), "Require ownership");
        delete allGears[g];
    }

    function updateGear(uint id, uint8 slot, uint256 price, uint8 absorb, uint8 damage, uint8 healthbonus, uint8 initbonus) public {
        require(isOwner(), "Require ownership");
        allGears[id].slot = slot;
        allGears[id].price = price;
        allGears[id].absorb = absorb;
        allGears[id].damage = damage;
        allGears[id].healthbonus = healthbonus;
        allGears[id].initbonus = initbonus;
    }
    function purchaseGear(uint itemID) public {
        require(allGears[itemID].price > 0, "Can't purchase free items");
        ownedGears[msg.sender][itemID] = itemID;
    }

    function getGear(uint itemID) public view returns (Gear) {
        return allGears[itemID];
    }

    function equipGear(uint _gearID, uint _creatureID) public {
        require(ownedGears[msg.sender][_gearID] == _gearID, "You don't own this gear");
        require(getOwnerOfCreature(_creatureID) == msg.sender, "You don't own this creature");

        //for item in creatureGears. if slot == itemid.slot. revert();
        uint creatureEquippedLength = creatureGears[_creatureID].length;
        for (uint i = 0; i < creatureEquippedLength; i++) {
            uint a = creatureGears[_creatureID][i];
            Gear memory g = getGear(a);
            if (g.slot == allGears[_gearID].slot) {
                //Gear slot already equipped
                revert("Gear already equipped");
            }
        }
        creatureGears[_creatureID][_gearID] = gearID;
        delete ownedGears[msg.sender][_gearID];

        allCreatures[_creatureID].absorb = allCreatures[_creatureID].initiative.add(g.absorb);
        allCreatures[_creatureID].damage = allCreatures[_creatureID].initiative.add(g.damage);
        allCreatures[_creatureID].maxhealth = allCreatures[_creatureID].initiative.add(g.healthbonus);
        allCreatures[_creatureID].initiative = allCreatures[_creatureID].initiative.add(g.initbonus);
        allCreatures[cID].carryCapacity = allCreatures[cID].currentlyCarrying.add(g.weight);
    }

    function unequipGear(uint gID, uint cID) public {
        require(getOwnerOfCreature(cID) == msg.sender, "You must own this creature to unequip gear from it");

        uint creatureEquippedLength = creatureGears[cID].length;
        for (uint i = 0; i < creatureEquippedLength; i++) {
            uint a = creatureGears[cID][i];
            Gear memory g = getGear(a);
            if (g.slot == allGears[gID].slot) {
                //If gear exist on slot.
                ownedGears[msg.sender][gearID];
                delete creatureGears[cID][gID];
                allCreatures[cID].absorb = allCreatures[cID].initiative.sub(g.absorb);
                allCreatures[cID].damage = allCreatures[cID].initiative.sub(g.damage);
                allCreatures[cID].maxhealth = allCreatures[cID].initiative.sub(g.healthbonus);
                allCreatures[cID].initiative = allCreatures[cID].initiative.sub(g.initbonus);
                allCreatures[cID].carryCapacity = allCreatures[cID].currentlyCarrying.sub(g.weight);
            }
        }
    }

    function getCarryWeightInProcent(uint current, uint max) external isCMCEnabled("Storage") returns (uint) {
        return current / max;
    }

    function getCarryWeight(uint cID) external isCMCEnabled("Storage") returns (uint) {
       return (allCreatures[cID].strength * 2).add(5);
    }

    function getInitiative(uint cID) external isCMCEnabled("Storage") returns (uint) {
       return (allCreatures[cID].agility * 2);
    }

    function getMaxHealth(uint cID) external isCMCEnabled("Storage") returns (uint) {
        //TODO add gear mods.
       return (allCreatures[cID].toughness * 2).add(5);
    }
    function getCurrentHealth(uint cID) external isCMCEnabled("Storage") returns (uint) {
       return (allCreatures[cID].currenthealth);
    }
    function getMaxEnergy(uint cID) external isCMCEnabled("Storage") returns (uint) {
        //TODO add gear mods.
       return (allCreatures[cID].endurance * 2).add(5);
    }
    function getCurrentEnergy(uint cID) external isCMCEnabled("Storage") returns (uint) {
       return (allCreatures[cID].currentenergy);
    }

    function getDodgeChance(uint cID) external isCMCEnabled("Storage") returns (uint) {
        //TODO: Add mods depending on carrying capacity
        return (allCreatures[cID].agility).add(3);
    }
    function getCriticalChance(uint cID) external isCMCEnabled("Storage") returns (uint) {
        //TODO: Add mods for weapon
        return (allCreatures[cID].agility).add(3);
    }

    function getUpdatedStats(uint cID) external isCMCEnabled("Storage") returns (uint) {
        allCreatures[cID].maxhealth = getMaxHealth(cID);
        allCreatures[cID].currenthealth = getCurrentHealth(cID);
        allCreatures[cID].maxenergy = getMaxEnergy(cID);
        allCreatures[cID].currentenergy = getCurrentEnergy(cID);

        allCreatures[cID].critchance = getCriticalChance(cID);
        allCreatures[cID].critmult = getCritDamageMultiplier(cID);
        allCreatures[cID].dodgechance = getDodgeChance(cID);
        allCreatures[cID].initiative = getInitiative(cID);

        allCreatures[cID].monsterkills = getMonsterKills(cID);
        allCreatures[cID].playerkills = getPlayerKills(cID);
        allCreatures[cID].deaths = getDeaths(cID);
    }


    //STATS
    function getMonsterKills(uint cID) external isCMCEnabled("Storage") returns (uint) {
        return allCreatures[cID].monsterkills;
    }

    function getPlayerKills(uint cID) external isCMCEnabled("Storage") returns (uint) {
        return allCreatures[cID].playerkills;
    }

    function getDeaths(uint cID) external isCMCEnabled("Storage") returns (uint) {
        return allCreatures[cID].deaths;
    }

    /*

        Facility functionality

    */

    function getFacilityLevel(uint facility) external isCMCEnabled("Storage") returns (uint) {
        if(facility == 0) {
            return healthcareLevel[msg.sender];
        }
        if(facility == 1) {
            return blacksmithLevel[msg.sender];
        }
        if(facility == 2) {
            return dinnerhallLevel[msg.sender];
        }
        if(facility == 3) {
            return practiveareaLevel[msg.sender];
        }
    }

    function incrementFacilityLevel() external isCMCEnabled("Storage") returns (bool) {
        if(facility == 0) {
            require(healthcareLevel[msg.sender] < MAX_FACILITY_LEVEL, "Current facility level must be lower than max");
            healthcareLevel[msg.sender].add(1);
        }
        if(facility == 1) {
            require(blacksmithLevel[msg.sender] < MAX_FACILITY_LEVEL, "Current facility level must be lower than max");
            blacksmithLevel[msg.sender].add(1);
        }
        if(facility == 2) {
            require(dinnerhallLevel[msg.sender] < MAX_FACILITY_LEVEL, "Current facility level must be lower than max");
            dinnerhallLevel[msg.sender].add(1);
        }
        if(facility == 3) {
            require(practiveareaLevel[msg.sender] < MAX_FACILITY_LEVEL, "Current facility level must be lower than max");
            practiveareaLevel[msg.sender].add(1);
        }
    }

    /*
        Auction functionality
    */

    mapping(uint256 => uint256) public auctionedCreatures;


    function getPrice(uint c) external isCMCEnabled("Storage") returns (uint256) {
        return auctionedCreatures[c];
    }

    function auctionCreature(uint c, uint p) external isCMCEnabled("Storage") returns (bool) {
        require(allCreatures[c].owner == msg.sender, "Can't auction unowned creature");
        auctionedCreatures[c] = p;
        return true;
        //TODO: Event Creature for auction
    }

    function removeAuction(uint c) external isCMCEnabled("Storage") returns (bool) {
        require(allCreatures[c].owner == msg.sender, "Can't remove auction of unowned creature");
        delete auctionedCreatures[c];
        return true;
    }

    function buyAuction(uint c) external isCMCEnabled("Storage") returns (bool) {
        allCreatures[c].owner = msg.sender;
        ownerOfCreatureId[c] = msg.sender;
        myCreatures[msg.sender].push(allCreatures[c]);
        delete auctionedCreatures[c];
        return true;
    }
}