
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct DatePickerCustom: View {

    struct Value: Equatable {
        var date: Date
        var zone: String
        var result: Date {
            if let offsetNumeric = Date.TIME_ZONES_OFFSSET[self.zone]
                 { return self.date.toNewTimeZone(offset: offsetNumeric) }
            else { return self.date }
        }
    }

    @Environment(\.colorScheme) private var colorScheme
    @Binding private var value: Value

    private let yearMinValue: Int
    private let yearMaxValue: Int

    init(
        value: Binding<Value>,
        yearMinValue: Int = 1970,
        yearMaxValue: Int = 2050
    ) {
        self.yearMinValue = yearMinValue
        self.yearMaxValue = yearMaxValue
        self._value = value
    }

    private var dayItems: [Int: String] {
        let daysInMonth = Date.daysInMonth(month: self.value.date.monthUTC, year: self.value.date.yearUTC)
        return (1 ... (daysInMonth ?? 31)).reduce(into: [Int: String]()) { result, value in
            result[value] = value < 10 ? "\u{2002}\(value)" : "\(value)"
        }
    }

    private var yearItems: [Int: String] {
        (self.yearMinValue ... self.yearMaxValue).reduce(into: [Int: String]()) { result, value in
            result[value] = "\(value)"
        }
    }

    private var hourItems: [Int: String] {
        (0 ... 23).reduce(into: [Int: String]()) { result, value in
            result[value] = value < 10 ? "0\(value)" : "\(value)"
        }
    }

    private var minuteAndSecondItems: [Int: String] {
        (0 ... 59).reduce(into: [Int: String]()) { result, value in
            result[value] = value < 10 ? "0\(value)" : "\(value)"
        }
    }

    private let columns = [
        GridItem(.fixed(90), spacing: 0, alignment: .trailing),
        GridItem(.flexible(), spacing: 0, alignment: .leading),
    ]

    var body: some View {
        LazyVGrid(columns: self.columns, spacing: 10) {

            Text(NSLocalizedString("Date", comment: ""))
                .font(.headline)

            HStack(spacing: 0) {
                FieldList(
                    ID: "dayUTC",
                    value: self.value.date.dayUTC,
                    items: self.dayItems,
                    onChange: { value in
                        self.value.date.dayUTC = value
                    }
                ).frame(width: 60)

                FieldList(
                    ID: "monthUTC",
                    value: self.value.date.monthUTC,
                    items: Date.MONTH_NAMES,
                    onChange: { value in
                        self.updateMonth(value)
                    }
                ).frame(width: 120)

                FieldList(
                    ID: "yearUTC",
                    value: self.value.date.yearUTC,
                    items: self.yearItems,
                    onChange: { value in
                        self.updateYear(value)
                    }
                ).frame(width: 72)
            }

            Text(NSLocalizedString("Time", comment: ""))
                .font(.headline)

            HStack(spacing: 0) {
                FieldList(
                    ID: "hourUTC",
                    value: self.value.date.hourUTC,
                    items: self.hourItems,
                    onChange: { value in
                        self.value.date.hourUTC = value
                    }
                ).frame(width: 60)

                FieldList(
                    ID: "minuteUTC",
                    value: self.value.date.minuteUTC,
                    items: self.minuteAndSecondItems,
                    onChange: { value in
                        self.value.date.minuteUTC = value
                    }
                ).frame(width: 60)

                FieldList(
                    ID: "secondUTC",
                    value: self.value.date.secondUTC,
                    items: self.minuteAndSecondItems,
                    onChange: { value in
                        self.value.date.secondUTC = value
                    }
                ).frame(width: 60)
            }

            Text(NSLocalizedString("TimeZone", comment: ""))
                .font(.headline)

            FieldTimeZone(
                value: self.value.zone,
                onChange: { value in
                    self.value.zone = value
                }
            ).frame(width: 180)

        }
    }

    private func updateMonth(_ newMonth: Int) {
        var resultDate = self.value.date
        if let daysInMonth = Date.daysInMonth(month: newMonth, year: resultDate.yearUTC) {
            if (resultDate.dayUTC > daysInMonth) {
                resultDate.dayUTC = daysInMonth
            }
        }
        resultDate.monthUTC = newMonth
        if (resultDate != self.value.date) {
            self.value.date = resultDate
        }
    }

    private func updateYear(_ newYear: Int) {
        var resultDate = self.value.date
        if let daysInMonth = Date.daysInMonth(month: resultDate.monthUTC, year: newYear) {
            if (resultDate.dayUTC > daysInMonth) {
                resultDate.dayUTC = daysInMonth
            }
        }
        resultDate.yearUTC = newYear
        if (resultDate != self.value.date) {
            self.value.date = resultDate
        }
    }

}



fileprivate final class FieldValueState<T>: ObservableObject {

    @Published public var value: T { willSet { self.onChange(newValue) } }
    private let onChange: (T) -> Void

    init(_ value: T, _ onChange: @escaping (T) -> Void) {
        self.value    = value
        self.onChange = onChange
    }

}



fileprivate struct FieldTimeZone: View, Equatable {

    static func == (lhs: FieldTimeZone, rhs: FieldTimeZone) -> Bool {
        lhs.state.value == rhs.state.value
    }

    @ObservedObject private var state: FieldValueState<String>

    init(value: String, onChange: @escaping (String) -> Void) {
        self.state = FieldValueState(value, onChange)
    }

    var body: some View {
        let _ = { Logger.customLog("RENDER FieldTimeZone") }()
        Picker("", selection: self.$state.value) {
            let groups = Date.TIME_ZONES_GROUPPED_LIST.sorted(by: { (lhs, rhs) in lhs.key > rhs.key })
            ForEach(groups, id: \.key) { offsetNumeric, group in
                Section(header: Text(group.offsetFormatted).font(.system(size: 18))) {
                    let zones = group.items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key })
                    ForEach(zones, id: \.key) { ID, title in
                        Text(title).tag(ID)
                    }
                }
            }
        }
    }

}



fileprivate struct FieldList: View, Equatable {

    static func == (lhs: FieldList, rhs: FieldList) -> Bool {
        lhs.ID          == rhs.ID          &&
        lhs.state.value == rhs.state.value &&
        lhs.items       == rhs.items
    }

    @ObservedObject private var state: FieldValueState<Int>

    private let ID: String
    private let items: [Int: String]

    init(ID: String, value: Int, items: [Int: String], onChange: @escaping (Int) -> Void) {
        self.ID    = ID
        self.state = FieldValueState(value, onChange)
        self.items = items
    }

    var body: some View {
        let _ = { Logger.customLog("RENDER FieldList with ID = \(self.ID)") }()
        Picker("", selection: self.$state.value) {
            ForEach(Array(self.items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).enumerated()), id: \.element.key) { index, element in
                Text("\(String(element.value))").tag(element.key)
            }
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct DatePickerCustom_Previews: PreviewProvider {
    static public var previews: some View {
        DatePickerCustom(
            value: .constant(
                DatePickerCustom.Value(
                    date: Date(iso8601: "2000-01-01 00:00:00")!,
                    zone: "UTC"
                )
            )
        )
        .padding(20)
        .frame(width: 400)
    }
}

