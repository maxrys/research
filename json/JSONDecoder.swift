
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

func test_JSONEncoder() {

    let JSONObject = TestObject(
        keyInt      : 1,
        keyIntOpt   : nil,
        keyDouble   : 2.345,
        keyDoubleOpt: nil,
        keyString   : "string value",
        keyStringOpt: nil,
        keyBool     : true,
        keyBoolOpt  : nil,
        keyArray    : [7, 8, 9],
        keyArrayOpt : nil,
        keyObject   : TestObject.TestNestedObject(property: "nested value"),
        keyObjectOpt: nil
    )

    let JSONData = try! JSONEncoder().encode(JSONObject)

    dump(JSONData.stringUTF8)

}

func test_JSONDecoder() {

    let JSONString = """
    {
        "key_int": 1,
        "key_int_opt": null,
        "key_double": 2.345,
        "key_double_opt": null,
        "key_string": "string value",
        "key_string_opt": null,
        "key_bool": true,
        "key_bool_opt": null,
        "key_array": [7, 8, 9],
        "key_array_opt": null,
        "key_object": { "property": "nested value" },
        "key_object_opt": null,
        "key_unknown": null
    }
    """

    let JSONObject: TestObject = try! JSONDecoder().decode(
        TestObject.self,
        from: JSONString.data(using: .utf8)!
    )

    dump(JSONObject)

}
