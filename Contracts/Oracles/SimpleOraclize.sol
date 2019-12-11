pragma solidity >=0.5.0 <0.6.0;
import "./Oraclize.sol";

//This contract is used to pull random numbers.

contract SimpleOraclize is Oraclize {

    string public ETHXBT;
    event LogConstructorInitiated(string nextStep);
    event LogPriceUpdated(string price);
    event LogNewOraclizeQuery(string description);

    constructor() public payable {
        LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Oraclize Query.");
    }

    function __callback(bytes32 myid, string memory result) private {
        if (msg.sender != oraclize_cbAddress()) revert();
        ETHXBT = result;
        LogPriceUpdated(result);
    }

    function updatePrice() public payable {
        if (oraclize_getPrice("URL") > this.balance) {
            emit LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            oraclize_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHXBT).result.XETHXXBT.c.0");
        }
    }

    function random() private view returns (uint8) {
        return uint8(uint256(keccak256(block.timestamp, block.difficulty,   oraclize_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHXBT).result.XETHXXBT.c.0")))%251);
    }
}