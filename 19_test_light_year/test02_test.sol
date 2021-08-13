// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

contract Storage {

    uint256 number;
    bytes b;

    struct BattleInfo{
        uint8 a;
        uint8 b;
        uint32 c;
    }

    function store(uint256 num) public {
        number = num;
    }

    function storeBytes() public{
        //cccccdddddeeeee1111122222333334444455555
        bytes memory a="aaaaabbbbb";
        for(uint i=0;i<30;i++){
          a=  _mergeBytes(a,a);
        }
        b=a;
    }

    function getBytes() public pure returns(bytes memory){
        bytes memory all="";
         bytes memory a="aaaaabbbbb";
        for(uint i=0;i<30;i++){
          all=  _mergeBytes(all,a);
        }
        return all;
    }

    // function getBytes() public pure returns(bytes memory){
    //     // BattleInfo memory info=BattleInfo(1,1,100);
    //     // bytes memory a=abi.encodePacked(info.a);
    //     // bytes memory b=abi.encodePacked(info.b);
    //     // bytes memory c=abi.encodePacked(info.c);
    //     // bytes memory all=_mergeAllBytes(a,b,c);
    //     bool a=true;
    //     string memory b="abc";
    //     bytes memory all=abi.encodePacked(b);
    //     return all;
    // }

    // function _mergeAllBytes(bytes memory a, bytes memory b,bytes memory c) private pure returns (bytes memory) {
    //     bytes memory ab=_mergeBytes(a,b);
    //     bytes memory all=_mergeBytes(ab,c);
    //     return all;
    // }

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