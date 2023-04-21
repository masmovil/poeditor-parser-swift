import Foundation

let localizedStringFunction = "NSLocalizedString"
public struct Translation {
    let rawKey: String
    let rawValue: String
    let keysFormat: KeysFormat

    let localizedValue: String
    let variables: [Variable]

    init(rawKey: String, rawValue: String, keysFormat: KeysFormat) throws {
        self.rawKey = rawKey
        self.rawValue = rawValue
        self.keysFormat = keysFormat

        // Parse translationValue
        (localizedValue, variables) = try TranslationValueParser.parseTranslationValue(translationValue: rawValue)
    }

    private var prettyKey: String {
        switch keysFormat {
        case .upperCamelCase:
            return rawKey.capitalized.replacingOccurrences(of: "_", with: "")
            
        case .lowerCamelCase:
            return (rawKey.prefix(1).lowercased() + rawKey.capitalized.dropFirst())
                .replacingOccurrences(of: "_", with: "")
        }
    }

    var swiftCode: String {
        if variables.isEmpty {
            return generateFuncWithouVariables()
        } else {
            return generateFuncWithVariables()
        }
    }

    var swiftKeyCase: String {
        if variables.isEmpty {
            return "\tcase \(prettyKey)"
        }
        let parameters = variables
            .map { $0.type.swiftParameter(key: $0.parameterKey) }
            .joined(separator: ", ")

        return "\tcase \(prettyKey)(\(parameters))"
    }
    
    var swiftKeyValue: String {
        return "\t\tcase .\(prettyKey): return \"\(rawKey)\""
    }

    private func generateFuncWithouVariables() -> String {
        /*
         static var Welcome: String {
         return NSLocalizedString()
         }
         */
        return "\tpublic static var \(prettyKey): String {\n\t\treturn \(localizedStringFunction)(\"\(rawKey)\", comment: \"\")\n\t}\n"
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
        return "\tpublic static func \(prettyKey)(\(parameters)) -> String {\n\t\treturn \(localizedStringFunction)(\"\(rawKey)\", comment: \"\")\n\t\t\t\(localizedArguments)\n\t}\n"
    }
}
