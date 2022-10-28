require("@nomicfoundation/hardhat-toolbox")
require("dotenv").config()

/** @type import('hardhat/config').HardhatUserConfig */
const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL
const GOERLI_PRIVATE_KEY = process.env.GOERLI_PRIVATE_KEY

module.exports = {
    //anytime we run 'yarn hardhat run .." without specifying the network here, hardhat defualts the network to 'hardhat" and adds below property.
    // and this fake/default hardhat network has fake private key and rpc url.

    // if you have diff netoworks and wants to specify the network, then use :
    // yarn hardhat run scripts/deploy.js --network hardhat/goreli/...
    defaultNetwork: "hardhat",
    networks: {
        goerli: {
            url: GOERLI_RPC_URL,
            accounts: [GOERLI_PRIVATE_KEY],
        },
    },
    solidity: "0.8.17",
}
