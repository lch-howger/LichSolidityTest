// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

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

    uint8 constant FLEET_SHIP_LIMIT = 5;
    uint8 constant FLEET_HERO_LIMIT = 5;
    uint8 constant MAX_UINT8 = 255;
    uint16 constant MAX_UINT16 = 65535;
    uint32 constant MAX_UINT32 = 4294967295;

    uint256 totalSupply = 0;

    //token id owner
    mapping(uint256 => address) private _tokenIdOwnerMap;

    //owner token amount
    mapping(address => uint256) private _ownerTokenAmountMap;

    //owner token list
    mapping(address => uint256[]) private _ownerTokenListMap;

    //token id to ship
    mapping(uint256 => Ship) private _tokenIdShipMap;

    //token id to hero
    mapping(uint256 => Hero) private _tokenIdHeroMap;

    //address to user info
    mapping(address => UserInfo) private _userInfoMap;

    struct UserInfo {
        string nickname;
        Fleet[] fleets;
        bytes[] battleHistory;
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

    struct Hero {
        uint16 attack;
        uint16 defense;
        uint16 agility;
        uint16 accuracy;
        uint16 health;
    }

    struct Fleet {
        uint256[] shipIdArray;
        uint256[] heroIdArray;
    }

    struct BattleInfo {
        bytes1 direction;
        uint8 battleType;
        uint8 fromIndex;
        uint8 toIndex;

        uint8 attributeIndex;
        uint32 delta;
    }

    /**
     * battle
     */
    function lightYear_viewBattle(address defenderAddress) public view returns (bytes memory){

        //user info
        UserInfo memory attackerUser = _userInfoMap[msg.sender];
        UserInfo memory defenderUser = _userInfoMap[defenderAddress];

        //fleet list
        Fleet[] memory attackerFleets = attackerUser.fleets;
        Fleet[] memory defenderFleets = defenderUser.fleets;

        //check length
        require(attackerFleets.length > 0, "Attacker has no fleet.");
        require(defenderFleets.length > 0, "Defender has no fleet.");

        //fleet index
        uint256 attackerFleetsIndex = 0;
        uint256 defenderFleetsIndex = 0;

        //fleet
        Fleet memory attackerFleet = attackerFleets[attackerFleetsIndex];
        Fleet memory defenderFleet = defenderFleets[defenderFleetsIndex];

        //battle
        bytes memory battleBytes = _battle(attackerFleet, defenderFleet);

        //return result of battle
        return battleBytes;
    }

    /**
     * private battle
     */
    function _battle(Fleet memory attacker, Fleet memory defender) private view returns (bytes memory){

        //ship length
        uint256 attackerLen = attacker.shipIdArray.length;
        uint256 defenderLen = defender.shipIdArray.length;

        //check length
        require(attackerLen > 0, "Attacker has no ship.");
        require(defenderLen > 0, "Defender has no ship.");

        //attacker ships
        Ship[] memory attackerShips=new Ship[](attackerLen);
        for(uint i=0;i<attackerLen;i++){
            attackerShips[i]=_tokenIdShipMap[attacker.shipIdArray[i]];
        }
        
        //defender ships
        Ship[] memory defenderShips=new Ship[](defenderLen);
        for(uint i=0;i<defenderLen;i++){
            defenderShips[i]=_tokenIdShipMap[defender.shipIdArray[i]];
        }

        //bytes
        bytes memory result = "";

        //attack health
        for (uint i = 0; i < FLEET_SHIP_LIMIT; i++) {
            if (i < attackerLen) {
                Ship memory ship = attackerShips[i];
                result = _addBytes(result, ship.health);
            } else {
                result = _addBytes(result, 0);
            }
        }

        //defender health
        for (uint i = 0; i < FLEET_SHIP_LIMIT; i++) {
            if (i < defenderLen) {
                Ship memory ship = defenderShips[i];
                result = _addBytes(result, ship.health);
            } else {
                result = _addBytes(result, 0);
            }
        }

        //temp round
        uint256 round = 4;

        //battle info bytes array
        bytes[] memory battleInfoBytes = new bytes[](round);

        //battle range
        for (uint i = 0; i < round; i++) {
            bytes memory roundBytes = "";
            if (i % 2 == 0) {
                //attacker round
                (roundBytes) = _singleRound(0, attackerShips, defenderShips);
            } else {
                //defender round
                (roundBytes) = _singleRound(1, defenderShips, attackerShips);
            }

            //append bytes array
            battleInfoBytes[i] = roundBytes;
        }

        //convert bytes array to bytes
        for (uint i = 0; i < battleInfoBytes.length; i++) {
            bytes memory b = battleInfoBytes[i];
            result = _mergeBytes(result, b);
        }

        return result;
    }

    function _singleRound(uint8 battleType, Ship[] memory attacker, Ship[] memory defender) private view returns (bytes memory){

        //from index and to index
        uint8 fromIndex = uint8(_random(attacker.length));
        uint8 toIndex = uint8(_random(defender.length));

        //attribute index
        uint8 attributeIndex = 6;

        //attacker ship and defender ship
        Ship memory attackerShip = attacker[fromIndex];
        Ship memory defenderShip = defender[toIndex];

        //cause damage
        uint16 delta = _causeDamage(attackerShip, defenderShip);
        defenderShip.health -= delta;

        //create battle info
        BattleInfo memory info = BattleInfo(0x00, battleType, fromIndex, toIndex, attributeIndex, defenderShip.health);

        //battle info to bytes
        return _battleInfoToBytes(info);
    }

    /**
     * 
     */
    function _causeDamage(Ship memory a, Ship memory b) private pure returns (uint16){
        return a.attack+b.attack-b.attack;
    }

    /**
     * 
     */
    function _battleInfoToBytes(BattleInfo memory info) private pure returns (bytes memory){
        bytes1 direction = _toDirection(info.battleType, info.fromIndex, info.toIndex);
        bytes memory b = "";
        b = _mergeBytes(b, abi.encodePacked(direction));
        b = _mergeBytes(b, abi.encodePacked(info.attributeIndex));
        b = _mergeBytes(b, abi.encodePacked(info.delta));
        return b;
    }

    /**
     * 
     */
    function _toDirection(uint8 a, uint8 b, uint8 c) private pure returns (bytes1){
        require(a <= 3 && b <= 7 && c <= 7);
        bytes1 a_byte = abi.encodePacked(a)[0] << 6;
        bytes1 b_byte = abi.encodePacked(b)[0] << 3;
        bytes1 c_byte = abi.encodePacked(c)[0];
        bytes1 result = a_byte | b_byte | c_byte;
        return result;
    }

    /**
     * get random number
     */
    // uint256 nonce;
    // function _random(uint256 randomSize) private returns(uint256){
    //     nonce++;
    //     uint256 difficulty=block.difficulty;
    //     uint256 gaslimit=block.gaslimit;
    //     uint256 number=block.number;
    //     uint256 timestamp=block.timestamp;
    //     uint256 gasprice=tx.gasprice;
    //     uint256 random = uint256(keccak256(abi.encodePacked(nonce,difficulty,gaslimit,number,timestamp,gasprice))) % randomSize;
    //     return random;
    // }

    function _random(uint256 randomSize) private view returns (uint256){
        uint256 difficulty = block.difficulty;
        uint256 gaslimit = block.gaslimit;
        uint256 number = block.number;
        uint256 timestamp = block.timestamp;
        uint256 gasprice = tx.gasprice;
        uint256 random = uint256(keccak256(abi.encodePacked(difficulty, gaslimit, number, timestamp, gasprice))) % randomSize;
        return random;
    }

    /**
     * 
     */
    function lightYear_mintShip() public {

        //mint nft
        uint256 _tokenId = _mint();

        //create ship
        Ship memory ship = _createShip();
        _tokenIdShipMap[_tokenId] = ship;

        //get user
        UserInfo storage user = _userInfoMap[msg.sender];
        if (user.fleets.length == 0) {
            _createUser();
        }

        //add ship to fleet
        Fleet storage lastFleet = user.fleets[user.fleets.length - 1];
        if (lastFleet.shipIdArray.length < FLEET_SHIP_LIMIT) {
            lastFleet.shipIdArray.push(_tokenId);
        } else {
            _createFleet();
            Fleet storage newFleet = user.fleets[user.fleets.length - 1];
            newFleet.shipIdArray.push(_tokenId);
        }
    }

    /**
     * 
     */
    function lightYear_mintHero() public {

        //mint nft
        uint256 _tokenId = _mint();

        //create hero
        Hero memory hero = _createHero();
        _tokenIdHeroMap[_tokenId] = hero;

        //get user
        UserInfo storage user = _userInfoMap[msg.sender];
        if (user.fleets.length == 0) {
            _createUser();
        }

        //add hero to fleet
        Fleet storage lastFleet = user.fleets[user.fleets.length - 1];
        if (lastFleet.heroIdArray.length < FLEET_HERO_LIMIT) {
            lastFleet.heroIdArray.push(_tokenId);
        } else {
            _createFleet();
            Fleet storage newFleet = user.fleets[user.fleets.length - 1];
            newFleet.heroIdArray.push(_tokenId);
        }
    }

    /**
     * 
     */
    function lightYear_ownerTokenList() public view returns (uint256[] memory){
        return _ownerTokenListMap[msg.sender];
    }

    /**
     * 
     */
    function lightYear_userFleetsSize() public view returns (uint256){
        UserInfo storage user = _userInfoMap[msg.sender];
        return user.fleets.length;
    }

    /**
     * 
     */
    function lightYear_userFleets(uint256 i) public view returns (uint256[] memory, uint256[] memory){
        UserInfo storage user = _userInfoMap[msg.sender];
        uint256[] memory shipArr = user.fleets[i].shipIdArray;
        uint256[] memory heroArr = user.fleets[i].heroIdArray;
        return (shipArr, heroArr);
    }

    /**
     * 
     */
    function _createShip() private pure returns (Ship memory){
        Ship memory ship = Ship(100, 100, 100, 100, 500);
        return ship;
    }

    /**
     * 
     */
    function _createHero() private pure returns (Hero memory){
        Hero memory hero = Hero(100, 100, 100, 100, 500);
        return hero;
    }

    /**
     * 
     */
    function _createFleet() private returns (Fleet memory){
        UserInfo storage user = _userInfoMap[msg.sender];
        uint256[] memory shipIdArray = new uint256[](0);
        uint256[] memory heroIdArray = new uint256[](0);
        Fleet memory newFleet = Fleet(shipIdArray, heroIdArray);
        user.fleets.push(newFleet);
        return newFleet;
    }

    /**
     * 
     */
    function _createUser() private {
        UserInfo storage user = _userInfoMap[msg.sender];
        user.nickname = "";
        _createFleet();
    }

    /**
     * 
     */
    function _addBytes(bytes memory b, uint16 i) private pure returns (bytes memory){
        return _mergeBytes(b, abi.encodePacked(i));
    }

    /**
     * 
     */
    function _attack(Ship memory attacker, Ship memory defender) private pure returns (uint16){
        uint16 damage = attacker.attack + attacker.attack * attacker.accuracy / (attacker.attack + attacker.accuracy);
        uint16 resist = defender.defense + defender.defense * defender.agility / (defender.defense + defender.agility);
        uint16 realDamage = damage * damage / (damage + resist);
        return realDamage;
    }

    /**
     * 
     */
    function _mergeBytes(bytes memory a, bytes memory b) private pure returns (bytes memory c) {
        return abi.encodePacked(a, b);
    }

    /**
     * 
     */
    function _mint() private returns (uint256){

        //owner token changes
        uint256 _tokenId = totalSupply + 1;
        _ownerTokenAmountMap[msg.sender] += 1;
        _tokenIdOwnerMap[_tokenId] = msg.sender;
        _ownerTokenListMap[msg.sender].push(_tokenId);

        //emit Transfer
        emit Transfer(address(0), msg.sender, _tokenId);
        totalSupply += 1;

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