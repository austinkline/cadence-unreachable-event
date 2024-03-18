import Test

access(all)let Account0x7 = Address(0x0000000000000007)

access(all) fun setup() {
    deploy("Foo", "../contracts/Foo.cdc", [])
}

access(all) fun deploy(_ name: String, _ path: String, _ arguments: [AnyStruct]) {
    let err = Test.deployContract(name: name, path: path, arguments: arguments)
    Test.expect(err, Test.beNil()) 
}

access(all) fun testFoo_Run() {
    txExecutor("run.cdc", [Test.getAccount(Account0x7)], [0.0])
    txExecutor("run.cdc", [Test.getAccount(Account0x7)], [1.0])
}

access(all) fun loadCode(_ fileName: String, _ baseDirectory: String): String {
    return Test.readFile("../".concat(baseDirectory).concat("/").concat(fileName))
}

access(all) fun txExecutor(_ txName: String, _ signers: [Test.TestAccount], _ arguments: [AnyStruct]): Test.TransactionResult {
    let txCode = loadCode(txName, "transactions")

    let authorizers: [Address] = []
    for signer in signers {
        authorizers.append(signer.address)
    }

    let tx = Test.Transaction(
        code: txCode,
        authorizers: authorizers,
        signers: signers,
        arguments: arguments,
    )

    let txResult = Test.executeTransaction(tx)
    return txResult
}