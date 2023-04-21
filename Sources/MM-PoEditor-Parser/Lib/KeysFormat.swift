import Foundation
import Commander

public enum KeysFormat: String, ArgumentConvertible {
    public init(parser: Commander.ArgumentParser) throws {
        guard let value = parser.shift() else {
            throw ArgumentError.missingValue(argument: nil)
        }
        
        guard let keysFormat = KeysFormat(rawValue: value) else {
            throw ArgumentError.invalidType(value: value, type: "KeysFormat", argument: nil)
        }
        
        self = keysFormat
    }
    
    public var description: String {
        switch self {
        case .lowerCamelCase:
            return "Lower Camel Case"

        case .upperCamelCase:
            return "Upper Camel Case"
        }
    }
    
    case lowerCamelCase
    case upperCamelCase
}
