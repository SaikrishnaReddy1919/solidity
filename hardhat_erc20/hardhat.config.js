require('@nomiclabs/hardhat-waffle')
require('@nomiclabs/hardhat-etherscan')
require('hardhat-deploy')
require('solidity-coverage')
require('hardhat-gas-reporter')
require('hardhat-contract-sizer')
require('dotenv').config()

/** @type import('hardhat/config').HardhatUserConfig */

const GOERLI_RPC_URL =
  process.env.GOERLI_RPC_URL ||
  'https://eth-mainnet.alchemyapi.io/v2/your-api-key'
const GOERLI_PRIVATE_KEY =
  process.env.GOERLI_PRIVATE_KEY ||
  '0x11ee3108a03081fe260ecdc10655432098d09d9d1209bcafd46942b10e02943effc4a'
const GOERLI_PRIVATE_KEY_ACCOUNT_2 =
  process.env.GOERLI_PRIVATE_KEY_ACCOUNT_2 ||
  '0x11ee3108a03083287631fe260ecdc106554d09d9d1209bcafd46942b10e02943effc4a'
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || ''
const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY || ''

module.exports = {
  defaultNetwork: 'hardhat',
  networks: {
    hardhat: {
      chainId: 31337,
      blockConfirmations: 1,
    },
    localhost: {
      chainId: 31337,
      blockConfirmations: 1,
    },
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: [GOERLI_PRIVATE_KEY, GOERLI_PRIVATE_KEY_ACCOUNT_2],
      chainId: 5,
      blockConfirmations: 6,
      saveDeployments: true,
    },
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
    player: {
      default: 1,
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
  solidity: {
    compilers: [
      {
        version: '0.8.7',
      },
      {
        version: '0.4.24',
      },
    ],
  },
}
