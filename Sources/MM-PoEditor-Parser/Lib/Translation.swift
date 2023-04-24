import Foundation

public struct Translation: Comparable {
    public let key: String
    public let value: String
    private let rawValue: String
    private let keysFormat: KeysFormat
    private let variables: [Variable]

    public init(key: String, rawValue: String, keysFormat: KeysFormat) throws {
        self.key = key
        self.rawValue = rawValue
        self.keysFormat = keysFormat

        // Parse translationValue
        (value, variables) = try TranslationValueParser.parseTranslationValue(translationValue: rawValue)
    }
    
    public var hasVariables: Bool {
        !variables.isEmpty
    }
    
    public var hasMoreThanOneVariable: Bool {
        variables.count > 1
    }

    public var swiftStaticFuncCode: String {
        if variables.isEmpty {
            return generateFuncWithoutVariables()
        } else {
            return generateFuncWithVariables()
        }
    }

    public var swiftEnumCaseCode: String {
        if variables.isEmpty {
            return "\tcase \(prettyKey)"
        }
        let parameters = variables
            .map { $0.type.swiftParameter(key: $0.parameterKey) }
            .joined(separator: ", ")

        return "\tcase \(prettyKey)(\(parameters))"
    }
    
    public var swiftEnumCaseForValue: String {
        if variables.isEmpty {
            return generateEnumCaseWithoutVariables()
        } else {
            return generateEnumCaseWithVariables()
        }
    }
    
    public var swiftEnumCaseForKey: String {
        return "\t\tcase .\(prettyKey): return \"\(key)\""
    }
    
    private var prettyKey: String {
        switch keysFormat {
        case .upperCamelCase:
            return key.capitalized.replacingOccurrences(of: "_", with: "")
            
        case .lowerCamelCase:
            return (key.prefix(1).lowercased() + key.capitalized.dropFirst())
                .replacingOccurrences(of: "_", with: "")
        }
    }

    private func generateEnumCaseWithoutVariables() -> String {
        return "\t\tcase .\(prettyKey): return value"
    }
    
    private func generateEnumCaseWithVariables() -> String {
        let parameters = variables
            .map { $0.type.swiftCaseParameter(key: $0.parameterKey) }
            .joined(separator: ", ")
        let localizedArguments = variables
            .map { variable in
                if variable.type != .textual {
                    let value = "String(format: \"\(variable.type.localizedRepresentation)\", \(variable.parameterKey.snakeCased()))"
                    return ".replacingOccurrences(of: \"{{\(variable.parameterKey)}}\", with: \(value))"
                }
                
                return ".replacingOccurrences(of: \"{{\(variable.parameterKey)}}\", with: \(variable.parameterKey.snakeCased()))"
            }
            .joined(separator: "\n\t\t\t")
        return "\t\tcase .\(prettyKey)(\(parameters)): return value\n\t\t\t\(localizedArguments)"
    }
    
    private func generateFuncWithoutVariables() -> String {
        /*
         static var Welcome: String {
         return NSLocalizedString()
         }
         */
        return "\tpublic static var \(prettyKey): String {\n\t\treturn NSLocalizedString(\"\(key)\", comment: \"\")\n\t}\n"
    }

    private func generateFuncWithVariables() -> String {
        /*
         static func ReadBooksKey(readNumber: Int) -> String {
         return ""
         }
         */
        let parameters = variables
            .map { $0.type.swiftParameter(key: $0.parameterKey) }
            .joined(separator: ", ")
        let localizedArguments = variables
            .map { variable in
                if variable.type != .textual {
                    let value = "String(format: \"\(variable.type.localizedRepresentation)\", \(variable.parameterKey.snakeCased()))"
                    return ".replacingOccurrences(of: \"{{\(variable.parameterKey)}}\", with: \(value))"
                }
                
                return ".replacingOccurrences(of: \"{{\(variable.parameterKey)}}\", with: \(variable.parameterKey.snakeCased()))"
            }
            .joined(separator: "\n\t\t\t")
        return "\tpublic static func \(prettyKey)(\(parameters)) -> String {\n\t\treturn NSLocalizedString(\"\(key)\", comment: \"\")\n\t\t\t\(localizedArguments)\n\t}\n"
    }
    
    public static func < (lhs: Translation, rhs: Translation) -> Bool {
        lhs.prettyKey < rhs.prettyKey
    }
    
    public static func == (lhs: Translation, rhs: Translation) -> Bool {
        lhs.prettyKey == rhs.prettyKey
    }
}
