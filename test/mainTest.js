const {accounts,contract} =require('@openzeppelin/test-environment');
const {expect} = require ('chai');
const truffleAssert=require('truffle-assertions');

let timestamp;
let blockNumber;
let meta;

const alto=contract.fromArtifact('TrackRewarder');

blockNumber=web3.eth.blockNumber;
timestamp=web3.eth.getBlock(blockNumber).timestamp;

describe('alto',function(){
    const [owner]=accounts;

    beforeEach(async function(){
        this.contract=await alto.new({from: owner});
    });

it("accepts address and emits the meta of the song based on block timestamp",async function(){
    let tx=await alto.addTrack("0xF3a57FAbea6e198403864640061E3abc168cee80");
    meta=web3.utils.keccak256(timestamp,"0xF3a57FAbea6e198403864640061E3abc168cee80");
    truffleAssert.eventEmitted("0xF3a57FAbea6e198403864640061E3abc168cee80", meta,(ev) => {
        return meta === tx;
    });
    

    

})

});