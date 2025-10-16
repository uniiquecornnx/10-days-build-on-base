// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract FortuneTeller {
    string[] private fortunes;

    constructor() {
        fortunes = [
            "Dont worry, everyone else bought the top too",
            "A missing semicolon in your code will humble you today.",
            "Not financial advice, but the stars say... HODL.",
            "Someone will fork your repo and actually fix your bug.",
            "Your hard work will soon pay off.",
            "You will declare victory, right before Stack too deep appears.",
            "You will temporarily hardcode a value and forget it forever",
            "Your RPC endpoint will ghost you like an ex.",
            "One pull request today could change your gas costs forever.",
            "Console.log is your real debugger."
        ];
    }

    /// @notice Returns a fortune message based on a date string, e.g. "1998-07-23"
    function getFortune(string memory date) external view returns (string memory) {
        bytes memory b = bytes(date);
        uint8[] memory nums = new uint8[](b.length);
        uint count = 0;

        // Convert each numeric char into an integer
        for (uint i = 0; i < b.length; i++) {
            bytes1 char = b[i];
            if (char >= 0x30 && char <= 0x39) { // '0' to '9'
                nums[count] = uint8(uint8(char) - 48);
                count++;
            }
        }

        require(count > 0, "Invalid date string");

        // Step 1: sum all digits
        uint dateSum = 0;
        for (uint i = 0; i < count; i++) {
            dateSum += nums[i];
        }

        // Step 2: reduce to single digit (like numerology)
        while (dateSum > 10) {
            uint tmp = 0;
            while (dateSum > 0) {
                tmp += dateSum % 10;
                dateSum /= 10;
            }
            dateSum = tmp;
        }

        
        uint counter = dateSum == 0 ? 9 : dateSum;

        return fortunes[counter - 1]; 
    }

    function fortuneCount() external view returns (uint256) {
        return fortunes.length;
    }
}
