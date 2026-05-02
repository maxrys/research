
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

    @Binding private var value: Date?

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
        value: Binding<Date?>,
        yearMinValue: Int = 1970,
        yearMaxValue: Int = 2050
    ) {
        self._value = value
        self.day    = (value.wrappedValue ?? Date()).day
        self.month  = (value.wrappedValue ?? Date()).month
        self.year   = (value.wrappedValue ?? Date()).year
        self.hour   = (value.wrappedValue ?? Date()).hour
        self.minute = (value.wrappedValue ?? Date()).minute
        self.second = (value.wrappedValue ?? Date()).second
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

                Picker("", selection: self.$day) {
                    ForEach(1 ... 31, id: \.self) { dayNumber in
                        Text("\(String(dayNumber))")
                    }
                }.frame(width: 60)

                Picker("", selection: self.$month) {
                    ForEach(1 ... 12, id: \.self) { monthNumber in
                        if let monthName = Self.MONTH_NAMES[monthNumber]
                             { Text("\(monthName)") }
                        else { Text("\(String(monthNumber))") }
                    }
                }.frame(width: 120)

                Picker("", selection: self.$year) {
                    ForEach(self.yearMinValue ... self.yearMaxValue, id: \.self) { yearNumber in
                        Text("\(String(yearNumber))")
                    }
                }.frame(width: 72)

            }

            Text(NSLocalizedString("Time", comment: ""))
                .font(.headline)

            HStack(spacing: 0) {

                Picker("", selection: self.$hour) {
                    ForEach(0 ... 23, id: \.self) { hourNumber in
                        Text("\(String(hourNumber))")
                    }
                }.frame(width: 60)

                Picker("", selection: self.$minute) {
                    ForEach(0 ... 59, id: \.self) { minuteNumber in
                        Text("\(String(minuteNumber))")
                    }
                }.frame(width: 60)

                Picker("", selection: self.$second) {
                    ForEach(0 ... 59, id: \.self) { secondNumber in
                        Text("\(String(secondNumber))")
                    }
                }.frame(width: 60)

            }

            Text(NSLocalizedString("TimeZone", comment: ""))
                .font(.headline)

            Picker("", selection: self.$zone) {
                ForEach(0 ... 12, id: \.self) { timeZoneNumber in
                    Text("\(String(timeZoneNumber))")
                }
            }.frame(width: 180)

            Text("")

            Group {
                if let value = self.value {
                    Text("\(value.formatISO8601withTZ)")
                } else {
                    Text(NSLocalizedString("n/a", comment: ""))
                }
            }
            .font(.system(size: 12))
            .padding(.leading, 10)
            .opacity(0.5)

        }
        .onChange(of: self.day   ) { newDay    in }
        .onChange(of: self.month ) { newMonth  in }
        .onChange(of: self.year  ) { newYear   in }
        .onChange(of: self.hour  ) { newHour   in }
        .onChange(of: self.minute) { newMinute in }
        .onChange(of: self.second) { newSecond in }
        .onChange(of: self.zone  ) { newZone   in }
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

