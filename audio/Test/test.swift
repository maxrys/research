
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Testing
import AVFoundation

let ETALONE_FILE_URL        = Bundle.main.url(forResource: "etalone"       , withExtension: "wav")!
let ETALONE_FILE_URL_STEREO = Bundle.main.url(forResource: "etalone-stereo", withExtension: "wav")!

struct test {

    @Test func test_realSize() async throws {

        var avBuffer: AVAudioPCMBuffer

        /* channel: 1 */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(
            channels: 1,
            size: 1100
        )!

        #expect(avBuffer.realSize == 1001)

        /* channels: 2 */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(
            channels: 2,
            size: 1100
        )!

        #expect(avBuffer.realSize == 1001)

    }

    @Test func test_floatMatrixGet_segmentGet() async throws {

        var expected: [[Float]] = [[]]
        var received: [[Float]] = [[]]
        var avBuffer: AVAudioPCMBuffer
        var avFile: AVAudioFile

        /* channel: 1 */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(
            channels: 1,
            size: 10
        )!

        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet()!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004 ]]
        received = avBuffer.segmentGet(size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(size: 5)
        #expect(received == expected)

        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet(size: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(size: 11)
        #expect(received == expected)

        expected = [[ 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet(from: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5)
        #expect(received == expected)

        expected = [[ 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet(from: 5, size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5, size: 5)
        #expect(received == expected)

        expected = [[ 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet(from: 5, size: 6)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5, size: 6)
        #expect(received == expected)

        expected = [[]]
        received = avBuffer.segmentGet(from: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11)
        #expect(received == expected)

        expected = [[]]
        received = avBuffer.segmentGet(from: 11, size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 5)
        #expect(received == expected)

        expected = [[]]
        received = avBuffer.segmentGet(from: 11, size: 10)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 10)
        #expect(received == expected)

        expected = [[]]
        received = avBuffer.segmentGet(from: 11, size: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 11)
        #expect(received == expected)

        /* channels: 2 */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(
            channels: 2,
            size: 10
        )!

        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet()!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004 ] ]
        received = avBuffer.segmentGet(size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(size: 5)
        #expect(received == expected)

        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet(size: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(size: 11)
        #expect(received == expected)

        expected = [
            [ +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet(from: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5)
        #expect(received == expected)

        expected = [
            [ +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet(from: 5, size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5, size: 5)
        #expect(received == expected)

        expected = [
            [ +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet(from: 5, size: 6)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5, size: 6)
        #expect(received == expected)

        expected = [[], []]
        received = avBuffer.segmentGet(from: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11)
        #expect(received == expected)

        expected = [[], []]
        received = avBuffer.segmentGet(from: 11, size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 5)
        #expect(received == expected)

        expected = [[], []]
        received = avBuffer.segmentGet(from: 11, size: 10)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 10)
        #expect(received == expected)

        expected = [[], []]
        received = avBuffer.segmentGet(from: 11, size: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 11)
        #expect(received == expected)

        /* channel: 1 | from file */

        avFile = try! AVAudioFile(
            forReading: ETALONE_FILE_URL
        )

        avBuffer = try! AVAudioPCMBuffer(
            file: avFile
        )!

        expected = [[ 0.0, 0.0010000002, 0.0020000003, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet()!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        expected = [[ 0.0, 0.0010000002, 0.0020000003, 0.003, 0.004 ]]
        received = avBuffer.segmentGet(size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(size: 5)
        #expect(received == expected)

        expected = [[ 0.0, 0.0010000002, 0.0020000003, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet(size: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(size: 11)
        #expect(received == expected)

        expected = [[ 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet(from: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5)
        #expect(received == expected)

        expected = [[ 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet(from: 5, size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5, size: 5)
        #expect(received == expected)

        expected = [[ 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.segmentGet(from: 5, size: 6)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5, size: 6)
        #expect(received == expected)

        expected = [[]]
        received = avBuffer.segmentGet(from: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11)
        #expect(received == expected)

        expected = [[]]
        received = avBuffer.segmentGet(from: 11, size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 5)
        #expect(received == expected)

        expected = [[]]
        received = avBuffer.segmentGet(from: 11, size: 10)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 10)
        #expect(received == expected)

        expected = [[]]
        received = avBuffer.segmentGet(from: 11, size: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 11)
        #expect(received == expected)

        /* channels: 2 | from file */

        avFile = try! AVAudioFile(
            forReading: ETALONE_FILE_URL_STEREO
        )

        avBuffer = try! AVAudioPCMBuffer(
            file: avFile
        )!

        expected = [
            [ +0.0, +0.0010000002, +0.0020000003, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.0010000002, -0.0019999999, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet()!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        expected = [
            [ +0.0, +0.0010000002, +0.0020000003, +0.003, +0.004 ],
            [ -0.0, -0.0010000002, -0.0019999999, -0.003, -0.004 ] ]
        received = avBuffer.segmentGet(size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(size: 5)
        #expect(received == expected)

        expected = [
            [ +0.0, +0.0010000002, +0.0020000003, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.0010000002, -0.0019999999, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet(size: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(size: 11)
        #expect(received == expected)

        expected = [
            [ +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet(from: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5)
        #expect(received == expected)

        expected = [
            [ +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet(from: 5, size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5, size: 5)
        #expect(received == expected)

        expected = [
            [ +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.segmentGet(from: 5, size: 6)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 5, size: 6)
        #expect(received == expected)

        expected = [[], []]
        received = avBuffer.segmentGet(from: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11)
        #expect(received == expected)

        expected = [[], []]
        received = avBuffer.segmentGet(from: 11, size: 5)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 5)
        #expect(received == expected)

        expected = [[], []]
        received = avBuffer.segmentGet(from: 11, size: 10)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 10)
        #expect(received == expected)

        expected = [[], []]
        received = avBuffer.segmentGet(from: 11, size: 11)!.floatMatrixGet()
        #expect(received == expected)
        received = avBuffer.floatMatrixGet(from: 11, size: 11)
        #expect(received == expected)

    }

    @Test func test_floatMatrixSet() async throws {

        var expected: [[Float]] = [[]]
        var received: [[Float]] = [[]]
        var avBuffer: AVAudioPCMBuffer

        /* channel: 1 | size: n/a (default: 3) */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 0)
        expected = [[ 0.1, 0.2, 0.3, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 3)
        expected = [[ 0.0, 0.001, 0.002, 0.1, 0.2, 0.3, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.1, 0.2, 0.3, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 9)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.1 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 12)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        /* channel: 1 | size: 6 */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 0, size: 6)
        expected = [[ 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 3, size: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 6, size: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.1, 0.2, 0.3, 0.1 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 9, size: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.1 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avBuffer.floatMatrixSet([[ 0.1, 0.2, 0.3 ]], from: 12, size: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        /* channels: 2 | size: n/a (default: 3) */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 0)
        expected = [
            [ 0.1, 0.2, 0.3, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ 0.4, 0.5, 0.6, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 3)
        expected = [
            [ +0.0, +0.001, +0.002, 0.1, 0.2, 0.3, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.001, -0.002, 0.4, 0.5, 0.6, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 6)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, 0.1, 0.2, 0.3, +0.009 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, 0.4, 0.5, 0.6, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 9)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, 0.1 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, 0.4 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 12)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        /* channels: 2 | size: 6 */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 0, size: 6)
        expected = [
            [ 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, +0.006, +0.007, +0.008, +0.009 ],
            [ 0.4, 0.5, 0.6, 0.4, 0.5, 0.6, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 3, size: 6)
        expected = [
            [ +0.0, +0.001, +0.002, 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, +0.009 ],
            [ -0.0, -0.001, -0.002, 0.4, 0.5, 0.6, 0.4, 0.5, 0.6, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 6, size: 6)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, 0.1, 0.2, 0.3, 0.1 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, 0.4, 0.5, 0.6, 0.4 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 9, size: 6)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, 0.1 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, 0.4 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avBuffer.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ]], from: 12, size: 6)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

    }

    @Test func test_segmentSet() async throws {

        var expected: [[Float]] = [[]]
        var received: [[Float]] = [[]]
        var avBuffer: AVAudioPCMBuffer
        var avFiller: AVAudioPCMBuffer

        /* channel: 1 | size: n/a (default: 3) */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 0)
        expected = [[ 0.1, 0.2, 0.3, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 3)
        expected = [[ 0.0, 0.001, 0.002, 0.1, 0.2, 0.3, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.1, 0.2, 0.3, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 9)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.1 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 12)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        /* channel: 1 | size: 6 */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 0, size: 6)
        expected = [[ 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 3, size: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 6, size: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.1, 0.2, 0.3, 0.1 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 9, size: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.1 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 1, size:  3)!
        avFiller.floatMatrixSet([[ 0.1, 0.2, 0.3 ]])
        avBuffer.segmentSet(avFiller, from: 12, size: 6)
        expected = [[ 0.0, 0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009 ]]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        /* channels: 2 | size: n/a (default: 3) */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 0)
        expected = [
            [ 0.1, 0.2, 0.3, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ 0.4, 0.5, 0.6, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 3)
        expected = [
            [ +0.0, +0.001, +0.002, 0.1, 0.2, 0.3, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.001, -0.002, 0.4, 0.5, 0.6, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 6)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, 0.1, 0.2, 0.3, +0.009 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, 0.4, 0.5, 0.6, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 9)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, 0.1 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, 0.4 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 12)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        /* channels: 2 | size: 6 */

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 0, size: 6)
        expected = [
            [ 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, +0.006, +0.007, +0.008, +0.009 ],
            [ 0.4, 0.5, 0.6, 0.4, 0.5, 0.6, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 3, size: 6)
        expected = [
            [ +0.0, +0.001, +0.002, 0.1, 0.2, 0.3, 0.1, 0.2, 0.3, +0.009 ],
            [ -0.0, -0.001, -0.002, 0.4, 0.5, 0.6, 0.4, 0.5, 0.6, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 6, size: 6)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, 0.1, 0.2, 0.3, 0.1 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, 0.4, 0.5, 0.6, 0.4 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 9, size: 6)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, 0.1 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, 0.4 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

        avBuffer = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size: 10)!
        avFiller = AVAudioPCMBuffer.etaloneGenerate(channels: 2, size:  3)!
        avFiller.floatMatrixSet([
            [ 0.1, 0.2, 0.3 ],
            [ 0.4, 0.5, 0.6 ] ])
        avBuffer.segmentSet(avFiller, from: 12, size: 6)
        expected = [
            [ +0.0, +0.001, +0.002, +0.003, +0.004, +0.005, +0.006, +0.007, +0.008, +0.009 ],
            [ -0.0, -0.001, -0.002, -0.003, -0.004, -0.005, -0.006, -0.007, -0.008, -0.009 ] ]
        received = avBuffer.floatMatrixGet()
        #expect(received == expected)

    }

}
