
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

struct Track {

    var cols: UInt8
    var rows: UInt8
    var samples: Matrix<AVAudioPCMBuffer>
    var notes: [
        Level: /* levelX */ [
            Level: /* levelY */ [
                UInt: Note
            ]
        ]
    ] = [:]

    @inlinable public var width: Tertia {
        get {
            var result: Tertia = 0
            for (_, notesByLevelX) in self.notes {
                for (_, notesByLevelY) in notesByLevelX {
                    for (_, note) in notesByLevelY {
                        result = max(
                            result, note.timeStart + note.length
                        )
                    }
                }
            }
            return result
        }
    }

    func notesSelect() -> [Note] {
        var result: [Note] = []
        for (_, notesByLevelX) in self.notes {
            for (_, notesByLevelY) in notesByLevelX {
                for (_, note) in notesByLevelY {
                    result.append(note)
                }
            }
        }
        return result.sorted(by: { (lhs, rhs) in
            lhs.timeStart < rhs.timeStart
        })
    }

    mutating func noteInsert(levelX: Level, levelY: Level, time: Tertia, length: UInt32) {
        /* insert dimension if not existing */
        if (self.notes[levelX]          == nil) { self.notes[levelX]          = [:] }
        if (self.notes[levelX]![levelY] == nil) { self.notes[levelX]![levelY] = [:] }
        /* overlap checks  */
        let noteTimeRange = time ... time + length
        for (index, note) in self.notes[levelX]![levelY]! {
            if (noteTimeRange.contains(note.timeStart)) {
                self.notes[levelX]![levelY]![index] = nil
            }
        }
        /* insert new note */
        self.notes[levelX]![levelY]!.append(
            Note(
                timeStart: time,
                length   : length,
                levelX   : levelX,
                levelY   : levelY
            )
        )
    }

    func render() throws -> AVAudioPCMBuffer {
        return try TrackRenderer.render(
            track  : self,
            samples: samples
        )!
    }

}
