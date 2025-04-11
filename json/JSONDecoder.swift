
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

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
