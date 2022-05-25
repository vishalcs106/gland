pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import '@chainlink/contracts/src/v0.8/ChainlinkClient.sol';
import '@chainlink/contracts/src/v0.8/ConfirmedOwner.sol';

contract GLandArt is ChainlinkClient, ConfirmedOwner{

    using SafeERC20 for IERC20;
    address deadAddress = 0x000000000000000000000000000000000000dEaD;
    using Chainlink for Chainlink.Request;
    bytes32 private jobId;
    uint256 private fee;
    struct GameRoom{
        string gameRoomId;
        address[] players;
        uint betValue;
        uint reward;
        address winnerId;
        bool isExist;
	}

    mapping(string => GameRoom) public games;
    IERC20 public erc20Contract;

    constructor() ConfirmedOwner(msg.sender) {
        setChainlinkToken(0xa36085F69e2889c224210F603D836748e7dC0088);
        setChainlinkOracle(0x74EcC8Bdeb76F2C6760eD2dc8A46ca5e581fA656);
        jobId = 'ca98366cc7314957b8c012c72f05aeeb';
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
    }

    function joinGameRoom(string memory gameRoomId, address player, uint betValue, uint reward) public payable{
        require(msg.value >= betValue, "Not enough tokens sent");
        if(games[gameRoomId].isExist){
            games[gameRoomId].players.push(player);
        } else{
            address[] memory playersArray = new address[](1);
            playersArray[0] = player;
            games[gameRoomId] = GameRoom(gameRoomId, playersArray, betValue, reward, address(0), true);
        }
        erc20Contract.transferFrom(msg.sender, deadAddress, betValue);
    }

    function concludeGame(string memory gameRoomId) public {  
        
   }
}       