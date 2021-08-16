// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Storage {
 
    function getBytes() public pure returns(bytes memory){
        bytes1  a=0x01;
        bytes1  b=0x02;
        bytes memory c="aabb";
        uint16 d=1;
        bytes memory result=abi.encodePacked(a,b,c,d);
        return result;
    }
    
    function test01() public pure returns(uint256){
        uint256 a=1;
        uint256 b=2;
        return a-b;
    }
}