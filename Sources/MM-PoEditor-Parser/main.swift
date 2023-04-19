import Foundation
import Commander
import Rainbow

let POEditorAPIURL = "https://api.poeditor.com/v2"

command(
    Argument<String>("APITOKEN", description: "The POEditor API token"),
    Argument<Int>("id", description: "The id of the project"),
    Argument<String>("language", description: "The language code"),
    Option<String>("swiftfile", default: "${SRCROOT}/${TARGET_NAME}/Literals.swift", description: "The output Swift file directory."),
    Option<String>("stringsfile", default: "${SRCROOT}/${TARGET_NAME}/Localizable.strings", description: "The output Strings file directory.")
) { (token: String, id: Int, language: String, swiftfile: String, stringsfile: String) in
    let program = Program()
    try program.run(token: token, id: id, language: language, swiftfile: swiftfile, stringsfile: stringsfile)
}.run()
