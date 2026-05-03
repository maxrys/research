
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct DatePickerCustom: View {

    static public let MONTH_NAMES = [
         1: "January",
         2: "February",
         3: "March",
         4: "April",
         5: "May",
         6: "June",
         7: "July",
         8: "August",
         9: "September",
        10: "October",
        11: "November",
        12: "December",
    ]

    @Environment(\.colorScheme) private var colorScheme

    @Binding private var value: Date

    @State private var day: Int    /* 1 ... 31 */
    @State private var month: Int  /* 1 ... 12 */
    @State private var year: Int   /* 1970 ... 2050 */
    @State private var hour: Int   /* 0 ... 23 */
    @State private var minute: Int /* 0 ... 59 */
    @State private var second: Int /* 0 ... 59 */
    @State private var zone: Int

    private let yearMinValue: Int
    private let yearMaxValue: Int

    init(
        value: Binding<Date>,
        yearMinValue: Int = 1970,
        yearMaxValue: Int = 2050
    ) {
        self._value = value
        self.day    = value.wrappedValue.day
        self.month  = value.wrappedValue.month
        self.year   = value.wrappedValue.year
        self.hour   = value.wrappedValue.hour
        self.minute = value.wrappedValue.minute
        self.second = value.wrappedValue.second
        self.zone   = 0
        self.yearMinValue = yearMinValue
        self.yearMaxValue = yearMaxValue
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
                DatePickerCustom.FieldRange(
                    toValue: self.$day,
                    range: 1 ... 31
                ).frame(width: 60)

                DatePickerCustom.FieldList(
                    toValue: self.$month,
                    items: Self.MONTH_NAMES
                ).frame(width: 120)

                DatePickerCustom.FieldRange(
                    toValue: self.$year,
                    range: self.yearMinValue ... self.yearMaxValue
                ).frame(width: 72)
            }

            Text(NSLocalizedString("Time", comment: ""))
                .font(.headline)

            HStack(spacing: 0) {
                DatePickerCustom.FieldRange(
                    toValue: self.$hour,
                    range: 0 ... 23
                ).frame(width: 60)

                DatePickerCustom.FieldRange(
                    toValue: self.$minute,
                    range: 0 ... 59
                ).frame(width: 60)

                DatePickerCustom.FieldRange(
                    toValue: self.$second,
                    range: 0 ... 59
                ).frame(width: 60)
            }

            Text(NSLocalizedString("TimeZone", comment: ""))
                .font(.headline)

            DatePickerCustom.FieldZone(
                zone: self.$zone
            ).frame(width: 180)

            Text("")

            Text("\(value.formatISO8601withTZ)")
                .font(.system(size: 12))
                .padding(.leading, 10)
                .opacity(0.5)

        }
        .onChange(of: self.day   ) { newDayValue    in self.value.day    = newDayValue }
        .onChange(of: self.month ) { newMonthValue  in self.value.month  = newMonthValue }
        .onChange(of: self.year  ) { newYearValue   in self.value.year   = newYearValue }
        .onChange(of: self.hour  ) { newHourValue   in self.value.hour   = newHourValue }
        .onChange(of: self.minute) { newMinuteValue in self.value.minute = newMinuteValue }
        .onChange(of: self.second) { newSecondValue in self.value.second = newSecondValue }
        .onChange(of: self.zone  ) { newZoneValue   in }
    }

    private struct FieldRange: View {
        @Binding public var toValue: Int
        public var range: ClosedRange<Int>
        var body: some View {
            Picker("", selection: self.$toValue) {
                ForEach(self.range, id: \.self) { currentValue in
                    Text("\(String(currentValue))")
                }
            }
        }
    }

    private struct FieldList: View {
        @Binding public var toValue: Int
        public var items: [Int: String]
        var body: some View {
            Picker("", selection: self.$toValue) {
                ForEach(Array(self.items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).enumerated()), id: \.element.key) { index, element in
                    Text("\(String(element.value))")
                }
            }
        }
    }

    private struct FieldZone: View {
        @Binding public var zone: Int
        var body: some View {
            Picker("", selection: self.$zone) {
                ForEach(0 ... 12, id: \.self) { timeZoneValue in
                    Text("\(String(timeZoneValue))")
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
            value: .constant(Date())
        )
        .padding(20)
        .frame(width: 400)
    }
}

