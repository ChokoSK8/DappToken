// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;

import "./Ownable.sol";

contract	DappToken is Ownable {
	string public name = "Dapp Token";
	string public symbol = "DAPP";
	string public standard = "DApp Token v1.0";
	uint256 public totalSupply;

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);

	mapping (address => uint256) public balanceOf;
	mapping (address => mapping (address => uint256)) public allowance;


	constructor (uint256 _initialSupply) Ownable() {
		totalSupply = _initialSupply;
		balanceOf[msg.sender] = totalSupply;
	}

	function transfer(address _to, uint256 _value) public returns (bool) {
		require(balanceOf[msg.sender] >= _value);
		balanceOf[_to] += _value;
		balanceOf[msg.sender] -= _value;
		emit Transfer(msg.sender, _to, _value);
		return (true);
	}

	function approve(address _spender, uint256 _value) public override onlyOwner returns (bool) {
		require (_spender != address(0));
		require (balanceOf[msg.sender] >= _value);
		allowance[msg.sender][_spender] = 0;
		allowance[msg.sender][_spender] = _value;
		emit Approval(msg.sender, _spender, _value);
		return (true);
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
		require(msg.sender == _from || allowance[msg.sender][_from] > 0);
		require(balanceOf[_from] >= _value);
		emit Transfer(_from, _to, _value);
		balanceOf[_from] -= _value;
		balanceOf[_to] += value;
		return (true);
	}






















}