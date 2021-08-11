// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

contract LightYear {

    uint256 number;
    uint8 constant MAX_UINT8=255;
    uint16 constant MAX_UINT16=65535;
    uint32 constant MAX_UINT32=4294967295;
    uint8 constant FLEET_SHIP_LIMIT=4;

    function store(uint256 num) public {
        number = num;
    }

    function retreive() public view returns (uint256){
        return number;
    }
    
    function get() public pure returns(uint256[] memory){
        uint256[] memory arr;
        return arr;
    }
    
    function getBytes() public pure returns(bytes memory){
        bytes memory b=new bytes(2);
        uint8  x=255;
        uint8  y=0;
        b[0]=bytes1(x);
        b[1]=bytes1(y);
        return b;
    }
    
    uint16[] healthArr;
    
    function battle() public returns(bytes memory){
        Dog memory attacker= Dog(10,100);
        Dog memory defender=Dog(20,100);
        bytes memory battleBytes = new bytes(3);
        uint8  count =0;
        
        delete healthArr;
        
        while(attacker.health>0&&defender.health>0){
            count++;
            if (count>20){
                break;
            }
            
            healthArr.push(attacker.health);
            
        }
        
        return battleBytes;
    }
    
    function battle2() public returns(uint16[] memory){
        Dog memory attacker= Dog(10,100);
        Dog memory defender=Dog(20,100);
        uint8  count =0;
        
        delete healthArr;
        
        while(attacker.health>0&&defender.health>0){
            count++;
            if (count>20){
                break;
            }
            
            healthArr.push(attacker.health);
            
        }
        
        return healthArr;
    }
    
    function concat(bytes32 b1, bytes32 b2) pure private returns (bytes memory){
        bytes memory result = new bytes(64);
        assembly {
            mstore(add(result, 32), b1)
            mstore(add(result, 64), b2)
        }
        return result;
    }
    
     function concat_two(bytes2 b1, bytes2 b2) pure private returns (bytes memory){
        bytes memory result = new bytes(4);
        assembly {
            mstore(add(result, 2), b1)
            mstore(add(result, 4), b2)
        }
        return result;
    }
    
    string[] strArr;
    
    function fun_test() public returns(string[] memory){
        // bytes2  b1=0x1234;
        // bytes2  b2=0x5678;
        
        // bytes memory all=concat_two(b1,b2);
        
        // uint16[] memory arr=new uint16[](1);
        // arr.push(10);
        
        
        strArr.push("a");
        
        return strArr;
    }
    
    function fun_test2() view public returns(string[] memory){
        return strArr;
    }
    
    // function concat(bytes memory self, bytes memory other) internal pure returns (bytes memory) {
    //     bytes memory ret = new bytes(self.length + other.length);
    //     var (src, srcLen) = fromBytes(self);
    //     var (src2, src2Len) = fromBytes(other);
    //     var (dest,) = fromBytes(ret);
    //     var dest2 = dest + srcLen;
    //     copy(src, dest, srcLen);
    //     copy(src2, dest2, src2Len);
    //     return ret;
    // }
    
    //  function copy(uint src, uint dest, uint len) internal pure {
    //     // Copy word-length chunks while possible
    //     for (; len >= WORD_SIZE; len -= WORD_SIZE) {
    //         assembly {
    //             mstore(dest, mload(src))
    //         }
    //         dest += WORD_SIZE;
    //         src += WORD_SIZE;
    //     }

    //     // Copy remaining bytes
    //     uint mask = 256 ** (WORD_SIZE - len) - 1;
    //     assembly {
    //         let srcpart := and(mload(src), not(mask))
    //         let destpart := and(mload(dest), mask)
    //         mstore(dest, or(destpart, srcpart))
    //     }
    // }
    
    // function fromBytes(bytes memory bts) internal pure returns (uint addr, uint len) {
    //     len = bts.length;
    //     assembly {
    //         addr := add(bts, /*BYTES_HEADER_SIZE*/32)
    //     }
    // }
    
    // function concatBytes(bytes memory self, bytes memory other) returns (bytes memory) {
    //  bytes memory ret = new bytes(self.length + other.length);
    //  var (src, srcLen) = Memory.fromBytes(self);
    //  var (src2, src2Len) = Memory.fromBytes(other);
    //  var (dest,) = Memory.fromBytes(ret);
    //  var dest2 = dest + src2Len;
    //  Memory.copy(src, dest, srcLen);
    //  Memory.copy(src2, dest2, src2Len);
    //  return ret;
    // }
    
    struct Dog{
        uint32 attack;
        uint16 health;
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
    
    struct Fleet {
      uint32[FLEET_SHIP_LIMIT] shipIdArray;
      uint32[FLEET_SHIP_LIMIT] heroIdArray;
      uint32 fromPId;
      uint32 toPId;
      uint32 time;  
      uint32 status;  
      uint32 extra0;
      uint32 extra1;
    } 
    
    
    
    
    
    
    
}





