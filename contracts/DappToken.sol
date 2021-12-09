// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

contract	DappToken {
	// Constructor
	// Set the value of tokens we have
	// Read the total of tokens got
	uint256 public totalSupply;

	constructor () {
		totalSupply = 1000000;
	}
}