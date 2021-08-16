// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract Storage {
 
    function getRandomNumbers() public view returns(uint256[] memory){
        uint256[] memory arr=new uint256[](10);
        for(uint i=0;i<10;i++){
            arr[i]=_random(3);
        }
        return arr;
    }
    
    function _random(uint256 randomSize) private view returns(uint256){
        uint256 difficulty=block.difficulty;
        uint256 gaslimit=block.gaslimit;
        uint256 number=block.number;
        uint256 timestamp=block.timestamp;
        uint256 gasprice=tx.gasprice;
        uint256 random = uint256(keccak256(abi.encodePacked(difficulty,gaslimit,number,timestamp,gasprice))) % randomSize;
        return random;
    }
}