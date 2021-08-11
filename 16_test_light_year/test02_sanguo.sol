pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;


library SafeMath16 {

  /**
  * @dev Multiplies two numbers, reverts on overflow.
  */
  function mul(uint16 a, uint16 b) internal pure returns (uint16) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    uint16 c = a * b;
    require(c / a == b);

    return c;
  }

  /**
  * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
  */
  function div(uint16 a, uint16 b) internal pure returns (uint16) {
    require(b > 0); // Solidity only automatically asserts when dividing by 0
    uint16 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
  * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint16 a, uint16 b) internal pure returns (uint16) {
    require(b <= a);
    uint16 c = a - b;

    return c;
  }

  /**
  * @dev Adds two numbers, reverts on overflow.
  */
  function add(uint16 a, uint16 b) internal pure returns (uint16) {
    uint16 c = a + b;
    require(c >= a);

    return c;
  }

  /**
  * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
  * reverts when dividing by zero.
  */
  function mod(uint16 a, uint16 b) internal pure returns (uint16) {
    require(b != 0);
    return a % b;
  }

  function inc(uint16 a) internal pure returns (uint16) {
    if (a == 65536) return a;

    return a + 1;
  }

  function dec(uint16 a) internal pure returns (uint16) {
    if (a == 0) return a;

    return a - 1;
  }
}


library SafeMath256 {
  /**
  * @dev Multiplies two numbers, reverts on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b);

    return c;
  }

  /**
  * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0); // Solidity only automatically asserts when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
  * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a);
    uint256 c = a - b;

    return c;
  }

  /**
  * @dev Adds two numbers, reverts on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a);

    return c;
  }

  /**
  * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
  * reverts when dividing by zero.
  */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b != 0);
    return a % b;
  }
}


contract Owned {
constructor() public { owner = msg.sender; }

address public owner;

modifier onlyOwner {
  require(msg.sender == owner);
  _;
}
}


contract AddressManager is Owned {
  address public account;
  address public token;
  address public battle;
  address public itemManager;
  address public unitManager;
  address public treasureManager;
  address public referralManager;

  mapping(address => bool) stages;

  function setAccount(address _account) public onlyOwner {
    account = _account;
  }

  function setToken(address _token) public onlyOwner {
    token = _token;
  }

  function setBattle(address _battle) public onlyOwner {
    battle = _battle;
  }

  function setItemManager(address _itemManager) public onlyOwner {
    itemManager = _itemManager;
  }

  function setUnitManager(address _unitManager) public onlyOwner {
    unitManager = _unitManager;
  }

  function addStage(address _stage) public onlyOwner {
    stages[_stage] = true;
  }

  function hasStage(address _stage) public view returns(bool) {
    return stages[_stage];
  }

  function setTreasureManager(address _treasureManager) public onlyOwner {
    treasureManager = _treasureManager;
  }

  function setReferralManager(address _referralManager) public onlyOwner {
    referralManager = _referralManager;
  }
}


contract Item {
  uint16 public id;
  string public name;

  uint16 public hp;
  uint16 public attack;
  uint16 public intelligence;
  uint16 public defense;
  uint16 public agility;
  uint16 public luck;

  uint16 public positionIndex;
  uint16 public cost;

  bool public isMountable;
}


contract MuItem is Item {
  uint16 public id = 1;
  uint16 public cost = 2;
  bool public isMountable = false;
}

contract BuItem is Item {
  uint16 public id = 2;
  uint16 public cost = 2;
  bool public isMountable = false;
}


contract PiItem is Item {
  uint16 public id = 3;
  uint16 public cost = 2;
  bool public isMountable = false;
}


contract TieItem is Item {
  uint16 public id = 4;
  uint16 public cost = 2;
  bool public isMountable = false;
}


contract MuGunItem is Item {
  uint16 public id = 5;
  uint16 public attack = 6;
  uint16 public positionIndex = 0;
  uint16 public cost = 10;
  bool public isMountable = true;
}


contract MuDunItem is Item {
  uint16 public id = 6;
  uint16 public defense = 10;
  uint16 public positionIndex = 0;
  uint16 public cost = 25;
  bool public isMountable = true;
}


contract BuFuItem is Item {
  uint16 public id = 7;
  uint16 public defense = 6;
  uint16 public agility = 4;
  uint16 public positionIndex = 0;
  uint16 public cost = 15;
  bool public isMountable = true;
}


contract TieJianItem is Item {
  uint16 public id = 8;
  uint16 public attack = 10;
  uint16 public positionIndex = 0;
  uint16 public cost = 35;
  bool public isMountable = true;
}


contract SheMaoItem is Item {
  uint16 public id = 9;
  uint16 public attack = 12;
  uint16 public agility = 2;
  uint16 public positionIndex = 0;
  uint16 public cost = 45;
  bool public isMountable = true;
}


contract HuXinJingItem is Item {
  uint16 public id = 10;
  uint16 public defense = 15;
  uint16 public agility = 2;
  uint16 public positionIndex = 1;
  uint16 public cost = 50;
  bool public isMountable = true;
}


contract YinZhouItem is Item {
  uint16 public id = 11;
  uint16 public defense = 20;
  uint16 public agility = 2;
  uint16 public luck = 2;
  uint16 public positionIndex = 1;
  uint16 public cost = 50;
  bool public isMountable = true;
}


contract HanBinJianItem is Item {
  uint16 public id = 12;
  uint16 public attack = 20;
  uint16 public defense = 8;
  uint16 public positionIndex = 1;
  uint16 public cost = 50;
  bool public isMountable = true;
}


contract TaiPingYaoShuItem is Item {
  uint16 public id = 13;
  uint16 public intelligence = 20;
  uint16 public accuracy = 3;
  uint16 public agility = 5;
  uint16 public positionIndex = 2;
  uint16 public cost = 50;
  bool public isMountable = true;
}


contract FangTianHuaJiItem is Item {
  uint16 public id = 14;
  uint16 public attack = 30;
  uint16 public agility = 8;
  uint16 public positionIndex = 2;
  uint16 public cost = 50;
  bool public isMountable = true;
}


interface ITRC20 {
  function totalSupply() external view returns (uint256);

  function balanceOf(address who) external view returns (uint256);

  event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
  );

  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
  );
}


contract TRC20 is ITRC20 {
  using SafeMath256 for uint256;

  mapping (address => uint256) private _balances;

  mapping (address => mapping (address => uint256)) private _allowed;

  uint256 private _totalSupply;

  /**
   * @dev Total number of tokens in existence
   */
  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  /**
   * @dev Gets the balance of the specified address.
   * @param owner The address to query the balance of.
   * @return An uint256 representing the amount owned by the passed address.
   */
  function balanceOf(address owner) public view returns (uint256) {
    return _balances[owner];
  }

  /**
   * @dev Transfer token for a specified addresses
   * @param from The address to transfer from.
   * @param to The address to transfer to.
   * @param value The amount to be transferred.
   */
  function _transfer(address from, address to, uint256 value) internal {
    require(to != address(0));

    _balances[from] = _balances[from].sub(value);
    _balances[to] = _balances[to].add(value);
    emit Transfer(from, to, value);
  }

  /**
   * @dev Internal function that mints an amount of the token and assigns it to
   * an account. This encapsulates the modification of balances such that the
   * proper events are emitted.
   * @param account The account that will receive the created tokens.
   * @param value The amount that will be created.
   */
  function _mint(address account, uint256 value) internal {
    require(account != address(0));

    _totalSupply = _totalSupply.add(value);
    _balances[account] = _balances[account].add(value);
    emit Transfer(address(0), account, value);
  }

  function _burn(address account, uint256 value) internal {
    require(account != address(0));

    _totalSupply = _totalSupply.sub(value);
    _balances[account] = _balances[account].sub(value);
    emit Transfer(account, address(0), value);
  }
}


contract SanGuoToken is TRC20 {

  string private _name;
  string private _symbol;
  uint16 private _decimals;
  address _am;

  constructor(address addressManager) public {
    _name="San Guo Token";
    _symbol="SGT";
    _decimals = 0;
    _am = addressManager;
  }

  /**
   * @return the name of the token.
   */
  function name() public view returns (string) {
    return _name;
  }

  /**
   * @return the symbol of the token.
   */
  function symbol() public view returns (string) {
    return _symbol;
  }

  /**
   * @return the number of decimals of the token.
   */
  function decimals() public view returns (uint16) {
    return _decimals;
  }

  function mint(address to, uint256 amount) public {
    require(msg.sender == AddressManager(_am).account());

    _mint(to, amount);
  }

  function burn(address from, uint256 amount) public {
    require(msg.sender == AddressManager(_am).account());

    _burn(from, amount);
  }

  function snatch(address from, address to, uint256 amount) public {
    require(msg.sender == AddressManager(_am).account());

    _transfer(from, to, amount);
  }
}


contract Stage is Owned {

  uint16 constant UNIT_LIMIT = 3;
  uint16 constant ITEM_LIMIT = 3;
  uint16 constant ITEM_DROP_LIMIT = 2;

  struct UnitInfo {
    uint16 unitId;
    uint16 level;
    uint16[ITEM_LIMIT] itemIdArray;
  }

  struct Battle {
    UnitInfo[UNIT_LIMIT] unitArray;
    uint16[ITEM_DROP_LIMIT] dropItemIdArray;
    uint16 chanceOfDrop;
    uint256 amountOfJHT;
  }

  struct Place {
    mapping(uint16 => Battle) battleList;
    uint16 battleListLength;
  }

  mapping(uint16 => Place) _placeList;
  uint16 _placeListLength;

  mapping(address => uint16) _placeIndex;
  mapping(address => uint16) _battleIndex;

  address _am;

  address _dependency;

  constructor(address addressManager) public {
    _am = addressManager;
  }

  function setDependency(address dependency) public onlyOwner {
    _dependency = dependency;
  }

  function clear() public onlyOwner {
    _placeListLength = 0;
  }

  function clearPlace(uint16 placeIndex) public onlyOwner {
    _placeList[placeIndex].battleListLength = 0;
  }

  function addBattleToPlace(uint16 placeIndex,
                            uint16 battleIndex,
                            uint16[] unitIdArray,
                            uint16[] levelArray,
                            uint16[][] itemIdArray,
                            uint16[] dropItemIdArray,
                            uint16 chanceOfDrop,
                            uint256 amountOfJHT) public onlyOwner {
    require(unitIdArray.length == UNIT_LIMIT);
    require(levelArray.length == UNIT_LIMIT);
    require(itemIdArray.length == ITEM_LIMIT);
    require(dropItemIdArray.length == ITEM_DROP_LIMIT);

    Battle storage battle = _placeList[placeIndex].battleList[battleIndex];

    uint16 i;
    uint16 j;

    for (i = 0; i < UNIT_LIMIT; ++i) {
      battle.unitArray[i].unitId = unitIdArray[i];
      battle.unitArray[i].level = levelArray[i];

      for (j = 0; j < itemIdArray[i].length; ++j) {
        battle.unitArray[i].itemIdArray[j] = itemIdArray[i][j];
      }
    }

    for (i = 0; i < dropItemIdArray.length; ++i) {
      battle.dropItemIdArray[i] = dropItemIdArray[i];
    }

    battle.chanceOfDrop = chanceOfDrop;
    battle.amountOfJHT = amountOfJHT;

    if (placeIndex >= _placeListLength) {
      _placeListLength = placeIndex + 1;
    }

    if (battleIndex >= _placeList[placeIndex].battleListLength) {
      _placeList[placeIndex].battleListLength = battleIndex + 1;
    }
  }

  function getBattleUnit(uint16 placeIndex, uint16 battleIndex, uint16 unitIndex)
      public view returns(uint16, uint16, uint16[ITEM_LIMIT]) {
    UnitInfo storage unit = _placeList[placeIndex].battleList[battleIndex].unitArray[unitIndex];
    return (unit.unitId, unit.level, unit.itemIdArray);
  }

  function maybeDrop(uint16 placeIndex,
                     uint16 battleIndex,
                     uint16 nonce) public view returns(uint16, uint16) {
    uint16 item0 = 0;
    uint16 item1 = 0;

    uint16 r = random(nonce);
    if (r < _placeList[placeIndex].battleList[battleIndex].chanceOfDrop) {
      item0 = _placeList[placeIndex].battleList[battleIndex].dropItemIdArray[0];
    }

    r = random(nonce + 1024);
    if (r < _placeList[placeIndex].battleList[battleIndex].chanceOfDrop / 2) {
      item1 = _placeList[placeIndex].battleList[battleIndex].dropItemIdArray[1];
    }

    return (item0, item1);
  }

  function getDropItemIdArray(uint16 placeIndex,
                              uint16 battleIndex) public view returns(uint16, uint16) {
    return (_placeList[placeIndex].battleList[battleIndex].dropItemIdArray[0],
        _placeList[placeIndex].battleList[battleIndex].dropItemIdArray[1]);
  }

  function getAmountOfJHT(uint16 placeIndex, uint16 battleIndex) public view returns(uint256) {
    return _placeList[placeIndex].battleList[battleIndex].amountOfJHT;
  }

  function random(uint16 nonce) private view returns (uint16) {
    return uint16(uint256(keccak256(block.difficulty, now, nonce)) % 65536);
  }

  function finishState(address me, uint16 placeIndex, uint16 battleIndex) public {
    require(msg.sender == AddressManager(_am).account());

    require(placeIndex < _placeListLength);
    require(battleIndex < _placeList[placeIndex].battleListLength);

    if (battleIndex == _placeList[placeIndex].battleListLength - 1) {
      ++placeIndex;
      battleIndex = 0;
    } else {
      ++battleIndex;
    }

    if (placeIndex > _placeIndex[me]
        || placeIndex == _placeIndex[me] && battleIndex > _battleIndex[me]) {
      _placeIndex[me] = placeIndex;
      _battleIndex[me] = battleIndex;
    }
  }

  function canPlay(address me,
                   uint16 placeIndex,
                   uint16 battleIndex) public view returns(bool) {
    if (_dependency != 0 && !Stage(_dependency).isFinished(me)) {
      return false;
    }

    if (placeIndex >= _placeListLength) return false;

    return placeIndex < _placeIndex[me] && battleIndex < _placeList[placeIndex].battleListLength ||
        placeIndex == _placeIndex[me] && battleIndex <= _battleIndex[me];
  }

  function getFinishedIndexes() public view returns(uint16, uint16) {
    return (_placeIndex[msg.sender], _battleIndex[msg.sender]);
  }

  function isFinished(address me) public view returns(bool) {
    return _placeIndex[me] == _placeListLength && _battleIndex[me] == 0;
  }
}


