import Foundation
import Commander

public enum OutputFormat: String, ArgumentConvertible {
    case enumerated
    case structure

    public init(parser: Commander.ArgumentParser) throws {
        guard let value = parser.shift() else {
            throw ArgumentError.missingValue(argument: nil)
        }
        
        guard let keysFormat = OutputFormat(rawValue: value) else {
            throw ArgumentError.invalidType(value: value, type: "OutputFormat", argument: nil)
        }
        
        self = keysFormat
    }
    
    public var description: String {
        switch self {
        case .enumerated:
            return "Enumerated"

        case .structure:
            return "Structure"
        }
    }
    
}
