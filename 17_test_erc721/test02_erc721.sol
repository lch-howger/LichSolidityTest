// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

interface ERC721 {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint256 _tokenId) external view returns (address);

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external payable;

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

    function approve(address _approved, uint256 _tokenId) external payable;

    function setApprovalForAll(address _operator, bool _approved) external;

    function getApproved(uint256 _tokenId) external view returns (address);

    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

interface ERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

contract TestLightYear is ERC721 {

    uint256 totalSupply = 0;
    mapping(address => uint256) private _ownerTokenAmountMap;
    mapping(uint256 => address) private _tokenIdOwnerMap;

    function balanceOf(address _owner) override external view returns (uint256){
        return _ownerTokenAmountMap[_owner];
    }

    function ownerOf(uint256 _tokenId) override external view returns (address){
        return _tokenIdOwnerMap[_tokenId];
    }

     struct Ship {
        uint16 attack;
        uint16 defense;
        uint16 agility;
        uint16 accuracy;
        uint16 health;
    }

    function pureBattle() public pure returns (bytes memory){
        Ship memory attacker = Ship(100, 100, 100, 100, 500);
        Ship memory defender = Ship(100, 100, 100, 100, 500);

        //result of battle
        bytes memory battleBytes = "";

        //count of round
        uint256 count = 0;
        
        //start battle
        while (true) {
            
            //limit count
            count++;
            if (count > 40) {
                break;
            }

            //attack round
            uint16 damage = _attack(attacker, defender);
            defender.health = _causeDamage(defender.health, damage);
            battleBytes = _addBytes(battleBytes, defender.health);
            if (defender.health <= 0) {
                break;
            }

            //defense round
            damage = _attack(defender, attacker);
            attacker.health = _causeDamage(attacker.health, damage);
            battleBytes = _addBytes(battleBytes, attacker.health);
            if (attacker.health <= 0) {
                break;
            }

        }

        //return result of battle
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

    function mintShip() public {
        uint256 _tokenId = totalSupply + 1;
        _ownerTokenAmountMap[msg.sender] += 1;
        _tokenIdOwnerMap[_tokenId] = msg.sender;
        emit Transfer(address(0), msg.sender, _tokenId);
        totalSupply += 1;
    }

    function transfer() public {

    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) override external payable {

    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) override external payable {

    }

    function transferFrom(address _from, address _to, uint256 _tokenId) override external payable {

    }

    function approve(address _approved, uint256 _tokenId) override external payable {

    }

    function setApprovalForAll(address _operator, bool _approved) override external {

    }

    function getApproved(uint256 _tokenId) override external view returns (address){

    }

    function isApprovedForAll(address _owner, address _operator) override external view returns (bool){

    }

}