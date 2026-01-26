
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

func test_JSONSerialization() {

    let JSONObject: [String : Any?] = [
        "keyInt"      : 1,
        "keyIntOpt"   : nil,
        "keyDouble"   : 2.345,
        "keyDoubleOpt": nil,
        "keyString"   : "string value",
        "keyStringOpt": nil,
        "keyBool"     : true,
        "keyBoolOpt"  : nil,
        "keyArray"    : [7, 8, 9],
        "keyArrayOpt" : nil
    ]

    let JSONData = try! JSONSerialization.data(
        withJSONObject: JSONObject,
        options: .prettyPrinted
    )

    dump(JSONData.stringUTF8!)

}
