
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

extension Date {

    enum Format: String {
        case iso8601         = "yyyy-MM-dd HH:mm:ss"
        case iso8601Timezone = "yyyy-MM-dd HH:mm:ss Z"
        case iso8601Mono     = "yyyyMMdd_HHmmss"
        case convenientDate  = "d MMM yyyy"
        case convenientTime  = "HH:mm:ss"
    }

    init?(iso8601: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = Format.iso8601.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let date = formatter.date(from: iso8601) {
            self = date
        } else {
            return nil
        }
    }

    var formatConvenient: String {
        let formatter = DateFormatter()
        formatter.dateFormat = String(
            format: NSLocalizedString("%@ 'at' %@", comment: ""),
            Self.Format.convenientDate.rawValue,
            Self.Format.convenientTime.rawValue )
        return formatter.string(from: self)
    }

    var formatISO8601tz: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Self.Format.iso8601Timezone.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }

    var formatISO8601tzUTC: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Self.Format.iso8601Timezone.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: self)
    }

    var formatISO8601Mono: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Self.Format.iso8601Mono.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let mSec = Int(Self().timeIntervalSince1970.fractionalPart * 1_000)
        return formatter.string(from: self) + "-\(mSec)"
    }

    public func toNewTimeZone(offset seconds: Int) -> Self {
        self.addingTimeInterval(TimeInterval(seconds))
    }

    var dayUTC   : Int { get { Self.UTCCalendar.component(.day   , from: self) } set { self._updateComponent(day   : newValue) } }
    var monthUTC : Int { get { Self.UTCCalendar.component(.month , from: self) } set { self._updateComponent(month : newValue) } }
    var yearUTC  : Int { get { Self.UTCCalendar.component(.year  , from: self) } set { self._updateComponent(year  : newValue) } }
    var hourUTC  : Int { get { Self.UTCCalendar.component(.hour  , from: self) } set { self._updateComponent(hour  : newValue) } }
    var minuteUTC: Int { get { Self.UTCCalendar.component(.minute, from: self) } set { self._updateComponent(minute: newValue) } }
    var secondUTC: Int { get { Self.UTCCalendar.component(.second, from: self) } set { self._updateComponent(second: newValue) } }

    private static var UTCCalendar: Calendar {
        var result = Calendar(identifier: .gregorian)
        result.timeZone = TimeZone(secondsFromGMT: 0)!
        return result
    }

    private mutating func _updateComponent(
        day   : Int? = nil,
        month : Int? = nil,
        year  : Int? = nil,
        hour  : Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
    ) {
        var components = Self.UTCCalendar.dateComponents([
            .day, .month, .year, .hour, .minute, .second
        ], from: self)

        if let day    { components.day    = day }
        if let month  { components.month  = month }
        if let year   { components.year   = year }
        if let hour   { components.hour   = hour }
        if let minute { components.minute = minute }
        if let second { components.second = second }

        if let newDate = Self.UTCCalendar.date(from: components) {
            self = newDate
        }
    }

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

}
