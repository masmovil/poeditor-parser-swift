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
    Option<String>("structkeysname", default: "LiteralsKeys", description: "The struct name for localized keys"),
    Option<Bool>("onlyKeys", default: false, description: "Indicate that only generate keys (without localized vars)")
) { (token: String,
     id: Int,
     language: String,
     swiftfile: String,
     stringsfile: String,
     structname: String,
     structkeysname: String,
     onlyKeys: Bool) in
    
    let program = Program()
    try program.run(token: token,
                    id: id,
                    language: language,
                    swiftfile: swiftfile,
                    stringsfile: stringsfile,
                    structname: structname,
                    structkeysname: structkeysname,
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
