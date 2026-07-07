
import Foundation

extension String {

    func trimPrefix(_ prefix: String) -> String {
        self.hasPrefix(prefix) ? String(self.dropFirst(prefix.count)) : self
    }

}

extension Optional {

    func ifNotNil<T>(
        _ ifNotNilClosure: (Wrapped) -> T,
        else ifNilValue: T
    ) -> T {
        switch self {
            case .some(let value): return ifNotNilClosure(value)
            case .none           : return ifNilValue
        }
    }

}

var value = "somePrefix:someValue"
var prefix1: String? = "somePrefix"
var prefix2: String? = nil

let resultValue1 = prefix1.ifNotNil({ prefix in value.trimPrefix(prefix) }, else: value)
let resultValue2 = prefix2.ifNotNil({ prefix in value.trimPrefix(prefix) }, else: value)

dump(resultValue1)
dump(resultValue2)
