import Foundation
import Commander
import Rainbow

let POEditorAPIURL = "https://api.poeditor.com/v2"

command(
    Argument<String>("APITOKEN", description: "The POEditor API token"),
    Argument<Int>("id", description: "The id of the project in POEditor"),
    Argument<String>("language", description: "The language code in POEditor"),
    Option<String>("swiftfile", default: "Sources/Literals.swift", description: "The output Swift file directory."),
    Option<String>("stringsfile", default: "Sources/Localizable.strings", description: "The output Strings file directory."),
    Option<String>("typename", default: "Literals", description: "The type name that store all localized vars"),
    Option<OutputFormat>("outputformat", default: .struct, description: "The output format for swift file (enum or struct)"),
    Option<KeysFormat>("keysformat", default: .upperCamelCase, description: "The format for the localized key")
) { (token: String,
     id: Int,
     language: String,
     swiftFile: String,
     stringsFile: String,
     typeName: String,
     outputFormat: OutputFormat,
     keysFormat: KeysFormat) in

    let program = Program()
    try program.run(token: token,
                    id: id,
                    language: language,
                    swiftFile: swiftFile,
                    stringsFile: stringsFile,
                    typeName: typeName,
                    outputFormat: outputFormat,
                    keysFormat: keysFormat)

}.run()
