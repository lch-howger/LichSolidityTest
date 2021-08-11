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

    bytes battleBytes;
    uint16[]  battleArr;

    function battle() public returns (bytes memory){
        Ship memory attacker = Ship(100, 100, 100, 100, 100);
        Ship memory defender = Ship(100, 100, 100, 100, 100);

        uint256 count = 0;
        while (true) {
            count++;
            if (count >= 20) {
                break;
            }

            uint16 damage = _attack(attacker, defender);
            defender.health=causeDamage(defender.health,damage);

            push(defender.health);

            if(defender.health<=0){
                break;
            }

             damage = _attack(defender, attacker);
            attacker.health=causeDamage(attacker.health,damage);

            push(attacker.health);

            if(attacker.health<=0){
                break;
            }
            
        }
        
        bytes memory b=new bytes(battleArr.length);
        for(uint i=0; i<battleArr.length;i++){
           
        }
        
        return b;
    }

    function pureBattle() public  returns (bytes memory){
        Ship memory attacker = Ship(100, 100, 100, 100, 100);
        Ship memory defender = Ship(100, 100, 100, 100, 100);

        uint256 count = 0;
        while (true) {
            count++;
            if (count >= 20) {
                break;
            }

            uint16 damage = _attack(attacker, defender);
            defender.health=causeDamage(defender.health,damage);

            push(defender.health);

            if(defender.health<=0){
                break;
            }

             damage = _attack(defender, attacker);
            attacker.health=causeDamage(attacker.health,damage);

            push(attacker.health);

            if(attacker.health<=0){
                break;
            }
            
        }
        
        bytes memory b=new bytes(battleArr.length);
        for(uint i=0; i<battleArr.length;i++){
           
        }
        
        return b;
    }

    function getBattleArr() public view returns(uint16[] memory){
        return battleArr;
    }

    function getBattleBytes() public view returns(bytes memory){
        return battleBytes;
    }

    function push(uint16 i) private{
        battleArr.push(i);
      battleBytes=  MergeBytes(battleBytes,abi.encodePacked(i));
    }



    function _attack(Ship memory attacker, Ship memory defender) private returns (uint16){
        uint16 damage = attacker.attack + attacker.attack * attacker.accuracy / (attacker.attack + attacker.accuracy);
push(damage);
        uint16 resist = defender.defense + defender.defense * defender.agility / (defender.defense + defender.agility);
push(resist);
        uint16 realDamage = damage * damage / (damage + resist);
    push(realDamage);

        return (realDamage);

    }

    function getBytes() public pure returns (bytes memory){
        //bytes memory b = new bytes(i);
        //bytes memory b=abi.encodePacked(i);
        bytes memory a="aaa";
        bytes memory b="bbb";
       bytes memory c= MergeBytes(a,b);
        return c;
    }

    function causeDamage(uint16 health,uint16 damage) public pure returns (uint16){
       if(health<=damage){
           return 0;
       }else{
           return health-damage;
       }
    }

function MergeBytes(bytes memory a, bytes memory b) public pure returns (bytes memory c) {
    uint alen = a.length;
    uint totallen = alen + b.length;
    uint loopsa = (a.length + 31) / 32;
    uint loopsb = (b.length + 31) / 32;
    assembly {
        let m := mload(0x40)
        mstore(m, totallen)
        for {  let i := 0 } lt(i, loopsa) { i := add(1, i) } { mstore(add(m, mul(32, add(1, i))), mload(add(a, mul(32, add(1, i))))) }
        for {  let i := 0 } lt(i, loopsb) { i := add(1, i) } { mstore(add(m, add(mul(32, add(1, i)), alen)), mload(add(b, mul(32, add(1, i))))) }
        mstore(0x40, add(m, add(32, totallen)))
        c := m
    }
}

}





