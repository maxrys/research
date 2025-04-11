
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

func test_JSONSerialization() {

    let JSONObject = [[
        "action": [
            "type": "block"
        ],
        "trigger": [
            "url-filter": ".*",
            "url-filter-is-case-sensitivity": true,
            "resource-type": ["script"],
            "unless-domain": [
                "example.com",
                "example.net",
                "example.org",
            ]
        ]
    ]]

    let JSONString = """
    [
      {
        "action" : {
          "type" : "block"
        },
        "trigger" : {
          "url-filter" : ".*",
          "url-filter-is-case-sensitivity" : true,
          "resource-type" : [
            "script"
          ],
          "unless-domain" : [
            "example.com",
            "example.net",
            "example.org"
          ]
        }
      }
    ]
    """

    let JSONData = try! JSONSerialization.data(withJSONObject: JSONObject, options: .prettyPrinted)
    let received = JSONData.stringUTF8!
    let expected = JSONString
    dump( received == expected )

}
