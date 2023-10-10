import Foundation

enum POEConstants {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()

    static let fileHeader = """
    // Generated using MM-POEditorParser (\(version))
    // DO NOT EDIT
    // Generated: \(POEConstants.dateFormatter.string(from: Date()))

    // swiftlint:disable all

    import Foundation

    """

    static let version = "1.9.2"

    static func literalsStructHeader(name: String) -> String { "public struct \(name) {\n" }
    static let literalsStructFooter = "}\n"
    static func literalsEnumHeader(keysName: String) -> String { "public enum \(keysName) {\n" }
    static let literalsEnumStringKeyStart = "\tpublic var key: String {\n\t\tswitch(self) {\n"
    static let literalsEnumStringKeyEnd = "\n\t\t}\n\t}\n"
    static let literalsEnumValueFuncStart = "\tpublic func parsed(value: String) -> String {\n\t\tswitch(self) {\n"
    static let literalsEnumValueFuncEnd = "\n\t\t}\n\t}\n"
    static let literalsEnumFooter = "}\n"

    static let fileFooter = "\n//swiftlint:enable all\n"

    static let methodOrVariableSeparator = "\n"
}
