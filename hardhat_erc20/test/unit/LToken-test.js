const { assert } = require('chai')
const { network, getNamedAccounts, deployments, ethers } = require('hardhat')
const { developmentChains } = require('../../helper-hardhat-config')

!developmentChains.includes(network.name)
  ? describe.skip
  : describe('LoyalityToken tests', function () {
      let loyalityTokenContract, deployer

      // for every "it", "beforeEach" runs. -> means for every "it", contract will be deployed
      beforeEach(async function () {
        accounts = await ethers.getSigners()
        deployer = (await getNamedAccounts()).deployer
        await deployments.fixture(['token']) // deploys all contracts inside deploy folder with tag "token"
        loyalityTokenContract = await ethers.getContract(
          'LoyalityToken',
          deployer,
        )
      })

      describe('constructor', function () {
        it('initializes the LoyalityToken constructor correctly : supply should be equal to 50000000', async function () {
          //ideally we make our tests have just 1 assert per "it"
          const totalSupply = await loyalityTokenContract.totalSupply()
          assert.equal(totalSupply.toString(), '50000000')
        })
        it('initializes the LoyalityToken constructor correctly : balance should be equal to 50000000', async function () {
          //ideally we make our tests have just 1 assert per "it"
          const balanceOfDeployer = await loyalityTokenContract.balanceOf(
            deployer,
          )
          assert.equal(balanceOfDeployer, '50000000')
        })
        it('initializes the LoyalityToken constructor correctly : balance of non-deployer should be 0', async function () {
          //ideally we make our tests have just 1 assert per "it"
          const balanceOfNonDeployer = await loyalityTokenContract.balanceOf(
            accounts[2].address,
          )
          assert.equal(balanceOfNonDeployer, '0')
        })
      })
    })
