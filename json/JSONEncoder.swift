
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
