// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "./integrations/swivel/Interfaces.sol";
import "./integrations/swivel/Hash.sol";
import "./integrations/swivel/Swivel.sol";

enum Category {
    Supermarket,
    Restaurant,
    Education,
    Utility
}

contract Mirano is ERC20 {
    Swivel swivel;

    function Existing(address _t) public {
        swivel = Swivel(_t);
    }

    constructor() ERC20("MRO", "MRO") {}

    // Approved spending categories for a user
    mapping(address => Category[]) approvedCategories;

    mapping(address => uint256) balances;

    // Swivel Polygon Mumbai testnet contract: 0xA772F08a5B11d85eB2a95F6c923b86AF1a8fb614

    function setApprovedCategories(
        address addr,
        Category[] calldata categoriesToApprove
    ) private {
        approvedCategories[addr] = categoriesToApprove;
    }

    function getApprovedCategories(address addr)
        private
        returns (Category[] storage)
    {
        return approvedCategories[addr];
    }

    function sendWithApprovedCategories(
        address addr,
        Category[] calldata categoriesToApprove
    ) public payable {
        setApprovedCategories(addr, categoriesToApprove);
        ERC20.transfer(addr, msg.value);
    }

    function sendForSavings(
        address addr,
        uint256 amount,
        uint256 withdrawalAllowedTime
    ) public {
        Hash.Order[] memory orders = new Hash.Order[](1);

        orders[0].maker = addr;

        // TST token on Polygon mumbai testnet
        orders[0].underlying = 0x2d7882beDcbfDDce29Ba99965dd3cdF7fcB10A1e; // address of ERC20 token
        orders[0].vault = true;
        orders[0].exit = false;
        orders[0].principal = 0;
        orders[0].premium = amount;
        orders[0].maturity = 0; // The maturity date of the market in seconds since epoch.
        orders[0].expiry = block.timestamp; // Timestamp marking this order's expiration

        // Swivel Polygon Mumbai testnet contract
        address contractAddress = 0xA772F08a5B11d85eB2a95F6c923b86AF1a8fb614;
        bytes32 eip712 = Hash.domain(
            "Swivel Finance",
            "2.0.0",
            80001,
            contractAddress
        );

        uint256[] memory boop = new uint256[](1);
        Sig.Components[] memory c = new Sig.Components[](1);

        swivel.initiate(orders, boop, c);
    }
}
