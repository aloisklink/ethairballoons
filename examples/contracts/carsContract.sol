pragma solidity ^0.6.1;
pragma experimental ABIEncoderV2;
contract carsContract {
	uint public dataId;

	event dataAdded(string dat);

	constructor() public{
		dataId = 0;
	}

	struct Car{
		string payload;
		uint timestamp;
	}


	mapping(uint => Car) public facts;

	function addRecord(string memory payload) public returns (string memory, uint ID){
		facts[dataId].payload= payload;
		facts[dataId].timestamp = now;
 		dataId += 1;
		return (facts[dataId-1].payload,dataId -1);
	}

	function getRecord(uint id) public view returns (string memory payload, uint timestamp){
		return (facts[id].payload, facts[id].timestamp);
	}

	function getAllRecords(uint id) public view returns (string[] memory payloads, uint[] memory timestamps){
		string[] memory payloadss = new string[](id);
		uint[] memory timestampss = new uint[](id);
		for(uint i =0; i < id; i++){
			Car storage fact = facts[i];
			payloadss[i] = fact.payload;
			timestampss[i] = fact.timestamp;
		}
		return (payloadss,timestampss);
	}

	function getRecordsFromTo(uint from, uint to) public view returns (string[] memory payloadsFromTo, uint[] memory timestampsFromTo){
		string[] memory payloadss = new string[](to - from);
		uint[] memory timestampss = new uint[](to - from);
		uint j = 0;
		for(uint i = from; i < to; i++){
			Car storage fact = facts[j];
			payloadss[j] = fact.payload;
			timestampss[j] = fact.timestamp;
			j++;
		}
		return (payloadss,timestampss);
	}

	function addRecords(string[] memory payloadsss) public returns (string memory, uint IDMany){
		for(uint i =0; i < payloadsss.length; i++){
			facts[dataId].payload= payloadsss[i];
			facts[dataId].timestamp = now;
			dataId += 1;
		}
		 emit dataAdded(facts[dataId-1].payload);
		return (facts[dataId-1].payload,dataId -1);
	}

}