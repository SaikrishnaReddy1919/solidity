// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.

//run -> allows us to run any task
const { ethers, run, network } = require("hardhat")

async function main() {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    )

    console.log("Deploying, please wait....")
    //--------- Deploying Contract ---------
    const simpleStorage = await SimpleStorageFactory.deploy()
    await simpleStorage.deployed()

    console.log(`Deployed contract to : ${simpleStorage.address}`)
    // console.log("---------Network Info :----------")
    // console.log(network.config)

    //--------- programmatically verify contract on etherscan ---------
    if (network.config.chainId === 5 && process.env.ETHERSCAN_API_KEY) {
        console.log("Waiting for blocks(6) confirmations...")
        await simpleStorage.deployTransaction.wait(6) // wait for 6 blocks
        await verify(simpleStorage.address, [])
    }

    //retrieve current value.
    const currentValue = await simpleStorage.retrieve()
    console.log(`Current value is : ${currentValue}`)

    //update current value
    const txnResponse = await simpleStorage.store(1000)
    await txnResponse.wait(1)
    const updatedValue = await simpleStorage.retrieve()
    console.log(`Updated value is : ${updatedValue}`)
}

async function verify(contractAddress, args) {
    //args -> if contract has any args in constructor
    console.log("Verifying contract...")
    try {
        await run("verify:verify", {
            address: contractAddress,
            constructorArguments: args,
        })
    } catch (error) {
        if (e.message.toLowerCase().includes("already verified")) {
            console.log("Already verified.")
        } else {
            console.log("Error while verifying : ", e)
        }
    }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error)
    process.exitCode = 1
})
