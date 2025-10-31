
import SwiftUI

struct FocusableListView: View {

    enum Focuser: Hashable {
        case item(id: Int)
    }

    @FocusState private var focuser: Focuser?

    var items: [Item]
    var selectedItem: Binding<Item?>

    var body: some View {
        ScrollViewReader { proxy in
            List { self.list }
                .onAppear {
                    self.focuser = .item(id: 0)
                }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow.rawValue) {
                    if case .item(let id) = self.focuser {
                        if (id > 0) {
                            self.focuser = .item(id: id - 1)
                            proxy.scrollTo(id - 1)
                        }
                    }
                }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue) {
                    if case .item(let id) = self.focuser {
                        if (id < self.items.count - 1) {
                            self.focuser = .item(id: id + 1)
                            proxy.scrollTo(id + 1)
                        }
                    }
                }
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.return.rawValue) {
                    if case .item(let id) = self.focuser {
                        if (id >= 0 && id <= self.items.count - 1) {
                            self.selectedItem.wrappedValue = self.items[id]
                        }
                    }
                }
        }
    }

    @ViewBuilder var list: some View {
        ForEach(self.items) { item in
            Button {
                self.selectedItem.wrappedValue = item
            } label: {
                Text("\(item.id):\(item.title)")
            }
            .focused(self.$focuser, equals: .item(id: item.id))
            .id(item.id)
        }
    }

}
