
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

typealias MessageBoxID = UInt
typealias MessageID = UInt

enum MessageRegion: Codable {

    case distributed(appName: String)
    case local

}

enum MessageType: Codable {

    case info
    case ok
    case warning
    case error

}

enum MessageLifeTime: Codable {

    static let LIFE_TIME_DEFAULT: CFTimeInterval = 3.0

    case time(duration: Double)
    case infinity

}

enum MessageMergePolicy: Codable {

    case replaceOrInsert
    case deleteAndInsert

}

struct MessageInfo: Equatable, Codable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.ID == rhs.ID
    }

    public var progress: Double? {
        if case .time(let duration) = self.lifetime {
            let createdAt = self.createdAt
            let expiresAt = self.createdAt + duration
            return Date.timestamp.progress(
                begin: createdAt, end: expiresAt
            )
        }
        return nil
    }

    public var isExpired: Bool? {
        if case .time(let duration) = self.lifetime {
            let expiresAt = self.createdAt + duration
            return Date.timestamp > expiresAt
        }
        return nil
    }

    public let ID: MessageID
    public let type: MessageType
    public let lifetime: MessageLifeTime
    public let isClosable: Bool
    public let mergePolicy: MessageMergePolicy
    public let title: String
    public let description: String?
    public let createdAt: TimeInterval

    init(
        ID: MessageID? = nil,
        type: MessageType = .info,
        lifetime: MessageLifeTime = .time(duration: MessageLifeTime.LIFE_TIME_DEFAULT),
        isClosable: Bool = false,
        mergePolicy: MessageMergePolicy = .replaceOrInsert,
        title: String,
        description: String? = nil
    ) {
        self.type = type
        self.lifetime = lifetime
        self.isClosable = isClosable
        self.mergePolicy = mergePolicy
        self.title = title
        self.description = description
        self.createdAt = Date.timestamp
        self.ID = ID ?? MessageID(Checksums.crc32(
            "\(type)|\(title)|\(description ?? "")"
        ))
    }

    init?(decode json: String) {
        do {
            guard let data = json.data(using: .utf8) else {
                return nil
            }
            self = try JSONDecoder().decode(
                Self.self,
                from: data
            )
        } catch {
            return nil
        }
    }

    func encode() -> String? {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(self) else {
            return nil
        }
        return String(
            data: data,
            encoding: .utf8
        )
    }

}

fileprivate struct Message: View {

    @State private var isHoverOnTitle = false

    public let type: MessageType
    public let progress: Double?
    public let isClosable: Bool
    public let title: String
    public let description: String?

    private var colorTitleBackground: Color {
        switch self.type {
            case .info   : Color.messageBox.infoTitleBackground
            case .ok     : Color.messageBox.okTitleBackground
            case .warning: Color.messageBox.warningTitleBackground
            case .error  : Color.messageBox.errorTitleBackground
        }
    }

    private var colorDescriptionBackground: Color {
        switch self.type {
            case .info   : Color.messageBox.infoDescriptionBackground
            case .ok     : Color.messageBox.okDescriptionBackground
            case .warning: Color.messageBox.warningDescriptionBackground
            case .error  : Color.messageBox.errorDescriptionBackground
        }
    }

    private var colorProgressBackground: Color {
        switch self.type {
            case .info   : Color.messageBox.infoProgressBackground
            case .ok     : Color.messageBox.okProgressBackground
            case .warning: Color.messageBox.warningProgressBackground
            case .error  : Color.messageBox.errorProgressBackground
        }
    }

    public var body: some View {
        VStack(spacing: 0) {
            self.TitleView()
            self.DescriptionView()
        }.overlayPolyfill(alignment: .bottom) {
            self.ProgressView()
        }
    }

    @ViewBuilder private func TitleView() -> some View {
        Text(self.title)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(10)
            .frame(maxWidth: .infinity)
            .foregroundPolyfill(Color.messageBox.text)
            .background(self.colorTitleBackground)
            .overlayPolyfill(alignment: .topTrailing) {
                if (self.isClosable && self.isHoverOnTitle) {
                    self.ButtonCloseView()
                        .padding(8)
                }
            }
            .onHover { isHovering in
                self.isHoverOnTitle = isHovering
            }
    }

    @ViewBuilder private func DescriptionView() -> some View {
        if let description = self.description {
            Text(description)
                .padding(10)
                .frame(maxWidth: .infinity)
                .foregroundPolyfill(Color.messageBox.text)
                .background(self.colorDescriptionBackground)
        }
    }

    @ViewBuilder private func ProgressView() -> some View {
        if let progress = self.progress {
            GeometryReaderCustom(isIgnoreHeight: true, alignment: .leading) { size in
                Rectangle()
                    .fill(self.colorProgressBackground)
                    .frame(width: size.width * progress, height: 3)
            }
        }
    }

    @ViewBuilder private func ButtonCloseView() -> some View {
        Button {
            // UNDER CONSTRUCTION
        } label: {
            let shape = RoundedRectangle(cornerRadius: 3)
            shape
                .fill(self.colorDescriptionBackground)
                .frame(width: 20, height: 20)
                .overlayPolyfill {
                    Image(systemName: "xmark.square")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundPolyfill(Color.messageBox.text)
                }
                .clipShape   (shape)
                .contentShape(shape)
                .focusEffect (shape)
        }
        .focusable(false)
        .buttonStyle(.plain)
        .shadow(
            color: .black.opacity(0.5),
            radius: 3,
            y: 0
        )
    }

}

struct MessageBox: View {

