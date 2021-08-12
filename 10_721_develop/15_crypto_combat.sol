pragma solidity >=0.4.22 <0.7.0;

contract Context {
    constructor () internal { }
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes memory) {
        this;
        return msg.data;
    }
}

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

interface IERC721Metadata is IERC721 {
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

interface IERC721Enumerable is IERC721 {
    function totalSupply() external view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);
    function tokenByIndex(uint256 index) external view returns (uint256);
}

abstract contract IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data) public virtual returns (bytes4);
}

contract ERC165 is IERC165 {
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;
    mapping(bytes4 => bool) private _supportedInterfaces;
    constructor () internal {
        _registerInterface(_INTERFACE_ID_ERC165);
    }
    function supportsInterface(bytes4 interfaceId) external view override returns (bool) {
        return _supportedInterfaces[interfaceId];
    }
    function _registerInterface(bytes4 interfaceId) internal virtual {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        return c;
    }
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

library Address {
    function isContract(address account) internal view returns (bool) {
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }
}

library Counters {
    using SafeMath for uint256;
    struct Counter {
        uint256 _value;
    }
    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }
    function increment(Counter storage counter) internal {
        counter._value += 1;
    }
    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

contract AaaToken is Context, ERC165, IERC721, IERC721Metadata, IERC721Enumerable {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
    mapping (uint256 => address) private _tokenOwner;
    mapping (uint256 => address) private _tokenApprovals;
    mapping (address => Counters.Counter) private _ownedTokensCount;
    mapping (address => mapping (address => bool)) private _operatorApprovals;
    string private _name = "TestToken";
    string private _symbol = "TT";
    address payable private host;
    mapping(uint256 => string) private _tokenURIs;
    string private _baseURI = "http://chouqianqi.com/combat/";
    mapping(address => uint256[]) private _ownedTokens;
    mapping(uint256 => uint256) private _ownedTokensIndex;
    uint256[] public _allTokens;
    address[] public _allOwners;
    mapping(address => bool) private haveOwner;
    mapping(uint256 => uint256) private _allTokensIndex;
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;
    constructor () public {
        _registerInterface(_INTERFACE_ID_ERC721);
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
        host=msg.sender;
    }
    function balanceOf(address owner) public view override returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return _ownedTokensCount[owner].current();
    }
    function ownerOf(uint256 tokenId) public view override returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }
    function tokenURI(uint256 tokenId) external view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        string memory _tokenURI = _tokenURIs[tokenId];
        if (bytes(_tokenURI).length == 0) {
            return "";
        } else {
            return string(abi.encodePacked(_baseURI, _tokenURI));
        }
    }
    function tokenOfOwnerByIndex(address owner, uint256 index) public view override returns (uint256) {
        require(index < balanceOf(owner), "ERC721Enumerable: owner index out of bounds");
        return _ownedTokens[owner][index];
    }
    function totalOwners() public view returns(uint256){
        return _allOwners.length;
    }
    function totalSupply() public view override returns (uint256) {
        return _allTokens.length;
    }
    function tokenByIndex(uint256 index) public view override returns (uint256) {
        require(index < totalSupply(), "ERC721Enumerable: global index out of bounds");
        return _allTokens[index];
    }
    function approve(address to, uint256 tokenId) public virtual override {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");
        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );
        _approve(to, tokenId);
    }
    function getApproved(uint256 tokenId) public view override returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");
        return _tokenApprovals[tokenId];
    }
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(operator != _msgSender(), "ERC721: approve to caller");
        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }
    function isApprovedForAll(address owner, address operator) public view override returns (bool) {
        return _operatorApprovals[owner][operator];
    }
    function transferFrom(address from, address to, uint256 tokenId) private {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _transferFrom(from, to, tokenId);
    }
    function safeTransferFrom(address from, address to, uint256 tokenId) private {
        safeTransferFrom(from, to, tokenId, "");
    }
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransferFrom(from, to, tokenId, _data);
    }
    function _safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) internal virtual {
        _transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    //============================================================================================================================

    function toString(uint _i) private pure returns (string memory) {
        if (_i == 0) {
            return "00";
        }
        uint temp=_i;
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        if(temp<10){
            return strConcat("0",string(bstr));
        }else{
            return string(bstr);
        }
    }

    function strConcat(string memory _a, string memory _b) private pure returns (string memory){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ab = new string(_ba.length + _bb.length);
        bytes memory bab = bytes(ab);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
        return string(bab);
    }

    string[] private tokenTypes=["h","m","t","p"];
    uint256[] private tokenNumbers=[50,100,100,750];
    mapping(uint256=>Detail) tokenDetails;
    uint256 private tokenTotalNumber;

    struct Detail{
        uint256 tokenId;
        uint256 tokenLevel;
        uint256 tokenAttack;
        uint256 tokenDefense;
        string tokenType;
        string tokenName;
        string tokenUri;
    }

    function getDetail(uint256 tokenId) public view returns(uint256,uint256,uint256,uint256,string memory,string memory,string memory){
        Detail memory d=tokenDetails[tokenId];
        return (d.tokenId,d.tokenLevel,d.tokenAttack,d.tokenDefense,d.tokenType,d.tokenName,d.tokenUri);
    }

    function getOwnerDetail(address owner) public view returns(address,uint256,uint256[] memory,uint256){
        address ad=owner;
        uint256 balance=balanceOf(owner);
        uint256[] memory tokens=_tokensOfOwner(owner);
        uint256 power=getOwnerPower(owner);
        return (ad,balance,tokens,power);
    }

    function getTokenTypeIndex() private returns(uint256){
        uint256 random=getRandom(100);
        if(random<5){
            return 0;
        }else if(random<15){
            return 1;
        }else if(random<25){
            return 2;
        }
        else{
            return 3;
        }
    }

    function getTokenTypeSize() private view returns(uint256){
        return tokenTypes.length;
    }

    function addTokenType(string memory tokenType) private{
        tokenTypes.push(tokenType);
    }

    uint256 nonce=0;
    function getRandom(uint256 randomSize) private returns(uint256){
        nonce+=1;
        uint256 time=block.timestamp;
        bytes32 b=keccak256(abi.encodePacked(time,nonce));
        uint256 random=uint256(b)%randomSize;
        return random;
    }

    function getAttack(uint256 tokenId) private view returns(uint256){
        (,,uint256 attack,,,,)=getDetail(tokenId);
        return attack;
    }

    function getDefense(uint256 tokenId) private view returns(uint256){
        (,,,uint256 defense,,,)=getDetail(tokenId);
        return defense;
    }

    function getOwnerPower(address _address) public view returns(uint256){
        uint256[] memory tokenList = _tokensOfOwner(_address);
        uint256 power;
        for(uint i=0;i<tokenList.length;i++){
            uint256 tokenId=tokenList[i];
            power+=getAttack(tokenId);
        }
        for(uint i=0;i<tokenList.length;i++){
            uint256 tokenId=tokenList[i];
            power+=getDefense(tokenId);
        }
        return power;
    }

    function getOwnerRandomToken(address owner) private returns(uint256){
        uint256[] memory tokens=_tokensOfOwner(owner);
        uint256 randomIndex=getRandom(tokens.length);
        return tokens[randomIndex];
    }

    function initLevel() private returns(uint256){
        uint256 random=getRandom(1000);
        if(random<1){
            return 9;
        }else if(random<6){
            return 8;
        }else if(random<16){
            return 7;
        }else if(random<36){
            return 6;
        }else if(random<100){
            return 5;
        }else if(random<200){
            return 4;
        }else if(random<400){
            return 3;
        }else if(random<700){
            return 2;
        }else{
            return 1;
        }
    }

    //h,m,t,p
    //300   150 75  20
    //250   125 65  10
    //50    25  10  10
    //100   50  20  20
    function initBasePower(uint256 tokenType) private returns(uint256){
        if(tokenType==0){
            return 250+getRandom(100);
        }else if(tokenType==1){
            return 125+getRandom(50);
        }else if(tokenType==2){
            return 65+getRandom(20);
        }else{
            return 10+getRandom(20);
        }
    }

    function initLevelPower(uint256 level,uint256 tokenType) private pure returns(uint256){
        uint256 power;
        if(level==1){
            power=5;
        }else if(level==2){
            power=10;
        }else if(level==3){
            power=20;
        }else if(level==4){
            power=30;
        }else if(level==5){
            power=40;
        }else if(level==6){
            power=60;
        }else if(level==7){
            power=100;
        }else if(level==8){
            power=200;
        }else{
            power=400;
        }
        if(tokenType==0){
            power*=8;
        }else if(tokenType==1){
            power*=4;
        }else if(tokenType==2){
            power*=2;
        }else{
            power*=1;
        }
        return power;
    }

    function getWinner(uint256 a,uint256 b) private returns(uint256){
        uint256 sum=a+b;
        uint256 winRate=a*100/sum;
        if(getRandom(100)<winRate){
            return 0;
        }else{
            return 1;
        }
    }

    event combatEvent(address rivalAddress,address winner,uint256 tokenId);

    function payCombat() public payable returns(address,address,uint256){
        require(msg.value==0.1 ether);
        return freeCombat();
    }

    function freeCombat() private returns(address,address,uint256){
        require(totalOwners()>0);
        uint256 random=getRandom(_allOwners.length);
        while(_allOwners[random]==msg.sender||balanceOf(_allOwners[random])==0){
            random=getRandom(_allOwners.length);
        }
        if(_allOwners[random]==msg.sender){
            return (msg.sender,msg.sender,0);
        }else{
            address rivalAddress=_allOwners[random];
            uint256 meAttack=getOwnerPower(msg.sender);
            uint256 rivalAttack=getOwnerPower(rivalAddress);
            uint256 win=getWinner(meAttack,rivalAttack);
            address winner;
            address loser;
            if(win==0){
                winner=msg.sender;
                loser=rivalAddress;
            }else{
                winner=rivalAddress;
                loser=msg.sender;
            }
            uint256 tokenId=getOwnerRandomToken(loser);
            _transferFrom(loser,winner,tokenId);
            emit combatEvent(rivalAddress,winner,tokenId);
            return (rivalAddress,winner,tokenId);
        }
    }

    function payMint() public payable returns(uint256){
        require(balanceOf(msg.sender)<20);
        require(msg.value==0.1 ether);
        return freeMint();
    }

    function freeMint() private returns(uint256){
        uint256 tokenId=_allTokens.length;
        _safeMint(msg.sender,tokenId);

        uint256 tokenTypeIndex=getTokenTypeIndex();
        uint256 tokenNumber=getRandom(tokenNumbers[tokenTypeIndex]);
        string memory tokenType=tokenTypes[tokenTypeIndex];
        string memory tokenNumberString=toString(tokenNumber);
        string memory tokenName=strConcat(tokenType,tokenNumberString);
        string memory tokenUri=strConcat(tokenName,".png");
        _setTokenURI(tokenId,tokenUri);

        uint256 level=initLevel();
        uint256 baseAttack=initBasePower(tokenTypeIndex);
        uint256 baseDefense=initBasePower(tokenTypeIndex);
        uint256 attack=initLevelPower(level,tokenTypeIndex);
        uint256 defense=initLevelPower(level,tokenTypeIndex);
        if(tokenTypeIndex==0){
            baseAttack=0;
            attack=0;
        }else if(tokenTypeIndex==1){
            baseDefense=0;
            defense=0;
        }
        attack+=baseAttack;
        defense+=baseDefense;
        Detail memory d=Detail(tokenId,level,attack,defense,tokenType,tokenName,tokenUri);
        tokenDetails[tokenId]=d;

        if(balanceOf(msg.sender)==1&&!haveOwner[msg.sender]){
            _allOwners.push(msg.sender);
            haveOwner[msg.sender]=true;
        }

        return tokenId;
    }

    function withdrawContract() public{
        require(msg.sender==host);
        host.transfer(address(this).balance);
    }
    //============================================================================================================================

    function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }
    function _safeMint(address to, uint256 tokenId, bytes memory _data) internal virtual {
        _mint(to, tokenId);
        require(_checkOnERC721Received(address(0), to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");
        _beforeTokenTransfer(address(0), to, tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);
        _addTokenToAllTokensEnumeration(tokenId);
        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();
        emit Transfer(address(0), to, tokenId);
    }
    function _burn(uint256 tokenId) internal virtual {
        address owner = ownerOf(tokenId);
        _beforeTokenTransfer(owner, address(0), tokenId);
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
        _removeTokenFromOwnerEnumeration(owner, tokenId);
        _ownedTokensIndex[tokenId] = 0;
        _removeTokenFromAllTokensEnumeration(tokenId);
        _approve(address(0), tokenId);
        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);
        emit Transfer(owner, address(0), tokenId);
    }
    function _transferFrom(address from, address to, uint256 tokenId) internal virtual {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");
        _beforeTokenTransfer(from, to, tokenId);
        _removeTokenFromOwnerEnumeration(from, tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);
        _approve(address(0), tokenId);
        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();
        _tokenOwner[tokenId] = to;
        emit Transfer(from, to, tokenId);
    }
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }
    function _setBaseURI(string memory baseURI_) internal virtual {
        _baseURI = baseURI_;
    }
    function _tokensOfOwner(address owner) public view returns (uint256[] memory) {
        return _ownedTokens[owner];
    }
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data) private returns (bool){
        if (!to.isContract()) {
            return true;
        }
        (bool success, bytes memory returndata) = to.call(abi.encodeWithSelector(
                IERC721Receiver(to).onERC721Received.selector,
                _msgSender(),
                from,
                tokenId,
                _data
            ));
        if (!success) {
            if (returndata.length > 0) {
                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert("ERC721: transfer to non ERC721Receiver implementer");
            }
        } else {
            bytes4 retval = abi.decode(returndata, (bytes4));
            return (retval == _ERC721_RECEIVED);
        }
    }
    function _approve(address to, uint256 tokenId) private {
        _tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(tokenId), to, tokenId);
    }
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }
    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }
    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId) private {
        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[tokenId];
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];
            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }
        _ownedTokens[from].pop();
    }
    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[tokenId];
        uint256 lastTokenId = _allTokens[lastTokenIndex];
        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        _allTokens.pop();
        _allTokensIndex[tokenId] = 0;
    }
    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual { }
}