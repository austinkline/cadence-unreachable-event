access(all) contract Foo {
    access(all) event MyEvent(field1: Address?)

    access(self) let b: @Bar

    access(all) struct Baz {
        access(all) let addr: Address

        init(addr: Address) {
            self.addr = addr
        }
    }

    access(all) resource Bar {
        access(all) let baz: Baz?

        init(b: Baz?) {
            self.baz = b
        }
    }

    access(all) fun Run(num: UFix64) {
        emit MyEvent(
            field1: num != 0.0 ? self.b.baz!.addr : nil
        )
    }

    access(all) init() {
        self.b <- create Bar(b: Baz(addr:self.account.address))
    }
}