    static let MESSAGE_NAME_FOR_INSERT_DISTRIBUTED = "messageInsertDistributed"
    static let MESSAGE_NAME_FOR_DELETE_DISTRIBUTED = "messageDeleteDistributed"
    static let MESSAGE_NAME_FOR_INSERT_LOCAL       = "messageInsertLocal"
    static let MESSAGE_NAME_FOR_DELETE_LOCAL       = "messageDeleteLocal"

    static private func notificationNameForInsertDistributed(_ appName: String, _ messageBoxID: MessageBoxID) -> NSNotification.Name { NSNotification.Name("\(Self.MESSAGE_NAME_FOR_INSERT_DISTRIBUTED)-\(appName)-\(messageBoxID)") }
    static private func notificationNameForDeleteDistributed(_ appName: String, _ messageBoxID: MessageBoxID) -> NSNotification.Name { NSNotification.Name("\(Self.MESSAGE_NAME_FOR_DELETE_DISTRIBUTED)-\(appName)-\(messageBoxID)") }
    static private func notificationNameForInsertLocal      (                   _ messageBoxID: MessageBoxID) -> NSNotification.Name { NSNotification.Name("\(Self.MESSAGE_NAME_FOR_INSERT_LOCAL)-\(messageBoxID)") }
    static private func notificationNameForDeleteLocal      (                   _ messageBoxID: MessageBoxID) -> NSNotification.Name { NSNotification.Name("\(Self.MESSAGE_NAME_FOR_DELETE_LOCAL)-\(messageBoxID)") }

    static public func insert(region: MessageRegion = .local, to messageBoxID: MessageBoxID, _ message: MessageInfo) {
        if case .distributed(let appName) = region { NotificationCenter.default.postDistributed(name: Self.notificationNameForInsertDistributed(appName, messageBoxID), object: message.encode()) }
        if case .local                    = region { NotificationCenter.default.post           (name: Self.notificationNameForInsertLocal      (         messageBoxID), object: message.encode()) }
    }

    static public func delete(region: MessageRegion = .local, to messageBoxID: MessageBoxID, _ ID: MessageID) {
        if case .distributed(let appName) = region { NotificationCenter.default.postDistributed(name: Self.notificationNameForDeleteDistributed(appName, messageBoxID), object: String(ID)) }
        if case .local                    = region { NotificationCenter.default.post           (name: Self.notificationNameForDeleteLocal      (         messageBoxID), object: String(ID)) }
    }

    private var publisherForInsert: NotificationCenter.Publisher {
        switch self.region {
            case .distributed(let appName): DistributedNotificationCenter.default.publisher(for: Self.notificationNameForInsertDistributed(appName, self.ID))
            case .local                   :            NotificationCenter.default.publisher(for: Self.notificationNameForInsertLocal      (         self.ID))
        }
    }

    private var publisherForDelete: NotificationCenter.Publisher {
        switch self.region {
            case .distributed(let appName): DistributedNotificationCenter.default.publisher(for: Self.notificationNameForDeleteDistributed(appName, self.ID))
            case .local                   :            NotificationCenter.default.publisher(for: Self.notificationNameForDeleteLocal      (         self.ID))
        }
    }

    @ObservedObject private var messages = ValueState<[MessageInfo]>([])
    @ObservedObject private var frame = ValueState<UInt>(0)

    private let ID: MessageBoxID
    private let region: MessageRegion
    private var timer: Timer.Custom!

    init(ID: MessageBoxID, region: MessageRegion = .local) {
        self.ID = ID
        self.region = region
        self.timer = Timer.Custom(
            repeats: .infinity,
            delay: 1.0,
            onTick: self.onTick
        )
    }

    private func onTick(timer: Timer.Custom) {
        self.messagesSanitizeIfRequired()
        self.frame.value += 1 /* view will be refresh */
    }

    private func messagesSanitizeIfRequired() {
        if !self.messages.value.isEmpty {
            self.messages.value.removeAll { info in
                info.isExpired == true
            }
        }
    }

    private func messageInsert(_ newInfo: MessageInfo) {
        self.messages.value.append(newInfo)
    }

    private func messageUpdate(_ newInfo: MessageInfo) -> Bool {
        if let index = self.messages.value.firstIndex(where: { info in info.ID == newInfo.ID }) {
            self.messages.value[index] = newInfo
            return true
        }
        return false
    }

    private func messageDelete(_ ID: MessageID) {
        if let index = self.messages.value.firstIndex(where: { info in info.ID == ID }) {
            self.messages.value.remove(at: index)
        }
    }

    public var body: some View {
        VStack(spacing: 0) {
            let _ = self.frame.value /* view will be refresh */
            ForEach(0 ..< self.messages.value.count, id: \.self) { index in
                let info = self.messages.value[index]
                Message(
                    type: info.type,
                    progress: info.progress,
                    isClosable: info.isClosable,
                    title: info.title,
                    description: info.description
                )
            }
        }
        .onReceive(self.publisherForInsert) { publisher in
            if let messageString = publisher.object as? String {
                if let newInfo = MessageInfo(decode: messageString) {
                    switch (newInfo.mergePolicy) {
                        case .replaceOrInsert:
                            if !self.messageUpdate(newInfo) {
                                self.messageInsert(newInfo)
                            }
                        case .deleteAndInsert:
                            self.messageDelete(newInfo.ID)
                            self.messageInsert(newInfo)
                    }
                }
            }
        }
        .onReceive(self.publisherForDelete) { publisher in
            if let IDString = publisher.object as? String {
                if let ID = MessageID(IDString) {
                    self.messageDelete(ID)
                }
            }
        }
    }

}
