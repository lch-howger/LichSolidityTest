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

    uint8  constant FLEET_SHIP_LIMIT = 5;
    uint8 constant FLEET_HERO_LIMIT=5;
    uint8 constant MAX_UINT8 = 255;
    uint16 constant MAX_UINT16 = 65535;
    uint32 constant MAX_UINT32 = 4294967295;

    uint256 totalSupply = 0;
    mapping(address => uint256) private _ownerTokenAmountMap;
    mapping(uint256 => address) private _tokenIdOwnerMap;
    
    mapping(address =>uint256[]) private _ownerTokenListMap;
    mapping(uint256 => Ship) private _tokenIdShipMap;
   
    mapping(address=>UserInfo) private _userInfoMap;

    struct UserInfo{
        string nickname;
        mapping(uint256=>Fleet) fleets;
        uint256 fleetsSize;
    }

     struct Ship {
        uint16 attack;
        uint16 defense;
        uint16 agility;
        uint16 accuracy;
        uint16 health;
        // uint16 level;
        // uint16 quality;
    }

    struct Hero{
        uint16 attack;
        uint16 defense;
        uint16 agility;
        uint16 accuracy;
        uint16 health;
    }

    struct Fleet{
        uint256[] shipIdArray;
        uint256[] heroIdArray;
    }

    struct BattleInfo{
        uint8 direction;
        uint8 attributeIndex;
        uint32 delta;
    }

    function test_getBytes() public pure returns(bytes memory){
        BattleInfo memory b0=BattleInfo(1,1,100);
        BattleInfo memory b1=BattleInfo(2,2,200);
        BattleInfo[] memory arr= new BattleInfo[](2);
        arr[0]=b0;
        arr[1]=b1;
        return "01";
    }

    function lightYear_pureBattle() public pure returns (bytes memory){
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

    function lightYear_mintShip() public {
       uint256 _tokenId= _mint();
        
        Ship memory ship=Ship(100, 100, 100, 100, 500);
        _tokenIdShipMap[_tokenId]=ship;
        
       UserInfo storage user=  _userInfoMap[msg.sender];
       if (user.fleetsSize==0){
           _createUser();
           
       }
       
       Fleet storage lastFleet=user.fleets[user.fleetsSize];
       if(lastFleet.shipIdArray.length<FLEET_SHIP_LIMIT){
           lastFleet.shipIdArray.push(_tokenId);
       }else{
           _userCreateNewFleet();
           Fleet storage newFleet=user.fleets[user.fleetsSize];
         newFleet.shipIdArray.push(_tokenId);
       }
    }

    function lightYear_ownerTokenList() public view  returns(uint256[] memory){
        return _ownerTokenListMap[msg.sender];
    }

    function lightYear_userFleetsSize() public view returns(uint256 ){
        UserInfo storage user =_userInfoMap[msg.sender];
        return user.fleetsSize;
    }

 function lightYear_userFleets(uint256 i) public view returns(uint256[] memory){
        UserInfo storage user =_userInfoMap[msg.sender];
        return user.fleets[i].shipIdArray;
    }

    function _userCreateNewFleet() private returns(Fleet memory){
        UserInfo storage user =_userInfoMap[msg.sender];
          uint256[] memory shipIdArray=new uint256[](FLEET_SHIP_LIMIT);
          uint256[] memory heroIdArray=new uint256[](FLEET_HERO_LIMIT);
          Fleet memory newFleet=Fleet(shipIdArray,heroIdArray);
            user.fleetsSize+=1;
          user.fleets[user.fleetsSize]=newFleet;
          return newFleet;
    }

    function _createUser() private{
        UserInfo storage user=  _userInfoMap[msg.sender];
        uint256[] memory shipIdArray=new uint256[](0);
        uint256[] memory heroIdArray=new uint256[](0);
        Fleet memory newFleet=Fleet(shipIdArray,heroIdArray);
        user.fleetsSize=1;
        user.fleets[user.fleetsSize]=newFleet;
    }

    function _userAddShip() private{
        
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

    function _mint()private returns (uint256){
        uint256 _tokenId = totalSupply + 1;
        _ownerTokenAmountMap[msg.sender] += 1;
        _tokenIdOwnerMap[_tokenId] = msg.sender;
        emit Transfer(address(0), msg.sender, _tokenId);
        
        totalSupply += 1;
        _ownerTokenListMap[msg.sender].push(_tokenId);
        
        return _tokenId;
    }    

    function _transfer() private {

    }

    function balanceOf(address _owner) override external view returns (uint256){
        return _ownerTokenAmountMap[_owner];
    }

    function ownerOf(uint256 _tokenId) override external view returns (address){
        return _tokenIdOwnerMap[_tokenId];
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