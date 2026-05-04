
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

    @State private var day   : Int /* 1 ... 31 */
    @State private var month : Int /* 1 ... 12 */
    @State private var year  : Int /* 1970 ... 2050 */
    @State private var hour  : Int /* 0 ... 23 */
    @State private var minute: Int /* 0 ... 59 */
    @State private var second: Int /* 0 ... 59 */
    @State private var zone: String

    private let yearMinValue: Int
    private let yearMaxValue: Int

    init(
        value: Binding<Value>,
        yearMinValue: Int = 1970,
        yearMaxValue: Int = 2050
    ) {
        self._value = value
        self.day    = value.wrappedValue.date.dayUTC
        self.month  = value.wrappedValue.date.monthUTC
        self.year   = value.wrappedValue.date.yearUTC
        self.hour   = value.wrappedValue.date.hourUTC
        self.minute = value.wrappedValue.date.minuteUTC
        self.second = value.wrappedValue.date.secondUTC
        self.zone   = value.wrappedValue.zone
        self.yearMinValue = yearMinValue
        self.yearMaxValue = yearMaxValue
    }

    private var days: [Int: String] {
        let daysInMonth = Date.daysInMonth(month: self.month, year: self.year)
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
                DatePickerCustom.FieldList(
                    toValue: self.$day,
                    items: self.days
                ).frame(width: 60)

                DatePickerCustom.FieldList(
                    toValue: self.$month,
                    items: Date.MONTH_NAMES
                ).frame(width: 120)

                DatePickerCustom.FieldList(
                    toValue: self.$year,
                    items: (self.yearMinValue ... self.yearMaxValue).reduce(into: [Int: String]()) { result, value in
                        result[value] = "\(value)"
                    }
                ).frame(width: 72)
            }

            Text(NSLocalizedString("Time", comment: ""))
                .font(.headline)

            HStack(spacing: 0) {
                DatePickerCustom.FieldList(
                    toValue: self.$hour,
                    items: (0 ... 23).reduce(into: [Int: String]()) { result, value in
                        result[value] = value < 10 ? "0\(value)" : "\(value)"
                    }
                ).frame(width: 60)

                DatePickerCustom.FieldList(
                    toValue: self.$minute,
                    items: (0 ... 59).reduce(into: [Int: String]()) { result, value in
                        result[value] = value < 10 ? "0\(value)" : "\(value)"
                    }
                ).frame(width: 60)

                DatePickerCustom.FieldList(
                    toValue: self.$second,
                    items: (0 ... 59).reduce(into: [Int: String]()) { result, value in
                        result[value] = value < 10 ? "0\(value)" : "\(value)"
                    }
                ).frame(width: 60)
            }

            Text(NSLocalizedString("TimeZone", comment: ""))
                .font(.headline)

            DatePickerCustom.FieldTimeZone(
                toValue: self.$zone
            ).frame(width: 180)

        }
        .onChange(of: self.day   ) { newDayValue    in self.value.date.dayUTC    = newDayValue }
        .onChange(of: self.hour  ) { newHourValue   in self.value.date.hourUTC   = newHourValue }
        .onChange(of: self.minute) { newMinuteValue in self.value.date.minuteUTC = newMinuteValue }
        .onChange(of: self.second) { newSecondValue in self.value.date.secondUTC = newSecondValue }
        .onChange(of: self.zone  ) { newZoneValue   in self.value.zone           = newZoneValue }
        .onChange(of: self.month ) { newMonthValue  in self.fixDay(newMonthValue: newMonthValue); self.value.date.monthUTC = newMonthValue }
        .onChange(of: self.year  ) { newYearValue   in self.fixDay(newYearValue : newYearValue ); self.value.date.yearUTC  = newYearValue }
    }

    private func fixDay(newMonthValue: Int? = nil, newYearValue: Int? = nil) {
        if let daysInMonth = Date.daysInMonth(month: newMonthValue ?? self.month, year: newYearValue ?? self.year) {
            if (self.day > daysInMonth) {
                self.day = daysInMonth
                self.value.date.dayUTC = self.day
            }
        }
    }

    private struct FieldList: View {
        @Binding public var toValue: Int
        public var items: [Int: String]
        var body: some View {
            Picker("", selection: self.$toValue) {
                ForEach(Array(self.items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).enumerated()), id: \.element.key) { index, element in
                    Text("\(String(element.value))").tag(element.key)
                }
            }
        }
    }

    private struct FieldTimeZone: View {
        @Binding public var toValue: String
        var body: some View {
            Picker("", selection: self.$toValue) {
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

