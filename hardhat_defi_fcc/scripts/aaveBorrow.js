const { getNamedAccounts, ethers } = require("hardhat")
const { getWeth, AMOUNT } = require("./getWeth")

async function main() {
    await getWeth()
    const { deployer } = await getNamedAccounts()
    // AAVE contract interaction
    //abi, address
    // lending pool addres provider : 0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5
    // lending pool abi :
    const lendingPool = await getLendingPool(deployer)
    console.log(`Lending pool address : ${lendingPool.address}`)

    //deposit -> means lending pool transfers token from our wallet to contract.
    // So to do this, first we need approve our token amount then only lending pool cal call safeTransferfrom
    //comment approveErC20() function line to see the error
    const wethTokenAddress = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
    //approve
    await approveERC20(wethTokenAddress, lendingPool.address, AMOUNT, deployer)
    console.log("Depositing...")
    await lendingPool.deposit(wethTokenAddress, AMOUNT, deployer, 0)
    console.log("Deposited...")
}

async function approveERC20(contractAdd, spenderAdd, amountToSpend, account) {
    const erc20Token = await ethers.getContractAt("IERC20", contractAdd, account)

    const tx = await erc20Token.approve(spenderAdd, amountToSpend)
    await tx.wait(1)
    console.log("Approved!")
}

async function getLendingPool(account) {
    const LendingPoolAddressesProvider = await ethers.getContractAt(
        "ILendingPoolAddressesProvider",
        "0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5",
        account
    )
    const lendingPoolAddress = await LendingPoolAddressesProvider.getLendingPool()
    const lendingPool = await ethers.getContractAt("ILendingPool", lendingPoolAddress, account)
    return lendingPool
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error)
        process.exit(1)
    })
