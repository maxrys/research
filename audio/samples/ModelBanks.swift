
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation
import AVFoundation

final class ModelBanks {

    struct Info {
        var title: String
        var cols: Level
        var rows: Level
        var isOscillator: Bool
        var samples: [String: SampleInfo]
    }

    struct SampleInfo {
        var levelX: Level
        var levelY: Level
        var loopMode: LoopMode
        var buffer: AVAudioPCMBuffer
    }

    static private let PROPERTY_SOURCE = "banks"
    static private var cachePropertyListData: NSDictionary?
    static private var cacheBankData: [
        String: Info
    ] = [:]

    static private func propertyListDataGet() -> NSDictionary {
        if let cache = cachePropertyListData { return cache }
        let cache = PropertyListSerialization.dataGet(fileName: PROPERTY_SOURCE) as! NSDictionary
        cachePropertyListData = cache
        return cache
    }

    static func select(bankID: String) -> Info {
        if let cache = cacheBankData[bankID] { return cache }

        let banks = propertyListDataGet()
        let bank = banks[bankID] as! NSDictionary
        let bankSamples = bank["samples"] as! NSDictionary

        var result = Info(
            title       : bank["title"       ] as! String,
            cols        : bank["cols"        ] as! Level,
            rows        : bank["rows"        ] as! Level,
            isOscillator: bank["isOscillator"] as! Bool,
            samples     : [:]
        )

        for (cellID, sample) in bankSamples as! [String: NSDictionary] {
            let sampleID        = sample[ "sampleID"] as! String
            let sampleSegmentID = sample["segmentID"] as! String
            result.samples[cellID] = SampleInfo(
                levelX  : sample["levelX"] as! Level,
                levelY  : sample["levelY"] as! Level,
                loopMode: LoopMode.fromString(value: sample["loopMode"] as! String),
                buffer  : ModelSamples.select(
                    sampleID: sampleID
                )[sampleSegmentID]!
            )
        }

        cacheBankData[bankID] = result
        return result
    }

}
