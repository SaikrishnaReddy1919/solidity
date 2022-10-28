require("@nomicfoundation/hardhat-toolbox")
require("dotenv").config()
require("@nomiclabs/hardhat-etherscan")
require("./tasks/block-number")
require("hardhat-gas-reporter")
require("solidity-coverage")

/** @type import('hardhat/config').HardhatUserConfig */
const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL
const GOERLI_PRIVATE_KEY = process.env.GOERLI_PRIVATE_KEY
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY

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
            chainId: 5,
        },
        // to deploy on localhost : yarn hardhat run scripts/deploy.js --network localhost
        localhost: {
            // this is not same as default hardhat network.
            url: "http://127.0.0.1:8545/",
            //accounts -> hardhat picks automatically
            chainId: 31337,
        },
    },
    solidity: "0.8.17",
    etherscan: {
        apiKey: ETHERSCAN_API_KEY,
    },
    gasReporter: {
        enabled: true, // if false -> dont generate report for gas
        outputFile: "gas-report.txt",
        noColors: true,
        currency: "USD",
        // TODO: load api key (get it from website and load here)
        // coinmarketcap: COINMARKETCAP_API_KEY, // -> to get prices of eth
        // token: "MATIC", //-> if deployed on polygon chain
    },
}
