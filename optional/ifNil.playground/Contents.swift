
import Foundation

extension Optional {

    func ifNil<T>(
        defaultValue: T,
        _ ifNotNilClosure: (Wrapped) -> T
    ) -> T {
        switch self {
            case .some(let unwrappedValue): return ifNotNilClosure(unwrappedValue)
            case .none                    : return defaultValue
        }
    }

}

var value1: String? = "string"
var value2: String? = nil

let resultValue1 = value1.ifNil (defaultValue: "default") { unwrappedValue in unwrappedValue + " suffix" }
let resultValue2 = value2.ifNil (defaultValue: "default") { unwrappedValue in unwrappedValue + " suffix" }

dump(resultValue1)
dump(resultValue2)
