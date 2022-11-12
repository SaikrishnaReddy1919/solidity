const { network, ethers } = require('hardhat')
const { developmentChains, networkConfig } = require('../helper-hardhat-config')
const { verify } = require('../utils/verify')

module.exports = async function ({ getNamedAccounts, deployments }) {
  console.log('---------- Deploying contract : Loyality token... ------------')
  const { deploy, log } = deployments
  const { deployer } = await getNamedAccounts()
  const chainId = network.config.chainId
  const initialSupply = 50000000

  const args = [initialSupply]
  const LoyalityTokenContract = await deploy('LoyalityToken', {
    from: deployer,
    args: args,
    log: true,
    waitConfirmations: network.config.blockConfirmations || 1,
  })

  //contract verififcation only on testnets but not localchains.
  if (
    !developmentChains.includes(network.name) &&
    process.env.ETHERSCAN_API_KEY
  ) {
    log('verifying contract on etherscan...')
    await verify(LoyalityTokenContract.address, args)
  }
  log('---------------------------------')
}

module.exports.tags = ['all', 'token']
