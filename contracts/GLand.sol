pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GLand is ERC20 {
    constructor(uint256 initialSupply) ERC20("GLand", "GLC") {
        _mint(msg.sender, initialSupply);
    }
}