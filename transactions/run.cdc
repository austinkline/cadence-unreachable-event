import "Foo"

transaction(num: UFix64) {
    prepare(acct: &Account) {
        Foo.Run(num: num)
    }
}