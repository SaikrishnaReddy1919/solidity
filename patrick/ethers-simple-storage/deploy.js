const ethers = require('ethers')
const fs = require('fs-extra')
require('dotenv').config()

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL)
  const wallet = new ethers.Wallet(
    process.env.PRIVATE_KEY,
    provider,
  )

  const abi = fs.readFileSync('./SimpleStorage_sol_SimpleStorage.abi', 'utf8')
  const bin = fs.readFileSync('./SimpleStorage_sol_SimpleStorage.bin', 'utf8')

  const contractFactory = new ethers.ContractFactory(abi, bin, wallet)
  console.log('Deploying, please wait...')
  const contract = await contractFactory.deploy()
  const transactionReceipt = await contract.deployTransaction.wait(1)

  // contract.deployTransaction -> transaction response
  // transactionReceipt -> txn receipt when waited for block/txn confirmation.
  // console.log('Deployment txn :', contract.deployTransaction)
  // console.log('-----------*-----------')
  // console.log('Txn receipt : ', transactionReceipt)

  //sending raw transaction
  //   console.log("Let's deploy with only txn data!")
  //   const nonce = await wallet.getTransactionCount()

  //   const tx = {
  //     nonce: nonce,
  //     gasPrice: 20000000000,
  //     gasLimit: 1000000,
  //     to: null,
  //     value: 0,
  //     data:
  //       '<paste_contract_bin_here>',
  //     chainId: 1337,
  //   }
  //   const sentTxResponse = await wallet.sendTransaction(tx)
  //   await sentTxResponse.wait(1)
  //   console.log(sentTxResponse)

  const currentFavouriteNumber = await contract.retrieve()
  console.log(`Current Fav Number : ${currentFavouriteNumber.toString()}`)
  const txnResponse = await contract.store("1000")
  const txnReceipt = await txnResponse.wait(1)
  const updatedFavNumber = await contract.retrieve()
  console.log(`Updated Fav Number : ${updatedFavNumber.toString()}`)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error)
  })
