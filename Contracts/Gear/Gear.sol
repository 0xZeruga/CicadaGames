pragma solidity >=0.5.0 <0.6.0;

import "../Ownership/ownable.sol";
import "../SafeMath/safemath.sol";
import "../SolidityHelpers/solidityHelper.sol";
import "../Creatures/Creatures.sol";

contract Gear is Ownable, SolidityHelper, Creatures {

//Get all attribute modifications by gear
    function getCreatureArmorMods(string memory _gear) public pure returns(uint,uint,uint,uint) {
        require(bytes(_gear).length == 6, "ID length doesn't match");

        //Reads 0-9 items
        uint mainHand = stringToUint(getSlice(0, 1, _gear));
        uint offHand = stringToUint(getSlice(1, 2, _gear));
        uint helm = stringToUint(getSlice(2, 3, _gear));
        uint chest = stringToUint(getSlice(3, 4, _gear));
        uint legs = stringToUint(getSlice(4, 5, _gear));
        uint boots = stringToUint(getSlice(5, 6, _gear));

        return (
            getGearHealth(mainHand, offHand, helm, chest, legs, boots),
            getGearDamage(mainHand, offHand, helm, chest, legs, boots),
            getGearAccuracy(mainHand, offHand, helm, chest, legs, boots),
            getGearEvasion(mainHand, offHand, helm, chest, legs, boots)
        );
    }

//Get sum of gear health scores
    function getGearHealth(uint _mainHand, uint _offHand, uint _helm, uint _armor, uint _legs, uint _boots) public pure returns (uint) {
        return (
            getMainhandHealth(_mainHand) +
            getOffhandHealth(_offHand) +
            getHelmHealth(_helm) +
            getArmorHealth(_armor) +
            getLegsHealth(_legs) +
            getBootsHealth(_boots)
        );
    }

//Get sum of gear damage scores
    function getGearDamage(uint _mainHand, uint _offHand, uint _helm, uint _armor, uint _legs, uint _boots) public pure returns (uint) {
        return (
            getMainhandDamage(_mainHand) +
            getOffhandDamage(_offHand) +
            getHelmDamage(_helm) +
            getArmorDamage(_armor) +
            getLegsDamage(_legs) +
            getBootsDamage(_boots)
        );
    }

//Get sum of gear accuracy scores
    function getGearAccuracy(uint _mainHand, uint _offHand, uint _helm, uint _armor, uint _legs, uint _boots) public pure returns (uint) {
        return (
            getMainhandAccuracy(_mainHand) +
            getOffhandAccuracy(_offHand) +
            getHelmAccuracy(_helm) +
            getArmorAccuracy(_armor) +
            getLegsAccuracy(_legs) +
            getBootsAccuracy(_boots)
        );
    }

//Get sum of gear evasion scores
    function getGearEvasion(uint _mainHand, uint _offHand, uint _helm, uint _armor, uint _legs, uint _boots) public pure returns (uint) {
        return (
            getMainhandEvasion(_mainHand) +
            getOffhandEvasion(_offHand) +
            getHelmEvasion(_helm) +
            getArmorEvasion(_armor) +
            getLegsEvasion(_legs) +
            getBootsEvasion(_boots)
        );
    }

//Gets health for mainhand
    function getMainhandHealth(uint _mainHand) internal pure returns(uint) {
        require(_mainHand > -1 && _mainHand < 10, "Value too big or too small");
        if(_mainHand == 0) {return 0;}
        if(_mainHand == 1) {return 0;}
        if(_mainHand == 2) {return 0;}
        if(_mainHand == 3) {return 0;}
        if(_mainHand == 4) {return 0;}
        if(_mainHand == 5) {return 0;}
        if(_mainHand == 6) {return 0;}
        if(_mainHand == 7) {return 0;}
        if(_mainHand == 8) {return 0;}
        if(_mainHand == 9) {return 0;}
    }

//Gets health for offhand
    function getOffhandHealth(uint _offhand) internal pure returns(uint) {
        require(_offhand > -1 && _offhand < 10, "Value too big or too small");
        if(_offhand == 0) {return 0;}
        if(_offhand == 1) {return 0;}
        if(_offhand == 2) {return 0;}
        if(_offhand == 3) {return 0;}
        if(_offhand == 4) {return 0;}
        if(_offhand == 5) {return 0;}
        if(_offhand == 6) {return 0;}
        if(_offhand == 7) {return 0;}
        if(_offhand == 8) {return 0;}
        if(_offhand == 9) {return 0;}
    }

//Gets health for helm
    function getHelmHealth(uint _helm) internal pure returns(uint) {
        require(_helm > -1 && _helm < 10, "Value too big or too small");
        if(_helm == 0) {return 0;}
        if(_helm == 1) {return 0;}
        if(_helm == 2) {return 0;}
        if(_helm == 3) {return 0;}
        if(_helm == 4) {return 0;}
        if(_helm == 5) {return 0;}
        if(_helm == 6) {return 0;}
        if(_helm == 7) {return 0;}
        if(_helm == 8) {return 0;}
        if(_helm == 9) {return 0;}
    }

//Gets health for chest
    function getArmorHealth(uint _armor) internal pure returns(uint) {
        require(_armor > -1 && _armor < 10, "Value too big or too small");
        if(_armor == 0) {return 0;}
        if(_armor == 1) {return 0;}
        if(_armor == 2) {return 0;}
        if(_armor == 3) {return 0;}
        if(_armor == 4) {return 0;}
        if(_armor == 5) {return 0;}
        if(_armor == 6) {return 0;}
        if(_armor == 7) {return 0;}
        if(_armor == 8) {return 0;}
        if(_armor == 9) {return 0;}
    }

//Gets health for legs
    function getLegsHealth(uint _legs) internal pure returns(uint) {
        require(_legs > -1 && _legs < 10, "Value too big or too small");
        if(_legs == 0) {return 0;}
        if(_legs == 1) {return 0;}
        if(_legs == 2) {return 0;}
        if(_legs == 3) {return 0;}
        if(_legs == 4) {return 0;}
        if(_legs == 5) {return 0;}
        if(_legs == 6) {return 0;}
        if(_legs == 7) {return 0;}
        if(_legs == 8) {return 0;}
        if(_legs == 9) {return 0;}
    }

//Gets health for boots
    function getBootsHealth(uint _boots) internal pure returns(uint) {
        require(_boots > -1 && _boots < 10, "Value too big or too small");
        if(_boots == 0) {return 0;}
        if(_boots == 1) {return 0;}
        if(_boots == 2) {return 0;}
        if(_boots == 3) {return 0;}
        if(_boots == 4) {return 0;}
        if(_boots == 5) {return 0;}
        if(_boots == 6) {return 0;}
        if(_boots == 7) {return 0;}
        if(_boots == 8) {return 0;}
        if(_boots == 9) {return 0;}
    }

//Gets damage for mainhand
    function getMainhandDamage(uint _mainHand) internal pure returns(uint) {
        require(_mainHand > -1 && _mainHand < 10, "Value too big or too small");
        if(_mainHand == 0) {return 0;}
        if(_mainHand == 1) {return 0;}
        if(_mainHand == 2) {return 0;}
        if(_mainHand == 3) {return 0;}
        if(_mainHand == 4) {return 0;}
        if(_mainHand == 5) {return 0;}
        if(_mainHand == 6) {return 0;}
        if(_mainHand == 7) {return 0;}
        if(_mainHand == 8) {return 0;}
        if(_mainHand == 9) {return 0;}
    }

//Gets damage for offhand
    function getOffhandDamage(uint _offhand) internal pure returns(uint) {
        require(_offhand > -1 && _offhand < 10, "Value too big or too small");
        if(_offhand == 0) {return 0;}
        if(_offhand == 1) {return 0;}
        if(_offhand == 2) {return 0;}
        if(_offhand == 3) {return 0;}
        if(_offhand == 4) {return 0;}
        if(_offhand == 5) {return 0;}
        if(_offhand == 6) {return 0;}
        if(_offhand == 7) {return 0;}
        if(_offhand == 8) {return 0;}
        if(_offhand == 9) {return 0;}
    }
    
//Gets damage for helm
    function getHelmDamage(uint _helm) internal pure returns(uint) {
        require(_helm > -1 && _helm < 10, "Value too big or too small");
        if(_helm == 0) {return 0;}
        if(_helm == 1) {return 0;}
        if(_helm == 2) {return 0;}
        if(_helm == 3) {return 0;}
        if(_helm == 4) {return 0;}
        if(_helm == 5) {return 0;}
        if(_helm == 6) {return 0;}
        if(_helm == 7) {return 0;}
        if(_helm == 8) {return 0;}
        if(_helm == 9) {return 0;}
    }

//Gets damage for armor
    function getArmorDamage(uint _armor) internal pure returns(uint) {
        require(_armor > -1 && _armor < 10, "Value too big or too small");
        if(_armor == 0) {return 0;}
        if(_armor == 1) {return 0;}
        if(_armor == 2) {return 0;}
        if(_armor == 3) {return 0;}
        if(_armor == 4) {return 0;}
        if(_armor == 5) {return 0;}
        if(_armor == 6) {return 0;}
        if(_armor == 7) {return 0;}
        if(_armor == 8) {return 0;}
        if(_armor == 9) {return 0;}
    }

//Gets damage for legs
    function getLegsDamage(uint _legs) internal pure returns(uint) {
        require(_legs > -1 && _legs < 10, "Value too big or too small");
        if(_legs == 0) {return 0;}
        if(_legs == 1) {return 0;}
        if(_legs == 2) {return 0;}
        if(_legs == 3) {return 0;}
        if(_legs == 4) {return 0;}
        if(_legs == 5) {return 0;}
        if(_legs == 6) {return 0;}
        if(_legs == 7) {return 0;}
        if(_legs == 8) {return 0;}
        if(_legs == 9) {return 0;}
    }

//Gets damage for boots
    function getBootsDamage(uint _boots) internal pure returns(uint) {
        require(_boots > -1 && _boots < 10, "Value too big or too small");
        if(_boots == 0) {return 0;}
        if(_boots == 1) {return 0;}
        if(_boots == 2) {return 0;}
        if(_boots == 3) {return 0;}
        if(_boots == 4) {return 0;}
        if(_boots == 5) {return 0;}
        if(_boots == 6) {return 0;}
        if(_boots == 7) {return 0;}
        if(_boots == 8) {return 0;}
        if(_boots == 9) {return 0;}
    }

//Gets accuracy for mainhand
    function getMainhandAccuracy(uint _mainHand) internal pure returns(uint) {
        require(_mainHand > -1 && _mainHand < 10, "Value too big or too small");
        if(_mainHand == 0) {return 0;}
        if(_mainHand == 1) {return 0;}
        if(_mainHand == 2) {return 0;}
        if(_mainHand == 3) {return 0;}
        if(_mainHand == 4) {return 0;}
        if(_mainHand == 5) {return 0;}
        if(_mainHand == 6) {return 0;}
        if(_mainHand == 7) {return 0;}
        if(_mainHand == 8) {return 0;}
        if(_mainHand == 9) {return 0;}
    }

//Gets accuracy for offhand
    function getOffhandAccuracy(uint _offhand) internal pure returns(uint) {
        require(_mainH_offhandand > -1 && _offhand < 10, "Value too big or too small");
        if(_offhand == 0) {return 0;}
        if(_offhand == 1) {return 0;}
        if(_offhand == 2) {return 0;}
        if(_offhand == 3) {return 0;}
        if(_offhand == 4) {return 0;}
        if(_offhand == 5) {return 0;}
        if(_offhand == 6) {return 0;}
        if(_offhand == 7) {return 0;}
        if(_offhand == 8) {return 0;}
        if(_offhand == 9) {return 0;}
    }

//Gets accuracy for helm
    function getHelmAccuracy(uint _helm) internal pure returns(uint) {
        require(_helm > -1 && _helm < 10, "Value too big or too small");
        if(_helm == 0) {return 0;}
        if(_helm == 1) {return 0;}
        if(_helm == 2) {return 0;}
        if(_helm == 3) {return 0;}
        if(_helm == 4) {return 0;}
        if(_helm == 5) {return 0;}
        if(_helm == 6) {return 0;}
        if(_helm == 7) {return 0;}
        if(_helm == 8) {return 0;}
        if(_helm == 9) {return 0;}
    }

//Gets accuracy for armor
    function getArmorAccuracy(uint _armor) internal pure returns(uint) {
        require(_armor > -1 && _armor < 10, "Value too big or too small");
        if(_armor == 0) {return 0;}
        if(_armor == 1) {return 0;}
        if(_armor == 2) {return 0;}
        if(_armor == 3) {return 0;}
        if(_armor == 4) {return 0;}
        if(_armor == 5) {return 0;}
        if(_armor == 6) {return 0;}
        if(_armor == 7) {return 0;}
        if(_armor == 8) {return 0;}
        if(_armor == 9) {return 0;}
    }

//Gets accuracy for legs
    function getLegsAccuracy(uint _legs) internal pure returns(uint) {
        require(_legs > -1 && _legs < 10, "Value too big or too small");
        if(_legs == 0) {return 0;}
        if(_legs == 1) {return 0;}
        if(_legs == 2) {return 0;}
        if(_legs == 3) {return 0;}
        if(_legs == 4) {return 0;}
        if(_legs == 5) {return 0;}
        if(_legs == 6) {return 0;}
        if(_legs == 7) {return 0;}
        if(_legs == 8) {return 0;}
        if(_legs == 9) {return 0;}
    }

//Gets accuracy for boots
    function getBootsAccuracy(uint _boots) internal pure returns(uint) {
        require(_boots > -1 && _boots < 10, "Value too big or too small");
        if(_boots == 0) {return 0;}
        if(_boots == 1) {return 0;}
        if(_boots == 2) {return 0;}
        if(_boots == 3) {return 0;}
        if(_boots == 4) {return 0;}
        if(_boots == 5) {return 0;}
        if(_boots == 6) {return 0;}
        if(_boots == 7) {return 0;}
        if(_boots == 8) {return 0;}
        if(_boots == 9) {return 0;}
    }

//Gets evasion for mainhand
    function getMainhandEvasion(uint _mainHand) internal pure returns(uint) {
        require(_mainHand > -1 && _mainHand < 10, "Value too big or too small");
        if(_mainHand == 0) {return 0;}
        if(_mainHand == 1) {return 0;}
        if(_mainHand == 2) {return 0;}
        if(_mainHand == 3) {return 0;}
        if(_mainHand == 4) {return 0;}
        if(_mainHand == 5) {return 0;}
        if(_mainHand == 6) {return 0;}
        if(_mainHand == 7) {return 0;}
        if(_mainHand == 8) {return 0;}
        if(_mainHand == 9) {return 0;}
    }

//Gets evasion for offhand
    function getOffhandEvasion(uint _offHand) internal pure returns(uint) {
        require(_offHand > -1 && _offHand < 10, "Value too big or too small");
        if(_offHand == 0) {return 0;}
        if(_offHand == 1) {return 0;}
        if(_offHand == 2) {return 0;}
        if(_offHand == 3) {return 0;}
        if(_offHand == 4) {return 0;}
        if(_offHand == 5) {return 0;}
        if(_offHand == 6) {return 0;}
        if(_offHand == 7) {return 0;}
        if(_offHand == 8) {return 0;}
        if(_offHand == 9) {return 0;}
    }

//Gets evasion for helm
    function getHelmEvasion(uint _helm) internal pure returns(uint) {
        require(_helm > -1 && _helm < 10, "Value too big or too small");
        if(_helm == 0) {return 0;}
        if(_helm == 1) {return 0;}
        if(_helm == 2) {return 0;}
        if(_helm == 3) {return 0;}
        if(_helm == 4) {return 0;}
        if(_helm == 5) {return 0;}
        if(_helm == 6) {return 0;}
        if(_helm == 7) {return 0;}
        if(_helm == 8) {return 0;}
        if(_helm == 9) {return 0;}
    }

//Gets evasion for armor
    function getArmorEvasion(uint _armor) internal pure returns(uint) {
        require(_armor > -1 && _armor < 10, "Value too big or too small");
        if(_armor == 0) {return 0;}
        if(_armor == 1) {return 0;}
        if(_armor == 2) {return 0;}
        if(_armor == 3) {return 0;}
        if(_armor == 4) {return 0;}
        if(_armor == 5) {return 0;}
        if(_armor == 6) {return 0;}
        if(_armor == 7) {return 0;}
        if(_armor == 8) {return 0;}
        if(_armor == 9) {return 0;}
    }

//Gets evasion for legs
    function getLegsEvasion(uint _legs) internal pure returns(uint) {
        require(_legs > -1 && _legs < 10, "Value too big or too small");
        if(_legs == 0) {return 0;}
        if(_legs == 1) {return 0;}
        if(_legs == 2) {return 0;}
        if(_legs == 3) {return 0;}
        if(_legs == 4) {return 0;}
        if(_legs == 5) {return 0;}
        if(_legs == 6) {return 0;}
        if(_legs == 7) {return 0;}
        if(_legs == 8) {return 0;}
        if(_legs == 9) {return 0;}
    }

//Gets evasion for boots
    function getBootsEvasion(uint _boots) internal pure returns(uint) {
        require(_boots > -1 && _boots < 10, "Value too big or too small");
        if(_boots == 0) {return 0;}
        if(_boots == 1) {return 0;}
        if(_boots == 2) {return 0;}
        if(_boots == 3) {return 0;}
        if(_boots == 4) {return 0;}
        if(_boots == 5) {return 0;}
        if(_boots == 6) {return 0;}
        if(_boots == 7) {return 0;}
        if(_boots == 8) {return 0;}
        if(_boots == 9) {return 0;}
    }
}