
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

func test_JSONSerialization() {

    let jsBlockerRules = [[
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

    let jsBlockerRulesJSON = """
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

    let JSONData = try! JSONSerialization.data(withJSONObject: jsBlockerRules, options: .prettyPrinted)
    let received = JSONData.stringUTF8!
    let expected = jsBlockerRulesJSON
    dump( received == expected )

}
