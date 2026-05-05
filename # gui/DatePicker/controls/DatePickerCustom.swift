
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct DatePickerCustom: View {

    struct Value {
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

    private func updateMonth(_ newMonth: Int) {
        var resultDate = self.value.date
        if let daysInMonth = Date.daysInMonth(month: newMonth, year: resultDate.yearUTC) {
            if (resultDate.dayUTC > daysInMonth) {
                resultDate.dayUTC = daysInMonth
            }
        }
        resultDate.monthUTC = newMonth
        self.value.date = resultDate
    }

    private func updateYear(_ newYear: Int) {
        var resultDate = self.value.date
        if let daysInMonth = Date.daysInMonth(month: resultDate.monthUTC, year: newYear) {
            if (resultDate.dayUTC > daysInMonth) {
                resultDate.dayUTC = daysInMonth
            }
        }
        resultDate.yearUTC = newYear
        self.value.date = resultDate
    }

    private var days: [Int: String] {
        let daysInMonth = Date.daysInMonth(month: self.value.date.monthUTC, year: self.value.date.yearUTC)
        return (1 ... (daysInMonth ?? 31)).reduce(into: [Int: String]()) { result, value in
            result[value] = value < 10 ? "\u{2002}\(value)" : "\(value)"
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
                self.FieldList(
                    toValue: Binding(
                        get: {             self.value.date.dayUTC },
                        set: { newValue in self.value.date.dayUTC = newValue }),
                    items: self.days
                ).frame(width: 60)

                self.FieldList(
                    toValue: Binding(
                        get: {             self.value.date.monthUTC },
                        set: { newValue in self.updateMonth(newValue) }),
                    items: Date.MONTH_NAMES
                ).frame(width: 120)

                self.FieldList(
                    toValue: Binding(
                        get: {             self.value.date.yearUTC },
                        set: { newValue in self.updateYear(newValue) }),
                    items: (self.yearMinValue ... self.yearMaxValue).reduce(into: [Int: String]()) { result, value in
                        result[value] = "\(value)"
                    }
                ).frame(width: 72)
            }

            Text(NSLocalizedString("Time", comment: ""))
                .font(.headline)

            HStack(spacing: 0) {
                self.FieldList(
                    toValue: Binding(
                        get: {             self.value.date.hourUTC },
                        set: { newValue in self.value.date.hourUTC = newValue }),
                    items: (0 ... 23).reduce(into: [Int: String]()) { result, value in
                        result[value] = value < 10 ? "0\(value)" : "\(value)"
                    }
                ).frame(width: 60)

                self.FieldList(
                    toValue: Binding(
                        get: {             self.value.date.minuteUTC },
                        set: { newValue in self.value.date.minuteUTC = newValue }),
                    items: (0 ... 59).reduce(into: [Int: String]()) { result, value in
                        result[value] = value < 10 ? "0\(value)" : "\(value)"
                    }
                ).frame(width: 60)

                self.FieldList(
                    toValue: Binding(
                        get: {             self.value.date.secondUTC },
                        set: { newValue in self.value.date.secondUTC = newValue }),
                    items: (0 ... 59).reduce(into: [Int: String]()) { result, value in
                        result[value] = value < 10 ? "0\(value)" : "\(value)"
                    }
                ).frame(width: 60)
            }

            Text(NSLocalizedString("TimeZone", comment: ""))
                .font(.headline)

            self.FieldTimeZone(
                toValue: Binding(
                    get: {             self.value.zone },
                    set: { newValue in self.value.zone = newValue }),
            ).frame(width: 180)

        }
    }

    @ViewBuilder private func FieldList(toValue: Binding<Int>, items: [Int: String]) -> some View {
        Picker("", selection: toValue) {
            ForEach(Array(items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).enumerated()), id: \.element.key) { index, element in
                Text("\(String(element.value))").tag(element.key)
            }
        }
    }

    @ViewBuilder private func FieldTimeZone(toValue: Binding<String>) -> some View {
        Picker("", selection: toValue) {
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

