
import Foundation

let string = "Привет!"

for char in string {
    print(char, terminator: "")
}

print("")
print(string[0] == "П")
print(string[1] == "р")
print(string[2] == "и")
print(string[3] == "в")
print(string[4] == "е")
print(string[5] == "т")
print(string[6] == "!")

print("")
print(string[-7] == "П")
print(string[-6] == "р")
print(string[-5] == "и")
print(string[-4] == "в")
print(string[-3] == "е")
print(string[-2] == "т")
print(string[-1] == "!")

print("")
print(string[0, 0] == "П")
print(string[0, 1] == "Пр")
print(string[0, 2] == "При")
print(string[0, 3] == "Прив")
print(string[0, 4] == "Приве")
print(string[0, 5] == "Привет")
print(string[0, 6] == "Привет!")

print("")
print(string[3, 3] == "в")
print(string[3, 4] == "ве")
print(string[3, 5] == "вет")
print(string[3, 6] == "вет!")

extension String {

    subscript(position: Int) -> Character {
        let index = position >= 0 ? self.startIndex : self.endIndex
        return self[self.index(index, offsetBy: position)]
    }

    subscript(startPosition: Int, endPosition: Int) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: startPosition)
        let endIndex = self.index(self.startIndex, offsetBy: endPosition)
        return self[startIndex...endIndex]
    }

}
