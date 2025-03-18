
import SwiftUI

struct ArrayTuples<Element>: RandomAccessCollection {

    let startIndex: Int = 0
    var endIndex  : Int { self.dataSource.count }
    let dataSource: [Element]

    init(_ dataSource: [Element]) {
        self.dataSource = dataSource
    }

    subscript(index: Int) -> (key: Int, value: Element) {
        get { (
            key  :                 index,
            value: self.dataSource[index]
        ) }
    }

}

/*

extension ForEach {

    public init(data: Array<Any>, @ViewBuilder content: @escaping (Int, Array<Any>.Element) -> Content) {
        var arrayOfTuples: [(key: Int, value: Array<Any>.Element)] = []
        for i in 0 ..< data.count {
            arrayOfTuples.insert(
                (key: i, value: data[i]), at: i
            )
        }
        self.init(
            arrayOfTuples,
            id: \.key,
            content: content
        )
    }

}

extension ForEachSectionCollection {
    public subscript(index: Int) -> (key: Int, value: Element) {
        get { (
            key  :      index,
            value: self[index]
        ) }
    }
}

*/
