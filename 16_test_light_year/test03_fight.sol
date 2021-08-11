// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

contract LightYearTest {

    uint256 number;
    uint8 constant MAX_UINT8 = 255;
    uint16 constant MAX_UINT16 = 65535;
    uint32 constant MAX_UINT32 = 4294967295;

    struct Ship {
        uint16 attack;
        uint16 defense;
        uint16 agility;
        uint16 accuracy;
        int16 health;
    }

    function store(uint256 num) public {
        number = num;
    }

    function retreive() public view returns (uint256){
        return number;
    }

    bytes battleBytes = new bytes(5);

    function battle() public pure returns (bytes memory){
        Ship memory attacker = Ship(100, 100, 100, 100, 100);
        Ship memory defender = Ship(100, 100, 100, 100, 100);

        uint256 count = 0;
        while (true) {
            count++;
            if (count >= 20) {
                break;
            }

            uint16 damage = _attack(attacker, defender);

            attacker.health -= damage;
            //   if(attacker.health)
        }


    }

    function _attack(Ship memory attacker, Ship memory defender) private pure returns (uint16){
        uint16 h = defender.health - attacker.attack;

        uint16 damage = attacker.attack + attacker.attack * attacker.accuracy / (attacker.attack + attacker.accuracy);
        uint16 resist = defender.defense + defender.defense * defender.agility / (defender.defense + defender.agility);

        uint16 realDamage = damage * damage / (damage + resist);
        defender.health -= realDamage;

        return (realDamage);

    }

    function getBytes(uint256 i) public pure returns (bytes memory){
        bytes memory b = new bytes(i);
        return b;
    }

    function getHealth() public pure returns (uint256){
        uint256 a = 50;
        uint256 b = 100;
        return a - b;
    }


}





