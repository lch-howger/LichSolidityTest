// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

contract LightYearTest {

    uint8 constant MAX_UINT8 = 255;
    uint16 constant MAX_UINT16 = 65535;
    uint32 constant MAX_UINT32 = 4294967295;

    struct Ship {
        uint16 attack;
        uint16 defense;
        uint16 agility;
        uint16 accuracy;
        uint16 health;
    }

    function pureBattle() public pure returns (bytes memory){
        Ship memory attacker = Ship(100, 100, 100, 100, 100);
        Ship memory defender = Ship(100, 100, 100, 100, 100);

        bytes memory battleBytes = "";

        uint256 count = 0;
        while (true) {
            count++;
            if (count >= 20) {
                break;
            }

            uint16 damage = _attack(attacker, defender);
            defender.health = _causeDamage(defender.health, damage);

            battleBytes = _addBytes(battleBytes, defender.health);

            if (defender.health <= 0) {
                break;
            }

            damage = _attack(defender, attacker);
            attacker.health = _causeDamage(attacker.health, damage);

            battleBytes = _addBytes(battleBytes, attacker.health);

            if (attacker.health <= 0) {
                break;
            }

        }

        return battleBytes;
    }

    function _addBytes(bytes memory b, uint16 i) private pure returns (bytes memory){
        return _mergeBytes(b, abi.encodePacked(i));
    }


    function _attack(Ship memory attacker, Ship memory defender) private pure returns (uint16){
        uint16 damage = attacker.attack + attacker.attack * attacker.accuracy / (attacker.attack + attacker.accuracy);

        uint16 resist = defender.defense + defender.defense * defender.agility / (defender.defense + defender.agility);

        uint16 realDamage = damage * damage / (damage + resist);

        return realDamage;

    }

    function _causeDamage(uint16 health, uint16 damage) private pure returns (uint16){
        if (health <= damage) {
            return 0;
        } else {
            return health - damage;
        }
    }

    function _mergeBytes(bytes memory a, bytes memory b) private pure returns (bytes memory c) {
        uint alen = a.length;
        uint totallen = alen + b.length;
        uint loopsa = (a.length + 31) / 32;
        uint loopsb = (b.length + 31) / 32;
        assembly {
            let m := mload(0x40)
            mstore(m, totallen)
            for {let i := 0} lt(i, loopsa) {i := add(1, i)} {mstore(add(m, mul(32, add(1, i))), mload(add(a, mul(32, add(1, i)))))}
            for {let i := 0} lt(i, loopsb) {i := add(1, i)} {mstore(add(m, add(mul(32, add(1, i)), alen)), mload(add(b, mul(32, add(1, i)))))}
            mstore(0x40, add(m, add(32, totallen)))
            c := m
        }
    }

}





