
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation
import AVFoundation

final class ModelSamples {

    static private let PROPERTY_SOURCE = "samples"
    static private var cachePropertyListData: NSDictionary?
    static private var cacheSourceData: [
        String: AVAudioPCMBuffer
    ] = [:]

    static private func propertyListDataGet() -> NSDictionary {
        if let cache = cachePropertyListData { return cache }
        let cache = PropertyListSerialization.dataGet(fileName: PROPERTY_SOURCE) as! NSDictionary
        cachePropertyListData = cache
        return cache
    }

    static private func sourceDataGet(sourceName: String, sourceType: String) -> AVAudioPCMBuffer {
        let source = "\(sourceName).\(sourceType)"
        if let cache = cacheSourceData[source] { return cache }
        let cache = try! AVAudioPCMBuffer(file:
            try! AVAudioFile(forReading:
                Bundle.main.url(
                    forResource  : sourceName,
                    withExtension: sourceType
            )!)
        )!
        cacheSourceData[source] = cache
        return cache
    }

    static func select(sampleID: String) -> [String: AVAudioPCMBuffer] {
        var result: [
            String: AVAudioPCMBuffer
        ] = [:]

        let samples = propertyListDataGet()
        let sample = samples[sampleID] as! NSDictionary
        let sampleSourceName = sample["sourceName"] as! String
        let sampleSourceType = sample["sourceType"] as! String
        let sampleSourceData = sourceDataGet(
            sourceName: sampleSourceName,
            sourceType: sampleSourceType
        )

        for segment in sample["segments"] as! NSDictionary {
            let segmentID = segment.key as! String
            let info = segment.value as! NSDictionary
            let segmentFrom = info["from"] as! UInt64
            let segmentSize = info["size"] as! UInt64
            let segmentData = sampleSourceData.segmentGet(
                from: segmentFrom,
                size: segmentSize
            )
            result[segmentID] = segmentData
        }

        return result
    }

}
