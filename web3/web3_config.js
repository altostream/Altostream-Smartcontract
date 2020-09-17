const Web3 = require("web3");
require("dotenv").config();

const provider = new Web3.providers.HttpProvider(process.env.BLOCKCHAINSERVER);
const web3 = new Web3(provider);
const main = process.env.MAINCONTRACT;
const token = process.env.TOKENCONTRACT;
const paymaster = process.env.PAYMASTERCONTRACT;
const relayHub = process.env.RELAYHUBCONTRACT;
const forwarder = process.env.FORWARDERCONTRACT;

const mainAbi = "../build/contracts/ALTOSTREAM.json";
const tokenAbi = "../build/contracts/ERC20Interface.json";
const paymasterAbi = "../build/contracts/NaivePaymaster.json";
const relayHubAbi = "../build/contracts/BaseRelayRecipient.json";
const forwarderAbi = "../build/contracts/IKnowForwarderAddress.json";

const mainContract = new web3.eth.Contract(main, mainAbi);
const tokenContract = new web3.eth.Contract(token, tokenAbi);
const paymasterContract = new web3.eth.Contract(paymaster, paymasterAbi);
const relayHubContract = new web3.eth.Contract(relayHub, relayHubAbi);
const forwarderContract = new web3.eth.Contract(forwarder, forwarderAbi);

module.exports = {
    web3,
    main,
    token,
    paymaster,
    relayHub,
    forwarder,
    mainAbi,
    tokenAbi,
    paymasterAbi,
    relayHubAbi,
    forwarderAbi,
    mainContract,
    tokenContract,
    paymasterContract,
    relayHubContract,
    forwarderContract
}