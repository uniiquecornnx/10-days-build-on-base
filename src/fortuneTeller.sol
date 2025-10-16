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
    function getFortune(string calldata date) external view returns (string memory) {
        bytes memory b = bytes(date);
        uint sum = 0;
        bool hasDigit = false;

        // Sum numeric characters directly (no temp array)
        for (uint i = 0; i < b.length; i++) {
            bytes1 c = b[i];
            if (c >= 0x30 && c <= 0x39) {
                hasDigit = true;
                sum += uint8(c) - 48; // '0' = 48
            }
        }

        require(hasDigit, "Invalid date string");
        require(fortunes.length > 0, "No fortunes configured");

        // Reduce to a single digit (numerology style)
        while (sum >= 10) {
            uint tmp = 0;
            uint x = sum;
            while (x != 0) {
                tmp += x % 10;
                x /= 10;
            }
            sum = tmp;
        }

        // Map 0..9 to a safe index 0..fortunes.length-1
        // Keep your special-case behavior: 0 -> last fortune.
        uint idx = (sum == 0)
            ? fortunes.length - 1
            : (sum - 1) % fortunes.length;

        return fortunes[idx];
    }

    function fortuneCount() external view returns (uint256) {
        return fortunes.length;
    }
}
