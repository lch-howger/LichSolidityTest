// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Storage {

    struct BattleInfo{
        uint8 battleType;
        uint8 fromIndex;
        uint8 toIndex;
        bytes1 direction;
        uint8 attributeIndex;
        uint32 delta;
    }

    function test_01() public pure returns(bytes1){
        uint8 b=7;
        // bytes memory  b_bytes=abi.encodePacked(b);
        // bytes1 b_byte=b_bytes[0];
        
        bytes1 b_byte=abi.encodePacked(b)[0];
        
        b_byte=b_byte<<3;
        bytes1 a=0x01;
        a=a|b_byte;
        return a;
    }

    function getByte(uint8 a,uint8 b, uint8 c) public pure returns(bytes1){
        require(a<=3 && b<=7 && c<=7);
        bytes1 a_byte=abi.encodePacked(a)[0]<<6;
        bytes1 b_byte=abi.encodePacked(b)[0]<<3;
        bytes1 c_byte=abi.encodePacked(c)[0];
        bytes1 result=a_byte|b_byte|c_byte;
        return result;
    }

    function getDirection(bytes1 b) public pure returns(uint8,uint8,uint8){
        
    }

    function _getBytes() public pure returns(bytes memory result){
        assembly{
            let m:=mload(0x40)
           result :=m 
        }
        return result;
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