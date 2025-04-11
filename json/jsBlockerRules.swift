
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

let jsBlockRulesEtalone = """
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

func test_jsBlockerRules_JSONSerialization() {

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

    let JSONData = try! JSONSerialization.data(
        withJSONObject: JSONObject,
        options: .prettyPrinted
    )

    dump(JSONData.stringUTF8!)

}

func test_jsBlockerRules_JSONEncoder() {

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
