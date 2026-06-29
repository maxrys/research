
struct ComplexStruct: Hashable {
    let a: String
    let b: String
}

var dictIntKeys: [Int: String] = [
    1: "Item 1",
    5: "Item 5",
 // 3: ← hole
    4: "Item 4",
    2: "Item 2",
]

var dictStrKeys = [
    "key1": "value1",
    "key5": "value5",
 // "key3": ← hole
    "key4": "value4",
    "key2": "value2",
]

var dictComplex = [
    "key1": ComplexStruct(a: "value 1.1", b: "value 1.2"),
    "key5": ComplexStruct(a: "value 5.1", b: "value 5.2"),
 // "key3": ← hole
    "key4": ComplexStruct(a: "value 4.1", b: "value 4.2"),
    "key2": ComplexStruct(a: "value 2.1", b: "value 2.2"),
]

var dictIntKeysEmpty: [Int: String] = [:]
