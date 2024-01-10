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

    static let version = "1.9.3"

    static func literalsStructHeader(name: String) -> String { "public struct \(name) {\n" }
    static func literalsStructStaticTableName(name: String?) -> String {
        if let name {
            return "\tpublic static let tableName: String? = \"\(name)\"\n\n"
        }
        return "\tpublic static let tableName: String? = nil\n\n"
    }
    static let literalsStructFooter = "}\n"
    static func literalsEnumHeader(keysName: String) -> String { "public enum \(keysName) {\n" }
    static let literalsEnumStringKeyStart = "\tpublic var key: String {\n\t\tswitch(self) {\n"
    static let literalsEnumStringKeyEnd = "\t\t}\n\t}\n"
    static let literalsEnumValueFuncStart = "\tpublic func parsed(value: String) -> String {\n\t\tswitch(self) {\n"
    static let literalsEnumValueFuncEnd = "\t\t}\n\t}\n"
    static let literalsEnumFooter = "}\n"
    static let literalsEnumDefaultCase = "\n\t\t// Add unneeded default to avoid error: `The compiler is unable to check that this switch is exhaustive in reasonable time`\n\t\t// Sorry for the warning, you may consider to use Struct type instead\n\t\tdefault: fatalError()\n"

    static let fileFooter = "\n//swiftlint:enable all\n"

    static let methodOrVariableSeparator = "\n"
}
