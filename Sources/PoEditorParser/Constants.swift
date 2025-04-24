import Foundation

let POEditorAPIURL = "https://api.poeditor.com/v2"

enum POEConstants {
    static let fileHeader = """
    // Generated using MM-POEditorParser (\(version))
    // DO NOT EDIT

    // swiftlint:disable all

    import Foundation

    """

    static let version = "2.0.3"

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
    static let literalsEnumDefaultCase = """
        // Add unneeded default to avoid error: `The compiler is unable to check that this switch is exhaustive in reasonable time`
        // Sorry for the warning, you may consider to use Struct type instead
        default: fatalError()
        """

    static let fileFooter = "\n//swiftlint:enable all\n"

    static let methodOrVariableSeparator = "\n"
}
