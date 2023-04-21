import Foundation
import Commander
import Rainbow

let POEditorAPIURL = "https://api.poeditor.com/v2"

command(
    Argument<String>("APITOKEN", description: "The POEditor API token"),
    Argument<Int>("id", description: "The id of the project"),
    Argument<String>("language", description: "The language code"),
    Option<String>("swiftfile", default: "Sources/Literals.swift", description: "The output Swift file directory."),
    Option<String>("stringsfile", default: "Sources/Localizable.strings", description: "The output Strings file directory."),
    Option<String>("structname", default: "Literals", description: "The struct name for localized vars"),
    Option<String>("keysname", default: "LiteralsKeys", description: "The enum with all localized keys values"),
    Option<KeysFormat>("keysformat", default: .upperCamelCase, description: "The format for the localized key"),
    Option<Bool>("onlykeys", default: false, description: "Indicate that only generate keys (without localized vars)")
) { (token: String,
     id: Int,
     language: String,
     swiftFile: String,
     stringsFile: String,
     structName: String,
     keysName: String,
     keysFormat: KeysFormat,
     onlyKeys: Bool) in
    
    let program = Program()
    try program.run(token: token,
                    id: id,
                    language: language,
                    swiftFile: swiftFile,
                    stringsFile: stringsFile,
                    structName: structName,
                    keysName: keysName,
                    keysFormat: keysFormat,
                    onlyKeys: onlyKeys)
    
}.run()

extension Bool: ArgumentConvertible {
    public init(parser: ArgumentParser) throws {
        guard let value = parser.shift() else {
            throw ArgumentError.missingValue(argument: nil)
        }

        switch value.lowercased() {
        case "true", "yes", "si", "1":
            self = true
        
        case "false", "no", "0":
            self = false
            
        default:
            throw ArgumentError.invalidType(value: value, type: "boolean", argument: nil)
        }
    }
}
