const { soliditySha3 } = require("web3-utils");
const { equal } = require("assert");
const rewarder= artifacts.require("TrackRewarder");


let timestamp;
const addr= "0x52cb68556dcD235153eA6ED31270dbb3F0F19daB";
contract( 'TrackRewarder',(accounts) => {
    it('should return track metadata given uploader address',async ()=>{
        timestamp= await web3.eth.getBlock("latest").timestamp;
        const rewardInstance=await rewarder.deployed();
        const metadata=(await rewardInstance.addTrack(addr));
        const toEqual= soliditySha3 (timestamp ,addr);
        assert.equal(metadata,equal,"should return metadata");
    });    
        

    });

