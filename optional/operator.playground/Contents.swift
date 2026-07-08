
import Foundation

infix operator ?! : TernaryPrecedence

func ?! <T>(
    lhs: T?,
    rhs: (default: T, else: (T) -> T),
) -> T {
    switch lhs {
        case .some(let v): return rhs.else(v)
        case .none:        return rhs.default
    }
}

var value1: String? = "string"
var value2: String? = nil

let resultValue1 = value1 ?! (default: "default", else: { wrappedValue in wrappedValue + " suffix" })
let resultValue2 = value2 ?! (default: "default", else: { wrappedValue in wrappedValue + " suffix" })

dump(resultValue1)
dump(resultValue2)
