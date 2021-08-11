library SafeMath16 {

    function mul(uint16 a, uint16 b) internal pure returns (uint16) {
        if (a == 0) {
            return 0;
        }
        uint16 c = a * b;
        require(c / a == b);
        return c;
    }

    function div(uint16 a, uint16 b) internal pure returns (uint16) {
        require(b > 0);
        uint16 c = a / b;
        return c;
    }

    function sub(uint16 a, uint16 b) internal pure returns (uint16) {
        require(b <= a);
        uint16 c = a - b;
        return c;
    }

    function add(uint16 a, uint16 b) internal pure returns (uint16) {
        uint16 c = a + b;
        require(c >= a);
        return c;
    }

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