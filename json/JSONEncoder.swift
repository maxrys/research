
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

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

func test_JSONEncoder_AnyObject() {

    struct Rules: Codable {
        struct Trigger: Codable {
            var urlFilter = ".*"
            var urlFilterIsCaseSensitivity = true
            var resourceType = ["script"]
            var unlessDomain: [String]
        }
        var action = ["type": "block"]
        var trigger: Trigger
        init(unlessDomain: [String] = []) {
            self.trigger = Trigger(
                unlessDomain: unlessDomain
            )
        }
    }

    let JSONObject = Rules(unlessDomain: [
        "example.com",
        "example.net",
        "example.org",
    ])

    let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
    let JSONData = try! encoder.encode(JSONObject)

    dump(JSONData.stringUTF8)

}
