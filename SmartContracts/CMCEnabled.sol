pragma solidity ^0.5.0;

import "./ContractProvider.sol";

/**
 * Base class for every contract (DB, Controller, ALC,)
 * Once CMC address is set it cannot be changed except from within itself.
**/

contract CMCEnabled {

    address public CMC;

    struct Creature {
        address owner;
        uint256 id;
        uint256 maxhealth;
        uint256 currenthealth;
        uint256 damage;
        uint256 initiative;
        string race;
        string name;
        bool isStaged;
        uint kills;
        uint256 experience;
        uint256 level;
        uint256 skillpoint;
        uint256 absorb;
        uint256 carrycapacity;
        uint256 currentlyCarrying;
        uint currentlyCarrying;
        uint initiative;
        uint baseAttackDamage;
        uint baseDodgeChance;
        uint baseCriticalChance;
        uint criticalDamageMultiplier;
        uint monsterKills;
        uint playerKills;
        uint deaths;
        uint strength;
        uint agility;
        uint toughness;
        uint endurance;
        uint currentenergy;
        uint maxenergy;
    }

    struct Fight {
        uint256 id;
        Creature combatant;
        uint256 stake;
        uint256 expirationBlock;
        bool isOpen;
    }

    struct Gear {
        uint256 gearID;
        uint8 slot;
        uint256 price;
        uint8 absorb;
        uint8 damage;
        uint8 healthbonus;
        uint8 initbonus;
        uint8 weight;
    }

    modifier isCMCEnabled(bytes32 _name) {
        if (CMC == 0x0 && msg.sender != ContractProvider(CMC).contracts(_name)) {
            revert("Reverting");
        _;
        }
    }

    function setCMCAddress(address _cMC) external {
        if (CMC != 0x0 && msg.sender != CMC) {
            revert("Reverting");
        } else {
            CMC = _cMC;
        }
    }

    function changeCMCAddress(address _newCMC) external {
        require(CMC == msg.sender, "Only CMC owner can change this");
        CMC = _newCMC;
    }

    function kill() external {
        assert(msg.sender == CMC);
        selfdestruct(CMC);
    }
}