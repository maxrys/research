
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation

final class ModelDemo {

    static private let PROPERTY_SOURCE = "demo"
    static private var cachePropertyListData: NSDictionary?

    static private func propertyListDataGet() -> NSDictionary {
        if let cache = Self.cachePropertyListData { return cache }
        let cache = PropertyListSerialization.dataGet(fileName: Self.PROPERTY_SOURCE) as! NSDictionary
        Self.cachePropertyListData = cache
        return cache
    }

    static func select() -> [String: Any] {
        var result: [
            String: Any
        ] = [:]

        let data = propertyListDataGet()

        var bufferArray: [String] = []
        for value in data["array"] as! Array<String> {
            bufferArray.append(value)
        }

        var bufferDictionary: [String: String] = [:]
        for (key, value) in data["dictionary"] as! NSDictionary {
            bufferDictionary[key as! String] = value as? String
        }

        result["string"]     = data["string"] as! String
        result["int"]        = data["number"] as! Int
        result["double"]     = data["number"] as! Double
        result["bool"]       = data["bool"]   as! Bool
        result["date"]       = data["date"]   as! Date
        result["data"]       = data["data"]   as! Data
        result["array"]      = bufferArray
        result["dictionary"] = bufferDictionary

        return result
    }

}
