// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.9;

enum Category {
    Supermarket,
    Restaurant,
    Education,
    Utility
}

contract Mirano is ERC20 {
    // Approved spending categories for a user
    mapping(address => Category[]) approvedCategories;

    // Balance for a user
    mapping(address => uint256) balances;

    function setApprovedCategories(
        address addr,
        Category[] storage categoriesToApprove
    ) private {
        // _setApprovedCategories(addr, approvedCategories, categoriesToAdd);
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
    }

    function sendForSavings(
        address addr,
        uint256 amount,
        uint256 withdrawalAllowedTime
    ) {}

    function depositToLendingPool(uint256 amount) private {
        // After deposit msg.sender receives the aToken
        // IWETHGateway(wethGatewayAddr).depositETH{value: amount}(
        //     poolAddr,
        //     address(this),
        //     0
        // );
    }

    function withdrawFromLendingPool(uint256 amount, address to) private {
        // calling contract should have enough credit limit
        // IAToken(ATokenAddress).approve(wethGatewayAddr, amount);
        // Withdrawn amount will be send to to address
        // IWETHGateway(wethGatewayAddr).withdrawETH(poolAddr, amount, to);
    }
}
