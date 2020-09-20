const { web3, mainContract, main, mainAbi } = require("../web3/web3_config");

// const getTotalSupply = async (total, balance) => {
//     try {
//         const totalSupply = await web3.eth.getBalance(total);
//     } catch (error) {
        
//     }
// }

const address = "0x00C3143069C21c6549AbaB7b8352F015a3B1d0C6";

const getBalance = async () => {
    try {
        const balance = await web3.eth.getBalance(address);
        console.log(balance);
    } catch (error) {
        console.log(error);
    }
}

getBalance();