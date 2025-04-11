
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

struct TestObject: Codable {

    struct TestNestedObject: Codable {
        let property: String
    }

    let keyInt      : Int
    let keyIntOpt   : Int?
    let keyDouble   : Double
    let keyDoubleOpt: Double?
    let keyString   : String
    let keyStringOpt: String?
    let keyBool     : Bool
    let keyBoolOpt  : Bool?
    let keyArray    : [Int]
    let keyArrayOpt : [Int]?
    let keyObject   : TestNestedObject
    let keyObjectOpt: TestNestedObject?

    enum CodingKeys: String, CodingKey {
        case keyInt       = "key_int"
        case keyIntOpt    = "key_int_opt"
        case keyDouble    = "key_double"
        case keyDoubleOpt = "key_double_opt"
        case keyString    = "key_string"
        case keyStringOpt = "key_string_opt"
        case keyBool      = "key_bool"
        case keyBoolOpt   = "key_bool_opt"
        case keyArray     = "key_array"
        case keyArrayOpt  = "key_array_opt"
        case keyObject    = "key_object"
        case keyObjectOpt = "key_object_opt"
    }

}
