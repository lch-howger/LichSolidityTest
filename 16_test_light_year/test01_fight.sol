// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

contract LightYear {

    uint256 number;

    function store(uint256 num) public {
        number = num;
    }

    function retreive() public view returns (uint256){
        return number;
    }
    
    struct Ship {
      uint32 attack;
      uint32 defense;
      uint32 agility;
      uint32 accuracy;
      uint32 capacity;
      uint32 speed;
      uint16 health;
      uint8 shipType;
      uint8 level;
      uint8 quality;
      uint8 recovery;
      uint8 coolDown;
      uint8 extra0;
    }  
    
    struct Hero {
      uint32 attack;
      uint32 defense;
      uint32 agility;
      uint32 accuracy;
      uint32 capacity;
      uint32 speed;
      uint16 health;
      uint8 shipType;
      uint8 level;
      uint8 quality;
      uint8 recovery;
      uint8 coolDown;
      uint8 extra0;
    }  
}