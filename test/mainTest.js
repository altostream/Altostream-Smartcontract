const { sha3_256 } = require("js-sha3");
const { equal } = require("assert");

const rewarder= artifacts.require("TrackRewarder");
const truffleAssert = require('truffle-assertions');
const assert = require("chai").assert;


let timestamp;
let blockNum;
let block;
const addr= "0x52cb68556dcD235153eA6ED31270dbb3F0F19daB";
contract( 'TrackRewarder',(accounts) => {
    it('should return track metadata given uploader address',async ()=>{
        blockNum= await web3.eth.getBlockNumber();
        block= await web3.eth.getBlock(blockNum);
        timestamp= block['timestamp'];
        var hash = web3.utils.soliditySha3({type: 'uint', value: timestamp}, {type: 'address', value: addr });
        const rewardInstance=await rewarder.deployed();
        const metadata=await rewardInstance.addTrack(addr);

        truffleAssert.eventEmitted(metadata, 'trackAdded', (ev)=>{
            return ev.uploader === addr && ev.songMeta=== hash;
        });

    });    
     

    });

