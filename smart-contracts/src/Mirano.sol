// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.9;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "./integrations/swivel/Interfaces.sol";
import "./integrations/swivel/Hash.sol";

enum Category {
    Supermarket,
    Restaurant,
    Education,
    Utility
}

contract Mirano {
    // Approved spending categories for a user
    mapping(address => Category[]) approvedCategories;

    mapping(address => uint256) balances;

    // Swivel Polygon Mumbai testnet contract: 0xA772F08a5B11d85eB2a95F6c923b86AF1a8fb614

    function setApprovedCategories(
        address addr,
        Category[] storage categoriesToApprove
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
        Category[] storage categoriesToApprove
    ) public payable {
        setApprovedCategories(addr, categoriesToApprove);
        ERC20.transfer(addr, msg.value);
    }

    function sendForSavings(
        address addr,
        uint256 amount,
        uint256 withdrawalAllowedTime
    ) {
        // initialize an empty order struct and then update it
        Hash.Order memory order;
        order.maker = addr;

        // TST token on Polygon mumbai testnet
        order.underlying = "0x2d7882beDcbfDDce29Ba99965dd3cdF7fcB10A1e"; // address of ERC20 token
        order.vault = true;
        order.exit = false;
        order.principal = 0;
        order.premium = amount;
        order.maturity = 0; // The maturity date of the market in seconds since epoch.
        order.expiry = block.timestamp; // Timestamp marking this order's expiration

        // Swivel Polygon Mumbai testnet contract
        address contractAddress = 0xA772F08a5B11d85eB2a95F6c923b86AF1a8fb614;
        bytes32 eip712 = Hash.domain(
            Swivel.NAME,
            Swivel.VERSION,
            80001,
            contractAddress
        );

        Swivel.initiate(Hash.Order[order], 0, 0);
    }
}