contract Battle {

  uint16 constant UNIT_LIMIT = 3;

  struct UnitStatus {
    uint16 unitId;
    uint16 hpR;
    uint16 agilityR;
    uint16 hp;
    uint16 attack;
    uint16 intelligence;
    uint16 defense;
    uint16 agility;
    bool stunned;
    uint16 luck;
    uint16 round;
  }

  struct BattleStatus {
    UnitStatus[UNIT_LIMIT] myArray;
    UnitStatus[UNIT_LIMIT] enemyArray;
  }

  address _am;

  constructor(address addressManager) public {
    _am = addressManager;
  }

  function battleWithStage(uint16[UNIT_LIMIT] unitIdArray,
                           address stage,
                           uint16 placeIndex,
                           uint16 battleIndex) public {
    require(unitIdArray.length == UNIT_LIMIT);

    require(Stage(stage).canPlay(msg.sender, placeIndex, battleIndex));

    address account = AddressManager(_am).account();

    uint16 i;

    for (i = 0; i < unitIdArray.length; ++i) {
      if (unitIdArray[i] != 0) {
        require(Account(account).hasUnit(msg.sender, unitIdArray[i]));
      }
    }

    BattleStatus memory status;

    // Fills my array according to NPC.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      uint16 unitId = unitIdArray[i];

      if (unitId == 0) continue;

      // Cosumes energy.
      Account(account).consumeEnery(msg.sender, unitId);

      // Copies to memory.
      status.myArray[i] = _getBattleUnit(msg.sender, unitId);
    }

    // Fills enemy array according to NPC.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      // Copies to memory.
      status.enemyArray[i] = _getBattleUnitFromStage(stage, placeIndex, battleIndex, i);
    }

    (bool didWin, bytes memory records, uint256 size) = _innerBattle(status);

    Account(account).finishStage(msg.sender, stage, placeIndex, battleIndex, didWin, records, size);
  }


  function battleWithPeer(uint16[UNIT_LIMIT] unitIdArray,
                          address peer) public {
    require(unitIdArray.length == UNIT_LIMIT);

    address account = AddressManager(_am).account();

    // Both need to be ready.
    require(Account(account).canDuel(msg.sender, peer));

    uint16 i;

    for (i = 0; i < unitIdArray.length; ++i) {
      if (unitIdArray[i] != 0) {
        require(Account(account).hasUnit(msg.sender, unitIdArray[i]));
      }
    }

    uint16[UNIT_LIMIT] memory defenseUnitIdArray;
    (defenseUnitIdArray[0], defenseUnitIdArray[1], defenseUnitIdArray[2]) =
        Account(account).getDefenseUnitIdArray(peer);

    uint16 unitId;

    BattleStatus memory status;

    // Fills my array.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      unitId = unitIdArray[i];

      if (unitId == 0) continue;

      // Cosumes energy.
      Account(account).consumeEnery(msg.sender, unitId);

      // Copies to memory.
      status.myArray[i] = _getBattleUnit(msg.sender, unitId);
    }

    // Fills enemy array.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      unitId = defenseUnitIdArray[i];

      if (unitId == 0) continue;

      // Copies to memory.
      status.enemyArray[i] = _getBattleUnit(peer, unitId);
    }

    (bool didWin, bytes memory records, uint256 size) = _innerBattle(status);

    Account(account).finishDuel(msg.sender, peer, didWin, records, size);
  }

  function battleWithStageTest(uint16[UNIT_LIMIT] unitIdArray,
                               address stage,
                               uint16 placeIndex,
                               uint16 battleIndex) public view returns(bool, bytes, uint256) {
    require(unitIdArray.length == UNIT_LIMIT);

    require(Stage(stage).canPlay(msg.sender, placeIndex, battleIndex));

    address account = AddressManager(_am).account();

    uint16 i;

    for (i = 0; i < unitIdArray.length; ++i) {
      if (unitIdArray[i] != 0) {
        require(Account(account).hasUnit(msg.sender, unitIdArray[i]));
      }
    }

    BattleStatus memory status;

    // Fills my array according to NPC.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      uint16 unitId = unitIdArray[i];

      if (unitId == 0) continue;

      // Copies to memory.
      status.myArray[i] = _getBattleUnit(msg.sender, unitId);
    }

    // Fills enemy array according to NPC.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      // Copies to memory.
      status.enemyArray[i] = _getBattleUnitFromStage(stage, placeIndex, battleIndex, i);
    }

    return _innerBattle(status);
  }

  function battleWithPeerTest(uint16[UNIT_LIMIT] unitIdArray,
                              address peer) public view returns(bool, bytes, uint256) {
    require(unitIdArray.length == UNIT_LIMIT);

    address account = AddressManager(_am).account();

    // Both need to be ready.
    require(Account(account).canDuel(msg.sender, peer));

    uint16 i;

    for (i = 0; i < unitIdArray.length; ++i) {
      if (unitIdArray[i] != 0) {
        require(Account(account).hasUnit(msg.sender, unitIdArray[i]));
      }
    }

    uint16[UNIT_LIMIT] memory defenseUnitIdArray;
    (defenseUnitIdArray[0], defenseUnitIdArray[1], defenseUnitIdArray[2]) =
        Account(account).getDefenseUnitIdArray(peer);

    uint16 unitId;

    BattleStatus memory status;

    // Fills my array.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      unitId = unitIdArray[i];

      if (unitId == 0) continue;

      // Copies to memory.
      status.myArray[i] = _getBattleUnit(msg.sender, unitId);
    }

    // Fills enemy array.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      unitId = defenseUnitIdArray[i];

      if (unitId == 0) continue;

      // Copies to memory.
      status.enemyArray[i] = _getBattleUnit(peer, unitId);
    }

    return _innerBattle(status);
  }

  function _getBattleUnit(address me, uint16 unitId) private view returns(UnitStatus) {
    address account = AddressManager(_am).account();

    UnitStatus memory us;

    us.unitId = unitId;
    (us.hp, us.attack, us.intelligence,
     us.defense, us.agility, us.luck) = Account(account).getBattleUnit(me, unitId);
    us.hpR = us.hp;
    // us.agilityR = 0;
    // us.stunned = false;

    return us;
  }

  function _getBattleUnitFromStage(
      address stage, uint16 placeIndex,
      uint16 battleIndex, uint16 unitIndex) private view returns(UnitStatus) {
    address account = AddressManager(_am).account();

    UnitStatus memory us;

    (us.unitId, us.hp, us.attack,
     us.intelligence, us.defense, us.agility,
     us.luck) = Account(account).getBattleUnitFromStage(stage, placeIndex, battleIndex, unitIndex);

    us.hpR = us.hp;
    // us.agilityR = 0;
    // us.stunned = false;

    return us;
  }

  function _innerBattle(BattleStatus memory status) private view returns(bool, bytes, uint256) {
    bytes memory records;
    bytes memory tempRecords;

    bool didFinish;
    bool didIWin;

    (didFinish, didIWin) = _checkResult(status);

    if (didFinish) {
      return (didIWin, records, 0);
    }

    records = new bytes(1024);

    uint256 i;
    uint256 j;

    uint256 offset = 0;
    uint256 count = 0;

    for (i = 0; i < 1000; ++i) {
      uint256 largest = 0;
      uint256 k = 0;

      // Accumulate agility and find the largest one.
      for (j = 0; j < UNIT_LIMIT; ++j) {
        if (status.myArray[j].hpR > 0 && status.myArray[j].agilityR > largest) {
          largest = status.myArray[j].agilityR;
          k = j + 1;
        }

        if (status.enemyArray[j].hpR > 0 && status.enemyArray[j].agilityR > largest) {
          largest = status.enemyArray[j].agilityR;
          k = j + UNIT_LIMIT + 1;
        }
      }

      // If no one larger than 100, increase all.
      if (largest < 100) {
        for (j = 0; j < UNIT_LIMIT; ++j) {
          if (status.myArray[j].hpR > 0) {
            status.myArray[j].agilityR += status.myArray[j].agility;
          }

          if (status.enemyArray[j].hpR > 0) {
            status.enemyArray[j].agilityR += status.enemyArray[j].agility;
          }
        }
      } else {
        if (k > UNIT_LIMIT) {
          j = k - UNIT_LIMIT - 1;

          status.enemyArray[j].agilityR -= 100;

          if (status.enemyArray[j].stunned) {
            status.enemyArray[j].stunned = false;
            continue;
          }

          ++status.enemyArray[j].round;
        } else {
          j = k - 1;

          status.myArray[j].agilityR -= 100;

          if (status.myArray[j].stunned) {
            status.myArray[j].stunned = false;
            continue;
          }

          ++status.myArray[j].round;
        }

        (status, tempRecords) = _battle(status, uint16(k), uint16(i));

        for (j = 0; j < tempRecords.length; ++j) {
          records[offset + j] = tempRecords[j];
        }

        offset += uint16(tempRecords.length);

        (didFinish, didIWin) = _checkResult(status);

        if (didFinish) {
          return (didIWin, records, offset);
        }

        ++count;
        if (count >= 40) break;
      }
    }

    return (false, records, offset);
  }

  function _checkResult(BattleStatus memory status) private pure returns(bool, bool) {
    uint16 t = 0;
    uint16 i;

    for (i = 0; i < UNIT_LIMIT; ++i) {
      if (status.myArray[i].hpR > 0) {
        ++t;
      }
    }

    if (t == 0) {
      return (true, false);
    }

    t = 0;

    for (i = 0; i < UNIT_LIMIT; ++i) {
      if (status.enemyArray[i].hpR > 0) {
        ++t;
      }
    }

    if (t == 0) {
      return (true, true);
    }

    return (false, false);
  }

  function _random(uint16 nonce) private view returns (uint16) {
    return uint16(uint256(keccak256(block.difficulty, now, nonce)) % 65536);
  }

  function _attack(BattleStatus memory status,
                   uint16 index,
                   uint16 targetIndex,
                   uint16 extraDamage) public pure returns(BattleStatus, uint16) {
    uint16 attack;
    uint16 defense;
    uint16 damage;

    if (index > UNIT_LIMIT) {
      attack = status.enemyArray[index - 1 - UNIT_LIMIT].attack;
      defense = status.myArray[targetIndex].defense;
    } else {
      attack = status.myArray[index - 1].attack;
      defense = status.enemyArray[targetIndex].defense;
    }

    if (defense * 7 / 10 > attack) {
      damage = attack * 3 * (100 + extraDamage) / 1000;
    } else {
      damage = (attack - defense * 7 / 10) * (100 + extraDamage) / 100;
    }

    if (index > UNIT_LIMIT) {
      if (damage > status.myArray[targetIndex].hpR) {
        status.myArray[targetIndex].hpR = 0;
      } else {
        status.myArray[targetIndex].hpR -= damage;
      }

      return (status, status.myArray[targetIndex].hpR);
    } else {
      if (damage > status.enemyArray[targetIndex].hpR) {
        status.enemyArray[targetIndex].hpR = 0;
      } else {
        status.enemyArray[targetIndex].hpR -= damage;
      }

      return (status, status.enemyArray[targetIndex].hpR);
    }
  }

  function _attackWithDamageReturn(BattleStatus memory status,
                                   uint16 index,
                                   uint16 targetIndex,
                                   uint16 extraDamage) public pure returns(BattleStatus, uint16, uint16) {
    uint16 attack;
    uint16 defense;
    uint16 damage;

    if (index > UNIT_LIMIT) {
      attack = status.enemyArray[index - 1 - UNIT_LIMIT].attack;
      defense = status.myArray[targetIndex].defense;
    } else {
      attack = status.myArray[index - 1].attack;
      defense = status.enemyArray[targetIndex].defense;
    }

    if (defense * 7 / 10 > attack) {
      damage = attack * 3 * (100 + extraDamage) / 1000;
    } else {
      damage = (attack - defense * 7 / 10) * (100 + extraDamage) / 100;
    }

    if (index > UNIT_LIMIT) {
      if (damage > status.myArray[targetIndex].hpR) {
        status.myArray[targetIndex].hpR = 0;
      } else {
        status.myArray[targetIndex].hpR -= damage;
      }

      return (status, status.myArray[targetIndex].hpR, damage);
    } else {
      if (damage > status.enemyArray[targetIndex].hpR) {
        status.enemyArray[targetIndex].hpR = 0;
      } else {
        status.enemyArray[targetIndex].hpR -= damage;
      }

      return (status, status.enemyArray[targetIndex].hpR, damage);
    }
  }

  function _attackAll(BattleStatus memory status,
                      uint16 index,
                      uint16 extraDamage) public pure returns(BattleStatus, uint16, uint16, uint16) {
    uint16 attack;
    uint16 defense;
    uint16 damage;
    uint16[UNIT_LIMIT] memory result;

    for (uint16 targetIndex = 0; targetIndex < UNIT_LIMIT; ++targetIndex) {
      if (index > UNIT_LIMIT) {
        if (status.myArray[targetIndex].hpR == 0) {
          continue;
        }

        attack = status.enemyArray[index - 1 - UNIT_LIMIT].attack;
        defense = status.myArray[targetIndex].defense;
      } else {
        if (status.enemyArray[targetIndex].hpR == 0) {
          continue;
        }

        attack = status.myArray[index - 1].attack;
        defense = status.enemyArray[targetIndex].defense;
      }

      if (defense * 7 / 10 > attack) {
        damage = attack * 3 * (100 + extraDamage) / 1000;
      } else {
        damage = (attack - defense * 7 / 10) * (100 + extraDamage) / 100;
      }

      if (index > UNIT_LIMIT) {
        if (damage > status.myArray[targetIndex].hpR) {
          status.myArray[targetIndex].hpR = 0;
        } else {
          status.myArray[targetIndex].hpR -= damage;
        }

        result[targetIndex] = status.myArray[targetIndex].hpR;
      } else {
        if (damage > status.enemyArray[targetIndex].hpR) {
          status.enemyArray[targetIndex].hpR = 0;
        } else {
          status.enemyArray[targetIndex].hpR -= damage;
        }

        result[targetIndex] = status.enemyArray[targetIndex].hpR;
      }
    }

    return (status, result[0], result[1], result[2]);
  }

  function _getRandomUnit(UnitStatus[UNIT_LIMIT] memory unitArray, uint16 offset) private view returns(uint16) {
    uint16 t = 0;
    uint16 i;
    for (i = 0; i < UNIT_LIMIT; ++i) {
      if (unitArray[i].hpR > 0) {
        ++t;
      }
    }
    if (t == 0) return 0;

    t = _random(offset) % t + 1;
    for (i = 0; i < UNIT_LIMIT; ++i) {
      if (unitArray[i].hpR > 0) {
        --t;
        if (t == 0) return i;
      }
    }
  }

  function _findAllyWithLeastHp(UnitStatus[UNIT_LIMIT] memory unitArray) private pure returns(uint16) {
    if (unitArray[0].hpR > 0 && (unitArray[1].hpR == 0 || unitArray[0].hpR <= unitArray[1].hpR) &&
        (unitArray[2].hpR == 0 || unitArray[0].hpR <= unitArray[2].hpR)) {
      return 0;
    }

    if (unitArray[1].hpR > 0 && (unitArray[2].hpR == 0 || unitArray[1].hpR <= unitArray[2].hpR)) {
      return 1;
    }

    if (unitArray[2].hpR > 0) {
      return 2;
    }
  }

  function _battle(BattleStatus memory status,
                   uint16 index,
                   uint16 round) private view returns(BattleStatus, bytes) {
    uint16 unitId;

    if (index > UNIT_LIMIT) {
      unitId = status.enemyArray[index - 1 - UNIT_LIMIT].unitId;
    } else {
      unitId = status.myArray[index - 1].unitId;
    }

    uint16 targetIndex;

    if (index > UNIT_LIMIT) {
      targetIndex = _getRandomUnit(status.myArray, round * UNIT_LIMIT * 2 + index);
    } else {
      targetIndex = _getRandomUnit(status.enemyArray, round * UNIT_LIMIT * 2 + index);
    }

    uint16 i;
    uint16 t0;
    uint16 t1;
    uint16 result;
    bytes memory records;

    if (unitId == 1) {
      // On any enemy with less than 30% hp, inflict additional 20% damage.
      if (index > UNIT_LIMIT) {
        t0 = status.myArray[targetIndex].hpR;
        t1 = status.myArray[targetIndex].hp;
      } else {
        t0 = status.enemyArray[targetIndex].hpR;
        t1 = status.enemyArray[targetIndex].hp;
      }

      if (t0 < t1 * 3 / 10) {
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createOneRecord(index, targetIndex, 1, result);
      } else {
        (status, result) = _attack(status, index, targetIndex, 20);
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else if (unitId == 2) {
      if (index > UNIT_LIMIT) {
        t0 = status.enemyArray[index - 1 - UNIT_LIMIT].round;
      } else {
        t0 = status.myArray[index - 1].round;
      }

      // In every 3 attacks, inflict additional 20% damage on the 3rd one.
      if (t0 % 3 == 2) {
        (status, result) = _attack(status, index, targetIndex, 20);
        records = _createOneRecord(index, targetIndex, 2, result);
      } else {
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else if (unitId == 3) {
      // Inflict 20% additional damage on the middle enemy.
      if (targetIndex == 1) {
        (status, result) = _attack(status, index, targetIndex, 20);
        records = _createOneRecord(index, targetIndex, 3, result);
      } else {
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else if (unitId == 4) {
      // After losing 50% HP, the next attack will be applied on all enemies.
      if (index > UNIT_LIMIT) {
        if (status.enemyArray[index - 1 - UNIT_LIMIT].hpR * 2 < status.enemyArray[index - 1 - UNIT_LIMIT].hp) {
          (status, result, t0, t1) = _attackAll(status, index, 0);
          records = _createLongRecord(index, targetIndex, 4, result, t0, t1);
        } else {
          (status, result) = _attack(status, index, targetIndex, 0);
          records = _createOneRecord(index, targetIndex, 0, result);
        }
      } else {
        if (status.myArray[index - 1].hpR * 2 < status.myArray[index - 1].hp) {
          (status, result, t0, t1) = _attackAll(status, index, 0);
          records = _createLongRecord(index, targetIndex, 4, result, t0, t1);
        } else {
          (status, result) = _attack(status, index, targetIndex, 0);
          records = _createOneRecord(index, targetIndex, 0, result);
        }
      }
    } else if (unitId == 5) {
      // With 20% chance, stun one enemy for one round.
      (status, result) = _attack(status, index, targetIndex, 0);
      t0 = _random(round * UNIT_LIMIT + index + 1024);

      if (t0 % 100 < 20) {
        if (index > UNIT_LIMIT) {
          status.myArray[targetIndex].stunned = true;
        } else {
          status.enemyArray[targetIndex].stunned = true;
        }

        records = _createOneRecord(index, targetIndex, 5, result);
      } else {
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else if (unitId == 6) {
      // Increase agility by 20% after 3 attacks
      (status, result) = _attack(status, index, targetIndex, 0);

      if (index > UNIT_LIMIT) {
        t0 = status.enemyArray[index - 1 - UNIT_LIMIT].round;
      } else {
        t0 = status.myArray[index - 1].round;
      }

      if (t0 == 3) {
        if (index > UNIT_LIMIT) {
          i = status.enemyArray[index - 1 - UNIT_LIMIT].agility * 12 / 10;
          status.enemyArray[index - 1 - UNIT_LIMIT].agility = i;
        } else {
          i = status.myArray[index - 1].agility * 12 / 10;
          status.myArray[index - 1].agility = i;
        }

        records = _createTwoRecords(index, targetIndex, 0, result, targetIndex, 6, i);
      } else {
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else if (unitId == 7) {
      // After all allies die, inflict additional 20% damage on the next attack.
      if (index > UNIT_LIMIT) {
        for (i = 0; i < UNIT_LIMIT; ++i) {
          if (status.enemyArray[i].hpR > 0) ++t0;
        }
      } else {
        for (i = 0; i < UNIT_LIMIT; ++i) {
          if (status.myArray[i].hpR > 0) ++t0;
        }
      }

      if (t0 == 1) {
        (status, result) = _attack(status, index, targetIndex, 20);
        records = _createOneRecord(index, targetIndex, 7, result);
      } else {
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else if (unitId == 8) {
      // When attacking, decrease enemy's defense by 20% every time.
      if (index > UNIT_LIMIT) {
        status.myArray[targetIndex].defense = status.myArray[targetIndex].defense * 8 / 10;
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createTwoRecords(index, targetIndex, 8, status.myArray[targetIndex].defense, targetIndex, 0, result);
      } else {
        status.enemyArray[targetIndex].defense = status.enemyArray[targetIndex].defense * 8 / 10;
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createTwoRecords(index, targetIndex, 8, status.enemyArray[targetIndex].defense, targetIndex, 0, result);
      }
    } else if (unitId == 9) {
      // When attacking,  decrease enemy's agility by 20%.
      if (index > UNIT_LIMIT) {
        status.myArray[targetIndex].agility = status.myArray[targetIndex].agility * 8 / 10;
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createTwoRecords(index, targetIndex, 9, status.myArray[targetIndex].agility, targetIndex, 0, result);
      } else {
        status.enemyArray[targetIndex].agility = status.enemyArray[targetIndex].agility * 8 / 10;
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createTwoRecords(index, targetIndex, 9, status.enemyArray[targetIndex].agility, targetIndex, 0, result);
      }
    } else if (unitId == 10) {
      // Heals the ally with the least hp by 20%.
      if (index > UNIT_LIMIT) {
        t0 = _findAllyWithLeastHp(status.enemyArray);
        t1 = status.enemyArray[t0].hpR + status.enemyArray[t0].hp / 5;

        if (t1 <= status.enemyArray[t0].hp) {
          status.enemyArray[t0].hpR = t1;
        } else {
          status.enemyArray[t0].hpR = status.enemyArray[t0].hp;
        }

        (status, result) = _attack(status, index, targetIndex, 0);

        records = _createTwoRecords(index, t0, 10, status.enemyArray[t0].hpR, targetIndex, 0, result);
      } else {
        t0 = _findAllyWithLeastHp(status.myArray);
        t1 = status.myArray[t0].hpR + status.myArray[t0].hp / 5;

        if (t1 <= status.myArray[t0].hp) {
          status.myArray[t0].hpR = t1;
        } else {
          status.myArray[t0].hpR = status.myArray[t0].hp;
        }

        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createTwoRecords(index, t0, 10, status.myArray[t0].hpR, targetIndex, 0, result);
      }
    } else if (unitId == 11) {
      // Increase all allies agility by 5%.
      if (index > UNIT_LIMIT) {
        for (t0 = 0; t0 < UNIT_LIMIT; ++t0) {
          if (status.enemyArray[t0].hpR > 0) {
            status.enemyArray[t0].agility = status.enemyArray[t0].agility * 21 / 20;
          }
        }
      } else {
        for (t0 = 0; t0 < UNIT_LIMIT; ++t0) {
          if (status.myArray[t0].hpR > 0) {
            status.myArray[t0].agility = status.myArray[t0].agility * 21 / 20;
          }
        }
      }

      (status, result) = _attack(status, index, targetIndex, 0);
      records = _createTwoRecords(index, targetIndex, 11, 0, targetIndex, 0, result);
    } else if (unitId == 12) {
      // After one ally dies, increase his own hp by 20%.
      (status, result) = _attack(status, index, targetIndex, 0);

      if (index > UNIT_LIMIT) {
        for (i = 0; i < UNIT_LIMIT; ++i) {
          if (status.enemyArray[i].hp > 0 && status.enemyArray[i].hpR == 0) ++t0;
        }

        if (t0 > 0) {
          i = index - 1 - UNIT_LIMIT;
          t1 = status.enemyArray[i].hpR + status.enemyArray[i].hp / 5;

          if (t1 <= status.enemyArray[i].hp) {
            status.enemyArray[i].hpR = t1;
          } else {
            status.enemyArray[i].hpR = status.enemyArray[i].hp;
          }

          records = _createTwoRecords(index, i, 12, status.enemyArray[i].hpR, targetIndex, 0, result);
        } else {
          records = _createOneRecord(index, targetIndex, 0, result);
        }
      } else {
        for (i = 0; i < UNIT_LIMIT; ++i) {
          if (status.myArray[i].hp > 0 && status.myArray[i].hpR == 0) ++t0;
        }

        if (t0 > 0) {
          i = index - 1;
          t1 = status.myArray[i].hpR + status.myArray[i].hp / 5;

          if (t1 <= status.myArray[i].hp) {
            status.myArray[i].hpR = t1;
          } else {
            status.myArray[i].hpR = status.myArray[i].hp;
          }

          records = _createTwoRecords(index, i, 12, status.myArray[i].hpR, targetIndex, 0, result);
        } else {
          records = _createOneRecord(index, targetIndex, 0, result);
        }
      }
    } else if (unitId == 13) {
      // Gain hp by 20% after losing 50% hp.
      (status, result) = _attack(status, index, targetIndex, 0);

      if (index > UNIT_LIMIT) {
        i = index - 1 - UNIT_LIMIT;
        if (status.enemyArray[i].hpR * 2 < status.enemyArray[i].hp) {
          t0 = status.enemyArray[i].hpR + status.enemyArray[i].hp / 5;
          if (t0 <= status.enemyArray[i].hp) {
            status.enemyArray[i].hpR = t0;
          } else {
            status.enemyArray[i].hpR = status.enemyArray[i].hp;
          }
          records = _createTwoRecords(index, i, 13, status.enemyArray[i].hpR, targetIndex, 0, result);
        } else {
          records = _createOneRecord(index, targetIndex, 0, result);
        }
      } else {
        i = index - 1;
        if (status.myArray[i].hpR * 2 < status.myArray[i].hp) {
          t0 = status.myArray[i].hpR + status.myArray[i].hp / 5;
          if (t0 <= status.myArray[i].hp) {
            status.myArray[i].hpR = t0;
          } else {
            status.myArray[i].hpR = status.myArray[i].hp;
          }
          records = _createTwoRecords(index, i, 13, status.myArray[i].hpR, targetIndex, 0, result);
        } else {
          records = _createOneRecord(index, targetIndex, 0, result);
        }
      }
    } else if (unitId == 14) {
      // Stun all enemy in the 3rd round.

      if (index > UNIT_LIMIT) {
        t0 = status.enemyArray[index - 1 - UNIT_LIMIT].round;
      } else {
        t0 = status.myArray[index - 1].round;
      }

      if (t0 == 3) {
        if (index > UNIT_LIMIT) {
          status.myArray[0].stunned = true;
          status.myArray[1].stunned = true;
          status.myArray[2].stunned = true;
        } else {
          status.enemyArray[0].stunned = true;
          status.enemyArray[1].stunned = true;
          status.enemyArray[2].stunned = true;
        }

        records = _createOneRecord(index, targetIndex, 14, 0);
      } else {
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else if (unitId == 15) {
      // Gains hp by attacking enemies.
      (status, result, t0) = _attackWithDamageReturn(status, index, targetIndex, 0);

      if (index > UNIT_LIMIT) {
        i = index - UNIT_LIMIT - 1;
        t1 = status.enemyArray[i].hpR + t0;

        if (status.enemyArray[i].hpR < status.enemyArray[i].hp) {
          if (t1 <= status.enemyArray[i].hp) {
            status.enemyArray[i].hpR = t1;
          } else {
            status.enemyArray[i].hpR = status.enemyArray[i].hp;
          }

          t0 = status.enemyArray[i].hpR;

          records = _createTwoRecords(index, targetIndex, 0, result, i, 15, t0);
        } else {
          records = _createOneRecord(index, targetIndex, 0, result);
        }
      } else {
        i = index - 1;
        t1 = status.myArray[i].hpR + t0;

        if (status.myArray[i].hpR < status.enemyArray[i].hp) {
          if (t1 <= status.enemyArray[i].hp) {
            status.myArray[i].hpR = t1;
          } else {
            status.myArray[i].hpR = status.myArray[i].hp;
          }

          t0 = status.myArray[i].hpR;

          records = _createTwoRecords(index, targetIndex, 0, result, i, 15, t0);
        } else {
          records = _createOneRecord(index, targetIndex, 0, result);
        }
      }
    } else if (unitId == 16) {
      // Attack all on the 3rd of every three attacks.
      if (index > UNIT_LIMIT) {
        i = status.enemyArray[index - 1 - UNIT_LIMIT].round;
      } else {
        i = status.myArray[index - 1].round;
      }

      if (i % 3 == 0) {
        (status, result, t0, t1) = _attackAll(status, index, 0);
        records = _createLongRecord(index, targetIndex, 16, result, t0, t1);
      } else {
        (status, result) = _attack(status, index, targetIndex, 0);
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else if (unitId == 17) {
      // In every 3 attacks, stun the enemy being attacked for one round.

      (status, result) = _attack(status, index, targetIndex, 0);

      if (index > UNIT_LIMIT) {
        t0 = status.enemyArray[index - 1 - UNIT_LIMIT].round;
      } else {
        t0 = status.myArray[index - 1].round;
      }

      if (t0 % 3 == 0) {
        if (index > UNIT_LIMIT) {
          status.myArray[targetIndex].stunned = true;
        } else {
          status.enemyArray[targetIndex].stunned = true;
        }

        records = _createOneRecord(index, targetIndex, 17, result);
      } else {
        records = _createOneRecord(index, targetIndex, 0, result);
      }
    } else {
      // Just attack.
      (status, result) = _attack(status, index, targetIndex, 0);
      records = _createOneRecord(index, targetIndex, 0, result);
    }

    return (status, records);
  }

  function _createOneRecord(uint16 index, uint16 targetIndex, uint8 t, uint16 result) private pure returns(bytes) {
    bytes memory records = new bytes(5);
    records[0] = byte(uint8(index));
    records[1] = byte(uint8(targetIndex));
    records[2] = byte(t);
    records[3] = byte(uint8(result / 256));
    records[4] = byte(uint8(result % 256));
    return records;
  }

  function _createLongRecord(uint16 index, uint16 targetIndex, uint8 t, uint16 result, uint16 result1, uint16 result2) private pure returns(bytes) {
    bytes memory records = new bytes(9);
    records[0] = byte(uint8(index));
    records[1] = byte(uint8(targetIndex));
    records[2] = byte(t);
    records[3] = byte(uint8(result / 256));
    records[4] = byte(uint8(result % 256));
    records[5] = byte(uint8(result1 / 256));
    records[6] = byte(uint8(result1 % 256));
    records[7] = byte(uint8(result2 / 256));
    records[8] = byte(uint8(result2 % 256));
    return records;
  }

  function _createTwoRecords(uint16 index, uint16 targetIndex, uint8 t, uint16 result, uint16 targetIndex1, uint8 t1, uint16 result1) private pure returns(bytes) {
    bytes memory records = new bytes(10);
    records[0] = byte(uint8(index));
    records[1] = byte(uint8(targetIndex));
    records[2] = byte(t);
    records[3] = byte(uint8(result / 256));
    records[4] = byte(uint8(result % 256));
    records[5] = byte(uint8(index));
    records[6] = byte(uint8(targetIndex1));
    records[7] = byte(t1);
    records[8] = byte(uint8(result1 / 256));
    records[9] = byte(uint8(result1 % 256));
    return records;
  }
}


contract Unit {

  uint16 constant UNIT_LIMIT = 3;
  uint16 constant ITEM_LIMIT = 3;

  uint16 public id;
  string public name;

  uint16 public hp;
  uint16 public hpStep;

  uint16 public attack;
  uint16 public attackStep;

  uint16 public intelligence;
  uint16 public intelligenceStep;

  uint16 public defense;
  uint16 public defenseStep;

  uint16 public agility;
  uint16 public agilityStep;

  uint16 public luck;
  uint16 public luckStep;

  uint256 public recoverCost = 10 * 1e6;
  uint16 public upgradeCost = 100;

  function lHp(uint16 level) public view returns(uint16) {
    return hp + hpStep * level;
  }

  function lAttack(uint16 level) public view returns(uint16) {
    return attack + attackStep * level;
  }

  function lIntelligence(uint16 level) public view returns(uint16) {
    return intelligence + intelligenceStep * level;
  }

  function lDefense(uint16 level) public view returns(uint16) {
    return defense + defenseStep * level;
  }

  function lAgility(uint16 level) public view returns(uint16) {
    return agility + agilityStep * level;
  }

  function lLuck(uint16 level) public view returns(uint16) {
    return luck + luckStep * level;
  }

  function lRecoverCost(uint16 level) public view returns(uint256) {
    uint256 cost = recoverCost;

    for (uint16 i = 1; i < level; ++i) {
      cost = cost * 11 / 10;
    }

    return cost;
  }

  function lUpgradeCost(uint16 level) public view returns(uint256) {
    uint256 cost = upgradeCost;

    for (uint16 i = 1; i < level; ++i) {
      cost = cost * 11 / 10;
    }

    return cost;
  }

  function random(uint16 nonce) private view returns (uint16) {
    return uint16(uint256(keccak256(block.difficulty, now, nonce)) % 65536);
  }
}


contract GuanyuUnit is Unit {

  // When an enemy with less than 30% hp, with 30% chance decline the attack.
  // The skil only trigger once in a battle.

  uint16 public id = 1;

  constructor() Unit() public {
    name = "Guan Yu";
    hp = 100;
    hpStep = 10;
    attack = 90;
    attackStep = 9;
    intelligence = 65;
    intelligenceStep = 6;
    defense = 70;
    defenseStep = 9;
    agility = 60;
    agilityStep = 6;
    luck = 77;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract ZhangfeiUnit is Unit {

  // In every 3 attacks, inflict additional 20% damage on the 3rd one.

  uint16 public id = 2;

  constructor() public {
    name = "Zhang Fei";
    hp = 100;
    hpStep = 10;
    attack = 92;
    attackStep = 9;
    intelligence = 60;
    intelligenceStep = 6;
    defense = 75;
    defenseStep = 9;
    agility = 50;
    agilityStep = 5;
    luck = 73;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract DianweiUnit is Unit {

  // After all allies die, inflict twice damage on the next attack.

  uint16 public id = 3;

  constructor() public {
    name = "Dian Wei";
    hp = 100;
    hpStep = 10;
    attack = 94;
    attackStep = 9;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 73;
    defenseStep = 9;
    agility = 60;
    agilityStep = 6;
    luck = 70;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract XiahoudunUnit is Unit {

  // After losing 50% HP, the next attack will be applied on all enemies

  uint16 public id = 4;

  constructor() public {
    name = "Xiahou Dun";
    hp = 110;
    hpStep = 10;
    attack = 88;
    attackStep = 8;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 75;
    defenseStep = 10;
    agility = 55;
    agilityStep = 5;
    luck = 82;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 96;
  }
}


contract TaishiciUnit is Unit {

  // With 20% chance, infreeze one enemy for one round, the skill triggers only once in a battle.

  uint16 public id = 5;

  constructor() public {
    name = "Taishi Ci";
    hp = 100;
    hpStep = 9;
    attack = 85;
    attackStep = 8;
    intelligence = 55;
    intelligenceStep = 5;
    defense = 75;
    defenseStep = 8;
    agility = 55;
    agilityStep = 5;
    luck = 86;
    luckStep = 1;
    recoverCost = 9 * 1e6;
    upgradeCost = 90;
  }
}


contract SunjianUnit is Unit {

  // Inflict 20% additional damage on the forefront enemy.

  uint16 public id = 6;

  constructor() public {
    name = "Sun Jian";
    hp = 95;
    hpStep = 9;
    attack = 87;
    attackStep = 8;
    intelligence = 55;
    intelligenceStep = 6;
    defense = 70;
    defenseStep = 7;
    agility = 60;
    agilityStep = 6;
    luck = 74;
    luckStep = 1;
    recoverCost = 9 * 1e6;
    upgradeCost = 90;
  }
}


contract GanningUnit is Unit {

  // Only attacks on the back row enemies only they are still alive.

  uint16 public id = 7;

  constructor() public {
    name = "Gan Ning";
    hp = 90;
    hpStep = 8;
    attack = 84;
    attackStep = 8;
    intelligence = 55;
    intelligenceStep = 5;
    defense = 70;
    defenseStep = 7;
    agility = 50;
    agilityStep = 5;
    luck = 85;
    luckStep = 1;
    recoverCost = 8 * 1e6;
    upgradeCost = 80;
  }
}


contract JianyongUnit is Unit {

  // At the begining of the battle, decline a random enemy's defense by 20%.

  uint16 public id = 8;

  constructor() public {
    name = "Jian Yong";
    hp = 90;
    hpStep = 8;
    attack = 60;
    attackStep = 6;
    intelligence = 85;
    intelligenceStep = 8;
    defense = 70;
    defenseStep = 7;
    agility = 60;
    agilityStep = 6;
    luck = 87;
    luckStep = 1;
    recoverCost = 8 * 1e6;
    upgradeCost = 85;
  }
}


contract XunyuUnit is Unit {

  // Heals the ally with the least hp once after anyone has less than 50% hp.

  uint16 public id = 9;

  constructor() public {
    name = "Xun Yu";
    hp = 95;
    hpStep = 9;
    attack = 50;
    attackStep = 5;
    intelligence = 88;
    intelligenceStep = 8;
    defense = 72;
    defenseStep = 7;
    agility = 62;
    agilityStep = 6;
    luck = 82;
    luckStep = 1;
    recoverCost = 8 * 1e6;
    upgradeCost = 85;
  }
}


contract GuojiaUnit is Unit {

  // Decrease the enemy with the lowest max hp agility by 20%.

  uint16 public id = 10;

  constructor() public {
    name = "Guo Jia";
    hp = 90;
    hpStep = 9;
    attack = 50;
    attackStep = 5;
    intelligence = 95;
    intelligenceStep = 9;
    defense = 72;
    defenseStep = 7;
    agility = 62;
    agilityStep = 6;
    luck = 80;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract ChengongUnit is Unit {

  // Increase all allies agility by 5%.

  uint16 public id = 11;

  constructor() public {
    name = "Chen Gong";
    hp = 90;
    hpStep = 9;
    attack = 50;
    attackStep = 5;
    intelligence = 95;
    intelligenceStep = 9;
    defense = 72;
    defenseStep = 7;
    agility = 62;
    agilityStep = 6;
    luck = 78;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract HuangjinUnit is Unit {

  uint16 public id = 18;

  constructor() public {
    name = "Huang Jin";
    hp = 90;
    hpStep = 9;
    attack = 80;
    attackStep = 8;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 80;
    defenseStep = 8;
    agility = 50;
    agilityStep = 5;
    luck = 50;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract ChengzhiyuanUnit is Unit {

  // After one ally dies, increase his own hp by 20%.

  uint16 public id = 12;

  constructor() public {
    name = "Cheng Zhiyuan";
    hp = 90;
    hpStep = 9;
    attack = 80;
    attackStep = 8;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 80;
    defenseStep = 8;
    agility = 50;
    agilityStep = 5;
    luck = 70;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract ZhaohongUnit is Unit {

  // After been attacked the first time, decrease the attacker's atk by 20%.

  uint16 public id = 13;

  constructor() public {
    name = "Zhao Hong";
    hp = 90;
    hpStep = 9;
    attack = 80;
    attackStep = 8;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 80;
    defenseStep = 8;
    agility = 50;
    agilityStep = 5;
    luck = 70;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract GuanhaiUnit is Unit {

  // Decrease a random enemy's intelligence by 20%.

  uint16 public id = 14;

  constructor() public {
    name = "Guan Hai";
    hp = 90;
    hpStep = 9;
    attack = 80;
    attackStep = 8;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 80;
    defenseStep = 8;
    agility = 50;
    agilityStep = 5;
    luck = 70;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract ZhangliangUnit is Unit {

  // Gains hp by attacking enemies.

  uint16 public id = 15;

  constructor() public {
    name = "Zhang Liang";
    hp = 90;
    hpStep = 9;
    attack = 80;
    attackStep = 8;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 80;
    defenseStep = 8;
    agility = 50;
    agilityStep = 5;
    luck = 70;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract ZhangbaoUnit is Unit {

  // After all allies die, gets 20% attack.

  uint16 public id = 16;

  constructor() public {
    name = "Zhang Bao";
    hp = 90;
    hpStep = 9;
    attack = 80;
    attackStep = 8;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 80;
    defenseStep = 8;
    agility = 50;
    agilityStep = 5;
    luck = 70;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract ZhangjiaoUnit is Unit {

  // In every 3 attacks, stun the enemy being attacked for one round.

  uint16 public id = 17;

  constructor() public {
    name = "Zhang Jiao";
    hp = 90;
    hpStep = 9;
    attack = 80;
    attackStep = 8;
    intelligence = 50;
    intelligenceStep = 5;
    defense = 80;
    defenseStep = 8;
    agility = 50;
    agilityStep = 5;
    luck = 70;
    luckStep = 1;
    recoverCost = 10 * 1e6;
    upgradeCost = 100;
  }
}


contract Account is Owned {

  uint16 constant UNIT_LIMIT = 3;
  uint16 constant ITEM_LIMIT = 3;
  uint16 constant MAX_ENERGY = 5;

  struct UnitInfo {
    uint16 unitId;
    uint16 level;
    uint256[ITEM_LIMIT] itemRIdArray;
  }

  struct ItemInfo {
    uint16 itemId;
    uint16 level;
    uint16 score;
    uint16 mountedByUnitId;
  }

  struct EnergyInfo {
    uint16 amount;
    uint256 time;
    // Actual amount = amount + (now - time) / (1 hours)
  }

  struct Status {
    uint16[UNIT_LIMIT] defenseUnitIdArray;
    uint32 duelScore;
    uint256 duelTime;
    uint256 defeatTime;
    bool readyToDuel;
    uint16[] unitIdList;
    mapping(uint16 => UnitInfo) unitMap;
    mapping(uint16 => EnergyInfo) energyMap;

    uint256[] itemRIdList;
    mapping(uint256 => uint256) itemRIdIndex;  // index + 1

    bytes records;
    uint32[] duelHistory;
    string name;
  }

  mapping(address => Status) _status;

  mapping(uint256 => ItemInfo) _itemStatus;
  uint256 _itemRId;

  mapping(uint16 => address) _units;
  mapping(uint16 => address) _items;
  mapping(string => address) _name2Address;

  struct DuelInfo {
    uint256 time;
    address from;
    address to;
    bytes records;
  }

  DuelInfo[] _infoOfDuel;

  address[] public allDuelPlayers;

  address _am;

  constructor(address addressManager) public {
    _am = addressManager;
  }

  function defineUnits(address[] unitArray) public onlyOwner {
    for (uint16 i = 0; i < unitArray.length; ++i) {
      address unit = unitArray[i];
      uint16 unitId = Unit(unit).id();
      require(unitId != 0);
      _units[unitId] = unit;
    }
  }

  function defineItems(address[] itemArray) public onlyOwner {
    for (uint16 i = 0; i < itemArray.length; ++i) {
      address item = itemArray[i];
      uint16 itemId = Item(item).id();
      require(itemId != 0);
      _items[itemId] = item;
    }
  }

  function hasUnit(address me, uint16 unitId) public view returns(bool) {
    return _units[unitId] != 0 && _status[me].unitMap[unitId].level > 0;
  }

  function getUnitLevel(address me, uint16 unitId) public view returns(uint16) {
    require(_units[unitId] != 0);

    return _status[me].unitMap[unitId].level;
  }

  function syncAddUnit(address me, uint16 unitId, uint16 fromLevel) public {
    require(msg.sender == AddressManager(_am).unitManager());

    require(_units[unitId] != 0);
    require(!hasUnit(me, unitId));

    UnitInfo storage info = _status[me].unitMap[unitId];

    uint16 i;

    // Buy
    info.unitId = unitId;
    info.level = fromLevel;

    _status[me].unitIdList.push(unitId);

    _fillEnergy(me, unitId);

    // Automatically adds to defenseUnitIdArray.
    for (i = 0; i < UNIT_LIMIT; ++i) {
      if (_status[me].defenseUnitIdArray[i] == 0) {
        _status[me].defenseUnitIdArray[i] = unitId;
        break;
      }
    }

    if (!_status[me].readyToDuel) {
      _status[me].duelScore = 1000;  // Initial score.
      _status[me].readyToDuel = true;
      allDuelPlayers.push(me);
    }
  }

  function syncRemoveUnit(address me, uint16 unitId) public {
    require(msg.sender == AddressManager(_am).unitManager());

    require(_units[unitId] != 0);

    require(hasUnit(me, unitId));

    UnitInfo storage info = _status[me].unitMap[unitId];

    uint16 i;

    // Sell

    // Un-mount the unit's all items.
    for (i = 0; i < info.itemRIdArray.length; ++i) {
      if (info.itemRIdArray[i] != 0) {
        _unmountItem(me, info.itemRIdArray[i], unitId);
      }
    }

    info.unitId = 0;

    // Remove from the list.
    uint16 listLength = uint16(_status[me].unitIdList.length);

    for (i = 0; i < listLength - 1; ++i) {
      if (_status[me].unitIdList[i] == unitId) {
        _status[me].unitIdList[i] = _status[me].unitIdList[listLength - 1];
      }
    }

    --_status[me].unitIdList.length;

    // Automatically removes from defenseUnitIdArray
    for (i = 0; i < UNIT_LIMIT; ++i) {
      if (_status[me].defenseUnitIdArray[i] == unitId) {
        _status[me].defenseUnitIdArray[i] = 0;
        break;
      }
    }
  }

  function transferItem(address from, address to, uint256 itemRId) public {
    require(msg.sender == AddressManager(_am).itemManager());

    uint16 mountedByUnitId = _itemStatus[itemRId].mountedByUnitId;

    if (mountedByUnitId > 0) {
      _unmountItem(from, itemRId, mountedByUnitId);
    }

    uint256 oldIndex = _status[from].itemRIdIndex[itemRId];

    require(oldIndex > 0);

    _status[to].itemRIdIndex[itemRId] = _status[to].itemRIdList.length + 1;
    _status[to].itemRIdList.push(itemRId);

    uint256 oldLength = _status[from].itemRIdList.length;
    uint256 oldLastRId = _status[from].itemRIdList[oldLength - 1];

    _status[from].itemRIdList[oldIndex - 1] = oldLastRId;
    _status[from].itemRIdIndex[itemRId] = 0;
    _status[from].itemRIdIndex[oldLastRId] = oldIndex;
    --_status[from].itemRIdList.length;
  }

  function _destoryItem(address me, uint256 itemRId) private {
    uint256 oldIndex = _status[me].itemRIdIndex[itemRId];

    require(oldIndex > 0);

    uint256 oldLength = _status[me].itemRIdList.length;
    uint256 oldLastRId = _status[me].itemRIdList[oldLength - 1];

    _status[me].itemRIdList[oldIndex - 1] = oldLastRId;
    _status[me].itemRIdIndex[itemRId] = 0;
    _status[me].itemRIdIndex[oldLastRId] = oldIndex;
    --_status[me].itemRIdList.length;

    uint16 unitId = _itemStatus[itemRId].mountedByUnitId;
    if (unitId > 0) {
      // Unmount
      for (uint16 i = 0; i < ITEM_LIMIT; ++i) {
        if (_status[me].unitMap[unitId].itemRIdArray[i] == itemRId) {
          _status[me].unitMap[unitId].itemRIdArray[i] = 0;
        }
      }
    }

    // No need to change _itemStatus.
  }

  function _generateRId() private returns(uint256) {
    return ++_itemRId;
  }

  function _createItem(address me, uint16 itemId, uint16 level, uint16 score) private {
    address item = _items[itemId];
    require(item != 0);

    uint256 itemRId = _generateRId();

    _status[me].itemRIdIndex[itemRId] = _status[me].itemRIdList.length + 1;
    _status[me].itemRIdList.push(itemRId);

    _itemStatus[itemRId].itemId = itemId;

    if (level > 0) {
      _itemStatus[itemRId].level = level;
      _itemStatus[itemRId].score = score;
    }
  }

  function hasItem(address me, uint256 itemRId) public view returns(bool) {
    return _status[me].itemRIdIndex[itemRId] > 0;
  }

  function startGame(string name, address referrer) public {
    require(bytes(name).length >= 6); // 6 English or 2 Chinese characters.
    require(_name2Address[name] == 0);

    Status storage me = _status[msg.sender];

    me.name = name;
    _name2Address[name] = msg.sender;

    if (referrer != msg.sender && bytes(nameOf(referrer)).length >= 6) {
      ReferralManager(AddressManager(_am).referralManager()).addReferral(referrer, msg.sender);
    }
  }

  function nameOf(address me) public view returns(string) {
    return _status[me].name;
  }

  function getAddressFromName(string name) public view returns(address) {
    return _name2Address[name];
  }

  function mountItem(uint256 itemRId, uint16 unitId) public {
    require(hasUnit(msg.sender, unitId));
    require(hasItem(msg.sender, itemRId));

    _itemStatus[itemRId].mountedByUnitId = unitId;

    uint16 itemId = _itemStatus[itemRId].itemId;
    uint16 positionIndex = Item(_items[itemId]).positionIndex();

    uint256 oldRId = _status[msg.sender].unitMap[unitId].itemRIdArray[positionIndex];

    if (oldRId > 0) {
      _itemStatus[oldRId].mountedByUnitId = 0;
    }

    _itemStatus[itemRId].mountedByUnitId = unitId;
    _status[msg.sender].unitMap[unitId].itemRIdArray[positionIndex] = itemRId;
  }

  function unmountItem(uint256 itemRId, uint16 unitId) public {
      _unmountItem(msg.sender, itemRId, unitId);
  }

  function _unmountItem(address me, uint256 itemRId, uint16 unitId) private {
    require(hasItem(me, itemRId));

    _itemStatus[itemRId].mountedByUnitId = 0;

    uint16 itemId = _itemStatus[itemRId].itemId;
    uint16 positionIndex = Item(_items[itemId]).positionIndex();
    _status[me].unitMap[unitId].itemRIdArray[positionIndex] = 0;
  }

  function recycleItem(uint256 itemRId) public {
    require(hasItem(msg.sender, itemRId));

    address itemManager = AddressManager(_am).itemManager();
    ItemManager(itemManager).cancelFromAccount(msg.sender, itemRId);

    uint16 itemId = _itemStatus[itemRId].itemId;
    _destoryItem(msg.sender, itemRId);

    // Mint SGT.
    _mint(msg.sender, Item(_items[itemId]).cost());
  }

  function recycleInBatch(uint256[] itemRIdArray) public {
    uint256 totalCost = 0;
    uint16 i;

    for (i = 0; i < itemRIdArray.length; ++i) {
      uint256 itemRId = itemRIdArray[i];
      require(hasItem(msg.sender, itemRId));

      address itemManager = AddressManager(_am).itemManager();
      ItemManager(itemManager).cancelFromAccount(msg.sender, itemRId);

      uint16 itemId = _itemStatus[itemRId].itemId;
      _destoryItem(msg.sender, itemRId);

      totalCost += Item(_items[itemId]).cost();
    }

    // Mint SGT.
    _mint(msg.sender, totalCost);
  }

  function _fillEnergy(address me, uint16 unitId) private {
    _status[me].energyMap[unitId].amount = MAX_ENERGY;
    _status[me].energyMap[unitId].time = now;
  }

  function recover(uint16 unitId) public payable {
    address unit = _units[unitId];

    require(unit != 0);

    uint16 level = _status[msg.sender].unitMap[unitId].level;
    require(msg.value >= Unit(unit).lRecoverCost(level));

    _fillEnergy(msg.sender, unitId);

    TreasureManager(AddressManager(_am).treasureManager()).pay.value(msg.value)(msg.sender);
  }

  function recoverInBatch(uint16[] unitIdArray) public payable {
    uint16 i;
    uint256 total = 0;

    for (i = 0; i < unitIdArray.length; ++i) {
      uint16 unitId = unitIdArray[i];
      address unit = _units[unitId];
      require(unit != 0);
      uint16 level = _status[msg.sender].unitMap[unitId].level;
      total += Unit(unit).lRecoverCost(level);
    }

    require(msg.value >= total);

    for (i = 0; i < unitIdArray.length; ++i) {
      _fillEnergy(msg.sender, unitIdArray[i]);
    }

    TreasureManager(AddressManager(_am).treasureManager()).pay.value(msg.value)(msg.sender);
  }

  function upgrade(uint16 unitId) public {
    address unit = _units[unitId];
    require(unit != 0);

    uint16 level = _status[msg.sender].unitMap[unitId].level;
    uint256 cost = Unit(unit).lUpgradeCost(level);

    _burn(msg.sender, cost);

    ++_status[msg.sender].unitMap[unitId].level;
  }

  function consumeEnery(address me, uint16 unitId) public {
    require(msg.sender == AddressManager(_am).battle());

    (uint16 currentEnergy, uint256 pastTime) = getUnitEnergy(me, unitId);
    require(currentEnergy > 0);

    Status storage status = _status[me];
    status.energyMap[unitId].amount = currentEnergy - 1;

    if (currentEnergy == MAX_ENERGY) {
      status.energyMap[unitId].time = now;
    } else {
      status.energyMap[unitId].time = now - pastTime;
    }
  }

  function canDuel(address me, address peer) public view returns(bool) {
    Status storage status = _status[me];
    Status storage enemyStatus = _status[peer];

    return status.readyToDuel && enemyStatus.readyToDuel &&
        status.duelTime + (12 hours) < now &&
        enemyStatus.defeatTime + (24 hours) < now;
  }

  function _updateDuelHistory(address me, address peer, bytes memory records) private {
    DuelInfo memory duelInfo;
    duelInfo.time = now;
    duelInfo.from = me;
    duelInfo.to = peer;
    duelInfo.records = records;

    _infoOfDuel.push(duelInfo);
    _status[me].duelHistory.push(uint32(_infoOfDuel.length - 1));
    _status[peer].duelHistory.push(uint32(_infoOfDuel.length - 1));
  }

  function finishDuel(address me, address peer, bool didWin, bytes memory records, uint256 size) public {
    require(msg.sender == AddressManager(_am).battle());

    bytes memory combined = new bytes(records.length + 5);

    if (didWin) {
      // Refreshes duel time after victory.
      _status[me].duelTime = now;
      _status[peer].defeatTime = now;

      // Snatch and update records again.
      uint256 jhtAmount = _snatch(me, peer);

      combined[0] = byte(uint8(1));

      (combined[1], combined[2],
       combined[3], combined[4]) = uint32ToBytes(uint32(jhtAmount));
    }

    for (uint16 i = 0; i < size && i < records.length; ++i) {
      combined[5 + i] = records[i];
    }

    _updateDuelHistory(me, peer, combined);
  }

  function finishStage(address me, address stage, uint16 placeIndex, uint16 battleIndex, bool didWin, bytes memory records, uint256 size) public {
    bytes memory combined = new bytes(records.length + 9);

    if (didWin) {
      Stage(stage).finishState(me, placeIndex, battleIndex);

      uint256 jhtAmount = Stage(stage).getAmountOfJHT(placeIndex, battleIndex);
      _mint(me, jhtAmount);

      combined[0] = byte(uint8(1));

      (combined[1], combined[2],
       combined[3], combined[4]) = uint32ToBytes(uint32(jhtAmount));

      // TODO: use a better nonce.
      (uint16 dropItemId0, uint16 dropItemId1) = Stage(stage).maybeDrop(placeIndex, battleIndex, 0);

      if (dropItemId0 > 0) {
        _createItem(me, dropItemId0, 0, 0);
        (combined[5], combined[6]) = uint16ToBytes(dropItemId0);
      }

      if (dropItemId1 > 0) {
        _createItem(me, dropItemId1, 0, 0);
        (combined[7], combined[8]) = uint16ToBytes(dropItemId1);
      }
    }

    for (uint16 i = 0; i < size && i < records.length; ++i) {
      combined[9 + i] = records[i];
    }

    _status[me].records = combined;
  }

  function setDefenseUnits(uint16[UNIT_LIMIT] unitIdArray) public {
    require(unitIdArray.length == UNIT_LIMIT);

    uint16 count = 0;
    for (uint16 i = 0; i < UNIT_LIMIT; ++i) {
      if (unitIdArray[i] != 0 && _units[unitIdArray[i]] != 0) {
        for (uint16 j = 0; j < i; ++j) {
          require(unitIdArray[j] != unitIdArray[i]);
        }

        _status[msg.sender].defenseUnitIdArray[i] = unitIdArray[i];
        ++count;
      } else {
        _status[msg.sender].defenseUnitIdArray[i] = 0;
      }
    }

    require(count > 0);
  }

  function getBattleUnitFromStage(address stage, uint16 placeIndex, uint16 battleIndex, uint16 unitIndex)
      public view returns(uint16, uint16, uint16, uint16, uint16, uint16, uint16) {
    uint16 unitId;
    uint16 level;
    uint16[ITEM_LIMIT] memory itemIdArray;
    (unitId, level, itemIdArray) = Stage(stage).getBattleUnit(placeIndex, battleIndex, unitIndex);

    if (unitId == 0) return (0, 0, 0, 0, 0, 0, 0);

    address unit = _units[unitId];
    require(unit != 0);

    return (unitId, Unit(unit).lHp(level), Unit(unit).lAttack(level), Unit(unit).lIntelligence(level),
            Unit(unit).lDefense(level), Unit(unit).lAgility(level), Unit(unit).lLuck(level));
  }

  function getBattleUnit(address me, uint16 unitId)
      public view returns(uint16, uint16, uint16, uint16, uint16, uint16) {
    uint16[12] memory res;
    (res[0], res[1], res[2], res[3], res[4], res[5]) = getUnitInfo(me, unitId);
    (res[6], res[7], res[8], res[9], res[10], res[11]) = getUnitInfoOfItems(me, unitId);
    return (res[0] + res[6], res[1] + res[7], res[2] + res[8],
            res[3] + res[9], res[4] + res[10], res[5] + res[11]);
  }

  function random(uint16 nonce) private view returns (uint16) {
    return uint16(uint256(keccak256(block.difficulty, now, nonce)) % 65536);
  }

  function uint16ToBytes(uint16 x) private pure returns(byte, byte) {
    return (byte(uint8(x / 256)), byte(uint8(x % 256)));
  }

  function uint32ToBytes(uint32 x) private pure returns(byte, byte, byte, byte) {
    (byte b0, byte b1) = uint16ToBytes(uint16(x / 65536));
    (byte b2, byte b3) = uint16ToBytes(uint16(x % 65536));
    return (b0, b1, b2, b3);
  }

  mapping(uint16 => uint16[]) public formulaId;
  mapping(uint16 => uint16[]) public formulaCount;

  function addItemFormula(uint16[] itemIdArray, uint16[] itemCountArray, uint16 createdUnitId) public onlyOwner {
    formulaId[createdUnitId].length = 0;
    formulaCount[createdUnitId].length = 0;

    for (uint16 i = 0; i < itemIdArray.length; ++i) {
      formulaId[createdUnitId].push(itemIdArray[i]);
      formulaCount[createdUnitId].push(itemCountArray[i]);
    }
  }

  function _random(uint256 nonce) private view returns (uint16) {
    return uint16(uint256(keccak256(block.difficulty, now, nonce)) % 65536);
  }

  function synthesize(uint256[] itemRIdArray, uint16 createdUnitId) public {
    uint256 i;

    for (i = 0; i < formulaId[createdUnitId].length; ++i) {
      uint256 count = 0;

      for (uint256 j = 0; j < itemRIdArray.length; ++j) {
        if (_itemStatus[itemRIdArray[j]].itemId == formulaId[createdUnitId][i]) {
          ++count;
        }
      }

      require(count >= formulaCount[createdUnitId][i]);
    }

    for (i = 0; i < itemRIdArray.length; ++i) {
      address itemManager = AddressManager(_am).itemManager();
      ItemManager(itemManager).cancelFromAccount(msg.sender, itemRIdArray[i]);

      _destoryItem(msg.sender, itemRIdArray[i]);
    }

    uint16 score = _random(_itemRId) % 101;
    _createItem(msg.sender, createdUnitId, 1, score);
  }

  function _mint(address me, uint256 amount) private {
    SanGuoToken(AddressManager(_am).token()).mint(me, amount);
    TreasureManager(AddressManager(_am).treasureManager()).check(me);
  }

  function _burn(address me, uint256 amount) private {
    SanGuoToken(AddressManager(_am).token()).burn(me, amount);
    TreasureManager(AddressManager(_am).treasureManager()).check(me);
  }

  function burnForDividend(uint256 amount) public {
    SanGuoToken(AddressManager(_am).token()).burn(msg.sender, amount);
    TreasureManager(AddressManager(_am).treasureManager()).burnForDividend(msg.sender, amount);
  }

  function _snatch(address me, address peer) private returns(uint256) {
    uint256 amount = SanGuoToken(AddressManager(_am).token()).balanceOf(peer) / 20;

    SanGuoToken(AddressManager(_am).token()).snatch(peer, me, amount);

    TreasureManager(AddressManager(_am).treasureManager()).check(me);
    TreasureManager(AddressManager(_am).treasureManager()).check(peer);

    if (_status[me].duelScore <= _status[peer].duelScore) {
      uint32 delta = _status[peer].duelScore / 10;
      _status[peer].duelScore -= delta;
      _status[me].duelScore += delta;
    }

    return amount;
  }

  function getBattleRecordAsBytes() public view returns(bytes) {
    return _status[msg.sender].records;
  }

  function getDuelRecordAsBytes(uint256 index) public view returns(bytes) {
    return _infoOfDuel[index].records;
  }

  function getLastDuelRecordFromMeAsBytes() public view returns(bytes) {
    uint256 i;
    for (i = 0; i < _status[msg.sender].duelHistory.length; ++i) {
      uint256 index = _status[msg.sender].duelHistory[_status[msg.sender].duelHistory.length - 1 - i];
      if (_infoOfDuel[index].from == msg.sender) {
        return _infoOfDuel[index].records;
      }
    }
    return;
  }

  function getRecentDuelRecordsAsBytes(uint16 count) public view returns(bytes) {
    require(count <= 10);

    Status storage status = _status[msg.sender];

    uint256 nCount = count < status.duelHistory.length ? uint256(count) : status.duelHistory.length;

    // Both TRON and Ethereum is 20.
    bytes memory data = new bytes(nCount * (32 + 20 + 4 + 1 + 1 + 4));
    // time, address, snatch, direction, result, index

    uint16 offset = 0;

    for (uint256 i = 0; i < nCount; ++i) {
      DuelInfo storage info = _infoOfDuel[status.duelHistory[status.duelHistory.length - 1 - i]];

      uint j;

      // Time.
      for (j = 0; j < 32; j++) {
        data[offset + j] = byte(uint8(info.time / (2**(8*(31 - j)))));
      }

      // Enemy address.
      address enemyAddress = info.from == msg.sender ? info.to : info.from;
      for (j = 0; j < 20; j++) {
        data[offset + 32 + j] = byte(uint8(uint(enemyAddress) / (2**(8*(19 - j)))));
      }

      // snatch.
      for (j = 0; j < 4; ++j) {
        data[offset + 52 + j] = info.records[1 + j];
      }

      // Direction.
      data[offset + 56] = info.from == msg.sender ? byte(uint8(2)) : byte(uint8(1));

      // Result.
      data[offset + 57] = info.records[0];

      // Index.
      for (j = 0; j < 4; j++) {
        data[offset + 58 + j] = byte(uint8(status.duelHistory[i] / (2**(8*(3 - j)))));
      }

      offset += 62;
    }

    return data;
  }

  function getItemInfo(uint256 rId) public view returns(uint16, uint16, uint16) {
    ItemInfo storage info = _itemStatus[rId];
    return (info.itemId, info.level, info.score);
  }

  function getMyItemsAsBytes() public view returns(bytes) {
    Status storage me = _status[msg.sender];

    uint16 offset = 0;
    uint16 i;

    bytes memory data = new bytes(me.itemRIdList.length * 12);

    for (i = 0; i < me.itemRIdList.length; ++i) {
      uint256 rId = me.itemRIdList[i];
      (data[offset], data[offset + 1], data[offset + 2], data[offset + 3]) = uint32ToBytes(uint32(rId));
      (data[offset + 4], data[offset + 5]) = uint16ToBytes(_itemStatus[rId].itemId);
      (data[offset + 6], data[offset + 7]) = uint16ToBytes(_itemStatus[rId].level);
      (data[offset + 8], data[offset + 9]) = uint16ToBytes(_itemStatus[rId].score);
      (data[offset + 10], data[offset + 11]) = uint16ToBytes(_itemStatus[rId].mountedByUnitId);
      offset += 12;
    }

    return data;
  }

  function getUnitInfo(address me, uint16 unitId) public view returns(uint16, uint16, uint16, uint16, uint16, uint16) {
    if (!hasUnit(me, unitId)) {
      return (0, 0, 0, 0, 0, 0);
    }

    Status storage status = _status[me];

    uint16 level = status.unitMap[unitId].level;

    uint16[6] memory result;

    address unit = _units[unitId];

    result[0] = Unit(unit).lHp(level);
    result[1] = Unit(unit).lAttack(level);
    result[2] = Unit(unit).lIntelligence(level);
    result[3] = Unit(unit).lDefense(level);
    result[4] = Unit(unit).lAgility(level);
    result[5] = Unit(unit).lLuck(level);

    return (result[0], result[1], result[2], result[3], result[4], result[5]);
  }

  function getUnitInfoOfItems(address me, uint16 unitId) public view returns(uint16, uint16, uint16, uint16, uint16, uint16) {
    if (!hasUnit(me, unitId)) {
      return (0, 0, 0, 0, 0, 0);
    }

    uint16[6] memory result;

    uint256[ITEM_LIMIT] storage itemRIdArray = _status[me].unitMap[unitId].itemRIdArray;

    for (uint8 i = 0; i < itemRIdArray.length; ++i) {
      if (itemRIdArray[i] != 0) {
        address item = _items[_itemStatus[itemRIdArray[i]].itemId];

        result[0] += Item(item).hp();
        result[1] += Item(item).attack();
        result[2] += Item(item).intelligence();
        result[3] += Item(item).defense();
        result[4] += Item(item).agility();
        result[5] += Item(item).luck();
      }
    }

    return (result[0], result[1], result[2], result[3], result[4], result[5]);
  }

  function getMyProfileAsBytes() public view returns(bytes) {
    Status storage me = _status[msg.sender];

    bytes memory data = new bytes(34 * me.unitIdList.length);

    uint16 offset = 0;
    uint16 i;

    for (i = 0; i < me.unitIdList.length; ++i) {
      uint16 unitId = me.unitIdList[i];

      if (unitId == 0) {
        offset += 34;
        continue;
      }

      (data[offset], data[offset + 1]) = uint16ToBytes(me.unitMap[unitId].level);
      (data[offset + 2], data[offset + 3]) = uint16ToBytes(me.unitMap[unitId].unitId);
      (data[offset + 4], data[offset + 5]) = uint16ToBytes(_itemStatus[me.unitMap[unitId].itemRIdArray[0]].itemId);
      (data[offset + 6], data[offset + 7]) = uint16ToBytes(_itemStatus[me.unitMap[unitId].itemRIdArray[1]].itemId);
      (data[offset + 8], data[offset + 9]) = uint16ToBytes(_itemStatus[me.unitMap[unitId].itemRIdArray[2]].itemId);
      uint16 hp;
      uint16 attack;
      uint16 intelligence;
      uint16 defense;
      uint16 agility;
      uint16 luck;
      (hp, attack, intelligence, defense, agility, luck) = getUnitInfo(msg.sender, unitId);
      (data[offset + 10], data[offset + 11]) = uint16ToBytes(hp);
      (data[offset + 12], data[offset + 13]) = uint16ToBytes(attack);
      (data[offset + 14], data[offset + 15]) = uint16ToBytes(intelligence);
      (data[offset + 16], data[offset + 17]) = uint16ToBytes(defense);
      (data[offset + 18], data[offset + 19]) = uint16ToBytes(agility);
      (data[offset + 20], data[offset + 21]) = uint16ToBytes(luck);
      (hp, attack, intelligence, defense, agility, luck) = getUnitInfoOfItems(msg.sender, unitId);
      (data[offset + 22], data[offset + 23]) = uint16ToBytes(hp);
      (data[offset + 24], data[offset + 25]) = uint16ToBytes(attack);
      (data[offset + 26], data[offset + 27]) = uint16ToBytes(intelligence);
      (data[offset + 28], data[offset + 29]) = uint16ToBytes(defense);
      (data[offset + 30], data[offset + 31]) = uint16ToBytes(agility);
      (data[offset + 32], data[offset + 33]) = uint16ToBytes(luck);
      offset += 34;
    }

    return data;
  }

  function _getItemIdOfUnit(uint16 unitId, uint16 index) private view returns(uint16) {
    Status storage me = _status[msg.sender];
    return _itemStatus[me.unitMap[unitId].itemRIdArray[index]].itemId;
  }

  function getBattleFieldAsBytes(uint16[] unitIdArray, address stage, uint16 placeIndex, uint16 battleIndex) public view returns(bytes) {
    require(unitIdArray.length == UNIT_LIMIT);

    bytes memory data = new bytes(12 * UNIT_LIMIT * 2);

    uint16 i;
    uint16 offset = 0;

    // Fills enemy array accoring to stage.

    uint16 unitId;
    uint16 level;
    uint16[ITEM_LIMIT] memory itemIdArray;
    uint16 hp;

    for (i = 0; i < UNIT_LIMIT; ++i) {
      (unitId, level, itemIdArray) = Stage(stage).getBattleUnit(placeIndex, battleIndex, i);

      if (unitId == 0) {
        offset += 12;
        continue;
      }

      hp = Unit(_units[unitId]).lHp(level);

      (data[offset], data[offset + 1]) = uint16ToBytes(hp);
      (data[offset + 2], data[offset + 3]) = uint16ToBytes(level);
      (data[offset + 4], data[offset + 5]) = uint16ToBytes(unitId);
      (data[offset + 6], data[offset + 7]) = uint16ToBytes(_itemStatus[itemIdArray[0]].itemId);
      (data[offset + 8], data[offset + 9]) = uint16ToBytes(_itemStatus[itemIdArray[1]].itemId);
      (data[offset + 10], data[offset + 11]) = uint16ToBytes(_itemStatus[itemIdArray[2]].itemId);
      offset += 12;
    }

    // Fills my array.

    Status storage me = _status[msg.sender];

    for (i = 0; i < UNIT_LIMIT; ++i) {
      unitId = unitIdArray[i];

      if (unitId == 0) {
        offset += 12;
        continue;
      }

      level = me.unitMap[unitIdArray[i]].level;

      hp = Unit(_units[unitId]).lHp(level);

      (data[offset], data[offset + 1]) = uint16ToBytes(hp);
      (data[offset + 2], data[offset + 3]) = uint16ToBytes(level);
      (data[offset + 4], data[offset + 5]) = uint16ToBytes(unitId);
      (data[offset + 6], data[offset + 7]) = uint16ToBytes(_getItemIdOfUnit(unitIdArray[i], 0));
      (data[offset + 8], data[offset + 9]) = uint16ToBytes(_getItemIdOfUnit(unitIdArray[i], 1));
      (data[offset + 10], data[offset + 11]) = uint16ToBytes(_getItemIdOfUnit(unitIdArray[i], 2));
      offset += 12;
    }

    return data;
  }

  function getPeerBattleFieldAsBytes(uint16[] unitIdArray, address peer) public view returns(bytes) {
    require(unitIdArray.length == UNIT_LIMIT);

    bytes memory data = new bytes(12 * UNIT_LIMIT * 2);

    uint16 i;
    uint16 offset = 0;
    uint16 hp;

    // Fills enemy array accoring to peer.

    Status storage enemy = _status[peer];

    for (i = 0; i < UNIT_LIMIT; ++i) {
      UnitInfo storage info = enemy.unitMap[enemy.defenseUnitIdArray[i]];

      hp = Unit(_units[info.unitId]).lHp(info.level);

      (data[offset], data[offset + 1]) = uint16ToBytes(hp);
      (data[offset + 2], data[offset + 3]) = uint16ToBytes(info.level);
      (data[offset + 4], data[offset + 5]) = uint16ToBytes(info.unitId);
      (data[offset + 6], data[offset + 7]) = uint16ToBytes(_itemStatus[info.itemRIdArray[0]].itemId);
      (data[offset + 8], data[offset + 9]) = uint16ToBytes(_itemStatus[info.itemRIdArray[1]].itemId);
      (data[offset + 10], data[offset + 11]) = uint16ToBytes(_itemStatus[info.itemRIdArray[2]].itemId);
      offset += 12;
    }

    // Fills my array.

    Status storage me = _status[msg.sender];

    for (i = 0; i < UNIT_LIMIT; ++i) {
      uint16 unitId = me.unitMap[unitIdArray[i]].unitId;
      uint16 level = me.unitMap[unitIdArray[i]].level;

      hp = Unit(_units[unitId]).lHp(level);

      (data[offset], data[offset + 1]) = uint16ToBytes(hp);
      (data[offset + 2], data[offset + 3]) = uint16ToBytes(level);
      (data[offset + 4], data[offset + 5]) = uint16ToBytes(unitId);
      (data[offset + 6], data[offset + 7]) = uint16ToBytes(_getItemIdOfUnit(unitIdArray[i], 0));
      (data[offset + 8], data[offset + 9]) = uint16ToBytes(_getItemIdOfUnit(unitIdArray[i], 1));
      (data[offset + 10], data[offset + 11]) = uint16ToBytes(_getItemIdOfUnit(unitIdArray[i], 2));
      offset += 12;
    }

    return data;
  }

  function getUnitEnergy(address me, uint16 unitId) public view returns(uint16, uint256) {
    EnergyInfo storage info =  _status[me].energyMap[unitId];
    uint16 realAmount = info.amount + uint16((now - info.time) / (1 hours));

    if (realAmount > MAX_ENERGY) {
      return (MAX_ENERGY, 0);
    } else {
      return (realAmount, (((now - info.time) % (1 hours))));
    }
  }

  function getDuelTime() public view returns(uint256) {
    return _status[msg.sender].duelTime;
  }

  function getDuelWaitingTime() public view returns(uint256) {
    return now - getDuelTime();
  }

  function isSafeFromAttack(address me) public view returns(bool) {
    return now <= _status[me].defeatTime + (24 hours);
  }

  function getDuelPlayersAsBytes(address[] playerArray) public view returns(bytes) {
    require(playerArray.length <= 100);

    bytes memory data = new bytes((6 + 6 + 18 + 4 + 4) * playerArray.length);

    uint16 offset = 0;

    for (uint16 i = 0; i < playerArray.length; ++i) {
      Status storage status = _status[playerArray[i]];

      (data[offset], data[offset + 1]) = uint16ToBytes(status.defenseUnitIdArray[0]);
      (data[offset + 2], data[offset + 3]) = uint16ToBytes(status.unitMap[status.defenseUnitIdArray[0]].level);
      (data[offset + 4], data[offset + 5]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[0]].itemRIdArray[0]].itemId);
      (data[offset + 6], data[offset + 7]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[0]].itemRIdArray[1]].itemId);
      (data[offset + 8], data[offset + 9]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[0]].itemRIdArray[2]].itemId);

      (data[offset + 10], data[offset + 11]) = uint16ToBytes(status.defenseUnitIdArray[1]);
      (data[offset + 12], data[offset + 13]) = uint16ToBytes(status.unitMap[status.defenseUnitIdArray[1]].level);
      (data[offset + 14], data[offset + 15]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[1]].itemRIdArray[0]].itemId);
      (data[offset + 16], data[offset + 17]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[1]].itemRIdArray[1]].itemId);
      (data[offset + 18], data[offset + 19]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[1]].itemRIdArray[2]].itemId);

      (data[offset + 20], data[offset + 21]) = uint16ToBytes(status.defenseUnitIdArray[2]);
      (data[offset + 22], data[offset + 23]) = uint16ToBytes(status.unitMap[status.defenseUnitIdArray[2]].level);
      (data[offset + 24], data[offset + 25]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[2]].itemRIdArray[0]].itemId);
      (data[offset + 26], data[offset + 27]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[2]].itemRIdArray[1]].itemId);
      (data[offset + 28], data[offset + 29]) = uint16ToBytes(_itemStatus[status.unitMap[status.defenseUnitIdArray[2]].itemRIdArray[2]].itemId);

      (data[offset + 30], data[offset + 31], data[offset + 32], data[offset + 33]) =
          uint32ToBytes(uint32(SanGuoToken(AddressManager(_am).token()).balanceOf(playerArray[i])));

      (data[offset + 34], data[offset + 35], data[offset + 36], data[offset + 37]) =
          uint32ToBytes(uint32(status.duelScore));

      offset += 38;
    }

    return data;
  }

  function getDefenseUnitIdArray(address me) public view returns(uint16, uint16, uint16) {
    return (_status[me].defenseUnitIdArray[0],
            _status[me].defenseUnitIdArray[1],
            _status[me].defenseUnitIdArray[2]);
  }
}


contract UnitManager is Owned {

  mapping(uint16 => uint16) public initialAmount;  // unitId => amount
  mapping(uint16 => uint256) public price;
  mapping(uint16 => uint256) public priceStep;

  mapping(address => mapping(uint16 => uint16)) public offerMap;  // seller => unitId => offerIndex + 1

  struct Offer {
    address seller;
    uint16 unitId;
    uint256 price;
  }

  Offer[] public offerList;

  address _am;

  constructor(address addressManager) public {
    _am = addressManager;
  }

  // TODO: clear and security.

  function addUnit(uint16 unitId, uint16 _initialAmount, uint256 _initialPrice, uint256 _priceStep) public onlyOwner {
    initialAmount[unitId] = _initialAmount;
    price[unitId] = _initialPrice;
    priceStep[unitId] = _priceStep;
  }

  function buyFromPlatform(uint16 unitId) public payable {
    address account = AddressManager(_am).account();
    require(account != 0);
    require(!Account(account).hasUnit(msg.sender, unitId));

    require(msg.value >= price[unitId]);

    if (initialAmount[unitId] > 0) {
      --initialAmount[unitId];
    }

    if (initialAmount[unitId] == 0) {
      price[unitId] += priceStep[unitId];
    }

    // Starts from level 1.
    Account(AddressManager(_am).account()).syncAddUnit(msg.sender, unitId, 1);

    TreasureManager(AddressManager(_am).treasureManager()).pay.value(msg.value)(msg.sender);
  }

  function sell(uint16 unitId, uint256 _price) public {
    require(_price > 0);

    address account = AddressManager(_am).account();
    require(account != 0);
    require(Account(account).hasUnit(msg.sender, unitId));

    require(offerMap[msg.sender][unitId] == 0);

    Offer memory offer;
    offer.seller = msg.sender;
    offer.unitId = unitId;
    offer.price = _price;
    offerList.push(offer);

    offerMap[msg.sender][unitId] = uint16(offerList.length);
  }

  function cancel(uint16 unitId) public {
    _remove(msg.sender, unitId);
  }

  function _remove(address seller, uint16 unitId) private {
    require(offerMap[seller][unitId] > 0);

    uint16 offerIndex = offerMap[seller][unitId] - 1;
    uint16 lastIndex = uint16(offerList.length - 1);

    if (offerIndex < lastIndex) {
      offerList[offerIndex].seller = offerList[lastIndex].seller;
      offerList[offerIndex].unitId = offerList[lastIndex].unitId;
      offerList[offerIndex].price = offerList[lastIndex].price;
    }

    --offerList.length;  // Deletes this element.

    offerMap[seller][unitId] = 0;
  }

  function buy(uint16 offerIndex) public payable {
    Offer storage offer = offerList[offerIndex];
    address offerSeller = offer.seller;
    uint16 offerUnitId = offer.unitId;

    require(offerSeller != 0);

    address account = AddressManager(_am).account();
    require(account != 0);
    require(!Account(account).hasUnit(msg.sender, offerUnitId));

    require(msg.value >= offer.price);

    uint256 value0 = offer.price / 100 * 95;
    uint256 value1 = msg.value - value0;

    address(offerSeller).transfer(value0);

    _remove(offerSeller, offerUnitId);

    uint16 currentLevel = Account(account).getUnitLevel(offerSeller, offerUnitId);
    Account(AddressManager(_am).account()).syncRemoveUnit(offerSeller, offerUnitId);
    Account(AddressManager(_am).account()).syncAddUnit(msg.sender, offerUnitId, currentLevel);

    TreasureManager(AddressManager(_am).treasureManager()).pay.value(value1)(msg.sender);
  }
}


contract ItemManager is Owned {

  mapping(address => mapping(uint256 => uint16)) public offerMap;  // seller => itemRId => offerIndex + 1

  struct Offer {
    address seller;
    uint256 itemRId;
    uint256 price;
  }

  Offer[] public offerList;

  address _am;

  constructor(address addressManager) public {
    _am = addressManager;
  }

  function sell(uint16 itemRId, uint256 _price) public {
    require(_price > 0);

    address account = AddressManager(_am).account();
    require(account != 0);
    require(Account(account).hasItem(msg.sender, itemRId));

    Offer memory offer;
    offer.seller = msg.sender;
    offer.itemRId = itemRId;
    offer.price = _price;
    offerList.push(offer);

    offerMap[msg.sender][itemRId] = uint16(offerList.length);
  }

  function cancel(uint256 itemRId) public {
    _remove(msg.sender, itemRId);
  }

  function cancelFromAccount(address me, uint256 itemRId) public {
    require(msg.sender == AddressManager(_am).account());

    if (offerMap[me][itemRId] > 0)  {
      _remove(me, itemRId);
    }
  }

  function _remove(address seller, uint256 itemRId) private {
    require(offerMap[seller][itemRId] > 0);

    uint16 offerIndex = offerMap[seller][itemRId] - 1;
    uint16 lastIndex = uint16(offerList.length - 1);

    if (offerIndex < lastIndex) {
      offerList[offerIndex].seller = offerList[lastIndex].seller;
      offerList[offerIndex].itemRId = offerList[lastIndex].itemRId;
      offerList[offerIndex].price = offerList[lastIndex].price;
    }

    --offerList.length;  // Deletes this element.

    offerMap[seller][itemRId] = 0;
  }

  function buy(uint16 offerIndex) public payable {
    Offer storage offer = offerList[offerIndex];
    address offerSeller = offer.seller;
    uint256 offerItemRId = offer.itemRId;

    require(offerSeller != 0);

    address account = AddressManager(_am).account();
    require(account != 0);
    require(!Account(account).hasItem(msg.sender, offerItemRId));

    require(msg.value >= offer.price);

    uint256 value0 = offer.price / 100 * 95;
    uint256 value1 = msg.value - value0;

    address(offerSeller).transfer(value0);

    _remove(offerSeller, offerItemRId);

    Account(AddressManager(_am).account()).transferItem(offerSeller, msg.sender, offerItemRId);

    TreasureManager(AddressManager(_am).treasureManager()).pay.value(value1)(msg.sender);
  }
}


contract ReferralManager is Owned {

  mapping(address => address) public referredBy;
  mapping(address => uint256) public spentAmount;

  mapping(address => address[]) public teamLevel0;
  mapping(address => address[]) public teamLevel1;
  mapping(address => address[]) public teamLevel2;

  address _am;

  constructor(address addressManager) public {
    _am = addressManager;
  }

  function addReferral(address _from, address _to) public {
    require(msg.sender == AddressManager(_am).account());

    referredBy[_to] = _from;

    teamLevel0[_from].push(_to);

    if (referredBy[_from] != 0) {
      teamLevel1[referredBy[_from]].push(_to);

      address tier2Address = referredBy[referredBy[_from]];
      if (tier2Address != 0) {
        teamLevel2[tier2Address].push(_to);
      }
    }
  }

  function addSpentAmount(address _from, uint256 amount) public {
    require(msg.sender == AddressManager(_am).treasureManager());

    spentAmount[_from] += amount;
  }

  function getReferrer(address _to, uint16 level) public view returns(address) {
    require(level <= 2);

    if (level == 0) {
      if (referredBy[_to] != 0) {
        return referredBy[_to];
      } else {
        return owner;
      }
    } else if (level == 1) {
      if (referredBy[_to] != 0 && referredBy[referredBy[_to]] != 0) {
        return referredBy[referredBy[_to]];
      } else {
        return owner;
      }
    } else {
      if (referredBy[_to] != 0 && referredBy[referredBy[_to]] != 0 &&
          referredBy[referredBy[referredBy[_to]]] != 0) {
        return referredBy[referredBy[referredBy[_to]]];
      } else {
        return owner;
      }
    }
  }
}


contract TreasureManager is Owned {

  mapping(uint16 => bool) public hasDate;
  mapping(uint16 => uint256) public burnedAmountByDate;
  mapping(uint16 => uint256) public jhtAmountByDate;
  mapping(uint16 => uint256) public trxAmountByDate;

  uint256 public profit;

  struct CP {
    uint16 date;
    uint256 balance;
  }

  mapping(address => CP[]) public checkPoints;
  mapping(address => CP[]) public burnPoints;

  mapping(address => uint16) public clearDate;
  mapping(address => uint256) public clearBalance;

  mapping(address => uint256) public referralBonusLevel0;
  mapping(address => uint256) public referralBonusLevel1;
  mapping(address => uint256) public referralBonusLevel2;

  address _am;

  constructor(address addressManager) public {
    _am = addressManager;
  }

  function _ceilDate(uint256 time) private pure returns(uint16) {
    if (time % 86400 == 0) {
      return uint16(time / 86400);
    } else {
      return uint16(time / 86400 + 1);
    }
  }

  function _getYesterday() private view returns(uint16) {
    return _ceilDate(now) - 1;
  }

  function _getToday() private view returns(uint16) {
    return _ceilDate(now);
  }

  // This method needs to be called everytime players spent money.
  function pay(address me) public payable {
    uint16 today = _getToday();

    uint256 value0 = msg.value * 70 / 100;  // 70%
    trxAmountByDate[today] += value0;
    hasDate[today] = true;

    ReferralManager rm = ReferralManager(AddressManager(_am).referralManager());

    address level0Referrer = rm.getReferrer(me, 0);
    address level1Referrer = rm.getReferrer(me, 1);
    address level2Referrer = rm.getReferrer(me, 2);

    uint256 value1 = msg.value / 10;  // 10%
    clearBalance[level0Referrer] += value1;
    referralBonusLevel0[level0Referrer] += value1;

    uint256 value2 = msg.value * 618 / 1000;  // 6.18%
    clearBalance[level1Referrer] += value2;
    referralBonusLevel1[level1Referrer] += value2;

    uint256 value3 = msg.value * 382 / 1000;  // 3.82%
    clearBalance[level2Referrer] += value3;
    referralBonusLevel2[level2Referrer] += value3;

    profit += msg.value - value0 - value1 - value2 - value3;  // 10%

    rm.addSpentAmount(me, msg.value);
  }

  // This method needs to be called everytime new tokens are mint or burned or snatched.
  function check(address me) public {
    require(msg.sender == AddressManager(_am).account());

    uint16 today = _getToday();
    jhtAmountByDate[today] = SanGuoToken(AddressManager(_am).token()).totalSupply();

    CP memory cp;

    uint256 balance = SanGuoToken(AddressManager(_am).token()).balanceOf(me);

    if (checkPoints[me].length > 0) {
      uint16 oldDate = checkPoints[me][checkPoints[me].length - 1].date;

      require(today >= oldDate);

      if (today == oldDate) {
        checkPoints[me][checkPoints[me].length - 1].balance = balance;
      } else {
        cp.date = today;
        cp.balance = balance;
        checkPoints[me].push(cp);
      }
    } else {
      cp.date = today;
      cp.balance = balance;
      checkPoints[me].push(cp);
    }
  }

  function burnForDividend(address me, uint256 amount) public {
    require(msg.sender == AddressManager(_am).account());

    uint16 today = _getToday();
    burnedAmountByDate[today] += amount;
    jhtAmountByDate[today] = SanGuoToken(AddressManager(_am).token()).totalSupply();

    CP memory cp;

    if (burnPoints[me].length > 0) {
      uint16 oldDate = burnPoints[me][burnPoints[me].length - 1].date;

      require(today >= oldDate);

      if (today == oldDate) {
        burnPoints[me][burnPoints[me].length - 1].balance += amount;
      } else {
        cp.date = today;
        cp.balance = amount;
        burnPoints[me].push(cp);
      }
    } else {
      cp.date = today;
      cp.balance = amount;
      burnPoints[me].push(cp);
    }
  }

  function getRecentDividendFromHoldingAsBytes(address me, uint16 count) public view returns(bytes, uint16) {
    require(count <= 365);

    bytes memory result = new bytes(count * 4);
    uint16 yesterday = _getYesterday();

    if (checkPoints[me].length == 0) {
      return (result, yesterday);
    }

    uint256 offset = 0;
    uint16 index = uint16(checkPoints[me].length - 1);

    uint256 cDividend;

    for (uint16 i = 0; i < count; ++i) {
      uint16 date = yesterday - i;

      if (hasDate[date]) {
        // Skip days with no income.

        while (index > 0 && checkPoints[me][index].date > date) {
          --index;
        }

        if (checkPoints[me][index].date > date) {
          cDividend = 0;
        } else {
          cDividend = checkPoints[me][index].balance;
        }

        cDividend = cDividend * (trxAmountByDate[date] / 5 * 4) / jhtAmountByDate[date];  // 80%

        for (uint256 j = 0; j < 4; ++j) {
          result[offset + j] = byte(uint8(cDividend / (2**(8*(3 - j)))));
        }
      }

      offset += 4;
    }

    return (result, yesterday);
  }

  function getRecentDividendFromBurning(address me) public view returns(uint256, uint16) {
    if (burnPoints[me].length == 0) return (0, 0);

    uint16 today = _getToday();

    CP storage cp = burnPoints[me][burnPoints[me].length - 1];

    if (cp.date == today) {
      if (burnPoints[me].length >= 2) {
        cp = burnPoints[me][burnPoints[me].length - 2];
      } else {
        return (0, 0);
      }
    }

    if (burnedAmountByDate[cp.date] == 0) return (0, cp.date);

    return (cp.balance * (trxAmountByDate[cp.date] / 5) / burnedAmountByDate[cp.date], cp.date);
  }

  function getTotalBalance(address me) public view returns(uint256) {
    uint16 count = 365;

    uint256 result = 0;

    uint16 cIndex = checkPoints[me].length > 0 ? uint16(checkPoints[me].length - 1) : 0;
    uint16 bIndex = burnPoints[me].length > 0 ? uint16(burnPoints[me].length - 1) : 0;

    uint256 cDividend;
    uint256 bDividend;

    uint16 yesterday = _getYesterday();

    for (uint16 i = 0; i < count; ++i) {
      uint16 date = yesterday - i;

      if (date <= clearDate[me]) {
        // date is already ealier than clear date.
        break;
      }

      if (!hasDate[date]) {
        // Skip days with no income.
        continue;
      }

      while (cIndex > 0 && checkPoints[me][cIndex].date > date) {
        --cIndex;
      }

      while (bIndex > 0 && burnPoints[me][bIndex].date > date) {
        --bIndex;
      }

      if (checkPoints[me].length == 0 || checkPoints[me][cIndex].date > date) {
        // date is already earlier than the first transaction.
        cDividend = 0;
      } else {
        cDividend = checkPoints[me][cIndex].balance * (trxAmountByDate[date] / 5 * 4) / jhtAmountByDate[date];
      }

      if (burnPoints[me].length == 0 || burnPoints[me][bIndex].date != date || burnedAmountByDate[date] == 0) {
        bDividend = 0;
      } else {
        bDividend = burnPoints[me][bIndex].balance * (trxAmountByDate[date] / 5) / burnedAmountByDate[date];
      }

      result += (cDividend + bDividend);
    }

    return result + clearBalance[me] + referralBonusLevel0[me] + referralBonusLevel1[me];
  }

  function clearCheckPoints(address me) public {
    clearDate[me] = _getYesterday();
    clearBalance[me] = getTotalBalance(me);
  }

  function withdraw() public {
    uint256 balance = getTotalBalance(msg.sender);
    clearDate[msg.sender] = _getYesterday();
    clearBalance[msg.sender] = 0;
    address(msg.sender).transfer(balance);
  }

  function withdrawProfit(address toAddress) public onlyOwner {
    address(toAddress).transfer(profit);
  }

  function getBurnedAmountToday(address me) public view returns(uint256) {
    if (burnPoints[me].length == 0) return 0;

    CP storage cp = burnPoints[me][burnPoints[me].length - 1];

    if (cp.date == _getToday()) {
      return cp.balance;
    } else {
      return 0;
    }
  }

  function getRemainingTime(uint256 offset) public view returns(uint256) {
    require(offset < 86400);
    return 86400 - (now - offset) % 86400;
  }

  function getTodayBurnedAmount() public view returns(uint256) {
    return burnedAmountByDate[_getToday()];
  }

  function getTodayTrxAmount() public view returns(uint256) {
    return trxAmountByDate[_getToday()];
  }
}
