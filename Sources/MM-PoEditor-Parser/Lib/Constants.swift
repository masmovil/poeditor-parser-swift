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
    // Generated using MM-POEditorParser
    // DO NOT EDIT
    // Generated: \(POEConstants.dateFormatter.string(from: Date()))

    // swiftlint:disable all

    import Foundation

    """

    static let version = "1.8.0"
    
    static func literalsStructHeader(name: String) -> String { "public struct \(name) {\n" }
    static let literalsStructFooter = "}\n"
    static func literalsKeysHeader(keysName: String) -> String { "public enum \(keysName) {\n" }
    static let literalsKeysComputedKeyStart = "\tvar i18nKey: String {\n\t\tswitch(self) {\n"
    static let literalsKeysComputedKeyEnd = "\n\t\t}\n\t}"
    static let literalsKeysFooter = "\n}\n"

    static let fileFooter = "\n//swiftlint:enable all\n"

    static let methodOrVariableSeparator = "\n"
}
