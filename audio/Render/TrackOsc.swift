
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import AVFoundation

struct TrackOsc {

    typealias NoteIndex = Int

    static let CUT_OFF_TIME: Tertia = 5

    var cols: UInt8
    var rows: UInt8
    var sample: AVAudioPCMBuffer
    var notes: [
        Note
    ] = []

    @inlinable public var width: Tertia {
        get {
            var result: Tertia = 0
            for note in self.notes {
                result = max(
                    result, note.timeStart + note.length
                )
            }
            return result
        }
    }

    func clustersGet() -> [[Note]] {
        var result: [[Note]] = []
        var buffer: [ Note ] = []
        for note in self.notes {
            if (buffer.isEmpty == true                                          ) {                                     buffer.append(note); continue }
            if (buffer.isEmpty != true && note.timeStart == buffer.last!.timeEnd) {                                     buffer.append(note); continue }
            if (buffer.isEmpty != true && note.timeStart != buffer.last!.timeEnd) { result.append(buffer); buffer = []; buffer.append(note); continue }
        }
        if (buffer.count > 0) {
            result.append(buffer)
        }
        return result
    }

    func notesOscSelect() -> [Note] {
        return self.notes
    }

    mutating func noteOscInsert(time: Tertia, stateFX: StateFX) {
        /* pulling the length to the edge of the new note */
        if let last = self.notes.last {
            if (last.timeStart ... last.timeEnd + Self.CUT_OFF_TIME).contains(time) {
                let length = time - last.timeStart
                self.notes.last!.length = length
            }
        }
        /* note: insert */
        self.notes.append(
            Note(
                timeStart: time,
                length   : Note.MIN_LENGTH,
                levelX   : stateFX.levelX,
                levelY   : stateFX.levelY,
                stateFX  : StateFX(from: stateFX)
            )
        )
    }

    mutating func noteOscUpdate(time: Tertia) {
        if let last = self.notes.last {
            if (last.timeStart...).contains(time) {
                let length = time - last.timeStart
                self.notes.last?.length = length
            }
        }
    }

    func render() throws -> AVAudioPCMBuffer {
        return try TrackOscRenderer.render(
            track : self,
            sample: self.sample
        )!
    }

}
