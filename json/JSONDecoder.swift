
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool { return true }
    public func hash(into hasher: inout Hasher) { hasher.combine(0) }
}

struct TestNestedObject: Codable {
    let property: String
}

struct TestObject: Codable {

    let keyInt: Int
    let keyDouble: Double
    let keyString: String
    let keyBool: Bool
    let keyNull: JSONNull?
    let keyArray: [Int]
    let keyObject: TestNestedObject

    enum CodingKeys: String, CodingKey {
        case keyInt    = "key_int"
        case keyDouble = "key_double"
        case keyString = "key_string"
        case keyBool   = "key_bool"
        case keyNull   = "key_null"
        case keyArray  = "key_array"
        case keyObject = "key_object"
    }

}

func test_JSONDecoder() {
    let JSONString = """
    {
        "key_int": 1,
        "key_double": 2.345,
        "key_string": "string value",
        "key_bool": true,
        "key_null": null,
        "key_array": [7, 8, 9],
        "key_object": {
            "property": "nested value"
        }
    }
    """
    let JSONObject: TestObject = try! JSONDecoder().decode(
        TestObject.self,
        from: JSONString.data(using: .utf8)!
    )
    dump(JSONObject)
}
