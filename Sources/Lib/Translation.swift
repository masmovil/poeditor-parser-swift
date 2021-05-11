import Foundation

let localizedStringFunction = "NSLocalizedString"
public struct Translation {
    let rawKey: String
    let rawValue: String

    let localizedValue: String
    let variables: [Variable]

    init(rawKey: String, rawValue: String) throws {
        self.rawKey = rawKey
        self.rawValue = rawValue

        // Parse translationValue
        (localizedValue, variables) = try TranslationValueParser.parseTranslationValue(translationValue: rawValue)
    }

    private var prettyKey: String {
        return rawKey.capitalized.replacingOccurrences(of: "_", with: "")
    }

    var swiftCode: String {
        if variables.isEmpty {
            return generateVariableLessSwiftCode()
        } else {
            return generateVariableSwiftCode()
        }
    }

    var swiftKey: String {
        return "\tpublic static let \(prettyKey) = \"\(rawKey)\"\n\tpublic let \(prettyKey) = \"\(rawKey)\"\n"
    }

    private func generateVariableLessSwiftCode() -> String {
        /*
         static var Welcome: String {
         return NSLocalizedString()
         }
         */
        return "\tpublic static var \(prettyKey): String {\n\t\treturn \(localizedStringFunction)(keys.\(prettyKey), comment: \"\")\n\t}\n"
    }

    private func generateVariableSwiftCode() -> String {
        /*
         static func ReadBooksKey(readNumber: Int) -> String {
         return ""
         }
         */
        let parameters = variables
            .map { $0.type.swiftParameter(key: $0.parameterKey) }
            .joined(separator: ", ")
        let localizedArguments = variables
            .map { $0.parameterKey }
            .map { $0.snakeCased() }
            .joined(separator: ", ")
        return "\tpublic static func \(prettyKey)(\(parameters)) -> String {\n\t\treturn String(format: \(localizedStringFunction)(keys.\(prettyKey), comment: \"\"), \(localizedArguments))\n\t}\n"
    }
}
