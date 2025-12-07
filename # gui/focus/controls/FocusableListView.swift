
import SwiftUI

struct FocusableListView<Key>: View where Key: Hashable & Comparable {

    enum Focuser: Hashable {
        case item(index: Int)
    }

    @FocusState private var focuser: Focuser?
    @Binding var selectedKey: Key?

    var items: [
        Key: String
    ]

    init(items: [Key: String], selectedKey: Binding<Key?>) {
        self.items = items
        self._selectedKey = selectedKey
    }

    private var itemsList: [(key: Key, value: String)] {
        self.items.ordered()
    }

    var body: some View {
        ScrollViewReader { proxy in
            List { self.list }
                .onAppear {
                    self.focuser = .item(index: 0)
                }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow.rawValue) {
                    if case .item(let index) = self.focuser {
                        if (index > 0) {
                            self.focuser = .item(index: index - 1)
                            proxy.scrollTo(index - 1)
                        }
                    }
                }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue) {
                    if case .item(let index) = self.focuser {
                        if (index < self.items.count - 1) {
                            self.focuser = .item(index: index + 1)
                            proxy.scrollTo(index + 1)
                        }
                    }
                }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.return.rawValue) {
                    if case .item(let index) = self.focuser {
                        if (index >= 0 && index <= self.items.count - 1) {
                            self.selectedKey = self.itemsList[index].key
                        }
                    }
                }
        }
    }

    @ViewBuilder var list: some View {
        ForEach(Array(itemsList.enumerated()), id: \.element.key) { index, item in
            Button {
                self.selectedKey = item.key
            } label: {
                Text("\(index):\(item.key):\(item.value)")
            }
            .focused(self.$focuser, equals: .item(index: index))
            .id(index)
        }
    }

}
