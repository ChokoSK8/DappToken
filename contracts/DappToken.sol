// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

contract	DappToken {
	uint256 public totalSupply;
	mapping (address => uint256) public balanceOf;

	constructor (uint256 _initialSupply) {
		totalSupply = _initialSupply;
		balanceOf[msg.sender] = totalSupply;
	}

	function _balanceOf(address _owner) public view returns (uint256) {
		return balanceOf[_owner];
	}
}