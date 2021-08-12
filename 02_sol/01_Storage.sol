pragma solidity >=0.4.22 <0.7.0;

/**
 * @title Storage
 * @dev Store & retreive value in a variable
 */
contract Storage {

    uint256 number;
    uint8  number_uint8;

    function store(uint256 num) public {
        number = num;
    }

    function store_10000(uint256 num) public {
        for(uint i=0; i<500; i++){
            number = num;
        }
    }

    function store_uint8(uint8 num) public{
        number_uint8=num;
    }

    function store_uint8_10000(uint8 num) public{
            for(uint i=0; i<500; i++){
            number_uint8 = num;
        }
    }
}