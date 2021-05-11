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

    static let literalsObjectHeader = "public class Literals {\n"
    static let literalsObjectFooter = "\n\tpublic static let keys = LiteralsKeys()\n}\n"
    static let literalsKeysObjectHeader = "public class LiteralsKeys {\n"
    static let literalsKeysObjectFooter = "}\n"

    static let fileFooter = "\n//swiftlint:enable all\n"

    static let methodOrVariableSeparator = "\n"
}
