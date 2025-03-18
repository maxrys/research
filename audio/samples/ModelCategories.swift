
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

final class ModelCategories {

    struct ListItem {
        var id: String
        var title: String
        var banks: [String]
    }

    static private let PROPERTY_SOURCE = "categories"
    static private var cachePropertyListData: [NSDictionary]?

    static private func propertyListDataGet() -> [NSDictionary] {
        if let cache = cachePropertyListData { return cache }
        let cache = PropertyListSerialization.dataGet(fileName: PROPERTY_SOURCE) as! [NSDictionary]
        cachePropertyListData = cache
        return cache
    }

    static func selectList() -> [ListItem] {
        var result: [ListItem] = []
        for category in propertyListDataGet() {
            result.append(ListItem(
                id   : category["id"   ] as! String,
                title: category["title"] as! String,
                banks: category["banks"] as! Array
            ))
        }
        return result
    }

}
