
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Testing

struct Test {

    let prettyResult: (UInt) -> String = { value in
        String("0b") + String(value, radix: 2).paddingLeft(toLength: 9, withPad: "0")
    }

    @Test func all() throws {
        try? self.bitGet()
        try? self.bitSet()
        try? self.bitToggle()
    }

    func bitGet() throws {
        print("bitGet:")
        for i in 0 ... 0b111111111 {
            let received = "0b" +
                String(UInt(i)[8] ? 1 : 0) +
                String(UInt(i)[7] ? 1 : 0) +
                String(UInt(i)[6] ? 1 : 0) +
                String(UInt(i)[5] ? 1 : 0) +
                String(UInt(i)[4] ? 1 : 0) +
                String(UInt(i)[3] ? 1 : 0) +
                String(UInt(i)[2] ? 1 : 0) +
                String(UInt(i)[1] ? 1 : 0) +
                String(UInt(i)[0] ? 1 : 0)
            let expected = self.prettyResult(UInt(i))
            print("\(String(i).padding(toLength: 3, withPad: " ", startingAt: 0)): ", terminator: "")
            print("\(received) = \(expected)", terminator: "")
                #expect(expected == received)
            print("")
        }
    }

    func bitSet() throws {
        var value: UInt
        var received: String
        var expected: String
        var isOn: Bool

        isOn = false
        print("bitSet (value: 0b000000000, isOn: \(isOn)):")
        value = 0b000000000;  value[0] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[1] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[2] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[3] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[4] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[5] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[6] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[7] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[8] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)

        isOn = true
        print("bitSet (value: 0b000000000, isOn: \(isOn)):")
        value = 0b000000000;  value[0] = isOn;  expected = "0b000000001";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[1] = isOn;  expected = "0b000000010";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[2] = isOn;  expected = "0b000000100";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[3] = isOn;  expected = "0b000001000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[4] = isOn;  expected = "0b000010000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[5] = isOn;  expected = "0b000100000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[6] = isOn;  expected = "0b001000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[7] = isOn;  expected = "0b010000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[8] = isOn;  expected = "0b100000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)

        isOn = false
        print("bitSet (value: 0b111111111, isOn: \(isOn)):")
        value = 0b111111111;  value[0] = isOn;  expected = "0b111111110";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[1] = isOn;  expected = "0b111111101";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[2] = isOn;  expected = "0b111111011";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[3] = isOn;  expected = "0b111110111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[4] = isOn;  expected = "0b111101111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[5] = isOn;  expected = "0b111011111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[6] = isOn;  expected = "0b110111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[7] = isOn;  expected = "0b101111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[8] = isOn;  expected = "0b011111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)

        isOn = true
        print("bitSet (value: 0b111111111, isOn: \(isOn)):")
        value = 0b111111111;  value[0] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[1] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[2] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[3] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[4] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[5] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[6] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[7] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[8] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
    }

    func bitToggle() throws {
        var value: UInt
        var received: String
        var expected: String

        print("bitToggle (value: 0b000000000):")
        value = 0b000000000;  value.bitToggle(position: 0);  expected = "0b000000001";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value.bitToggle(position: 1);  expected = "0b000000010";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value.bitToggle(position: 2);  expected = "0b000000100";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value.bitToggle(position: 3);  expected = "0b000001000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value.bitToggle(position: 4);  expected = "0b000010000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value.bitToggle(position: 5);  expected = "0b000100000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value.bitToggle(position: 6);  expected = "0b001000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value.bitToggle(position: 7);  expected = "0b010000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value.bitToggle(position: 8);  expected = "0b100000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)

        print("bitToggle (value: 0b111111111):")
        value = 0b111111111;  value.bitToggle(position: 0);  expected = "0b111111110";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value.bitToggle(position: 1);  expected = "0b111111101";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value.bitToggle(position: 2);  expected = "0b111111011";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value.bitToggle(position: 3);  expected = "0b111110111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value.bitToggle(position: 4);  expected = "0b111101111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value.bitToggle(position: 5);  expected = "0b111011111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value.bitToggle(position: 6);  expected = "0b110111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value.bitToggle(position: 7);  expected = "0b101111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value.bitToggle(position: 8);  expected = "0b011111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
    }

}
