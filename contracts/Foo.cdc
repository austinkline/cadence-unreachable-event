access(all) contract Foo {
    access(all) event MyEvent(field1: String?)

    access(all) fun Run(num: UFix64) {
        emit MyEvent(
            field1: num != 0.0 ? "lorum ipsum" : nil
        )
    }
}