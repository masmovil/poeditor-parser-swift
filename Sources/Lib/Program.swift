import Foundation

class Program {
    func run(token: String, id: Int, language: String, swiftfile: String, stringsfile: String) throws {
        do {
            print("ℹ️  Fetching contents of strings at POEditor...".blue)
            print("🔄 Querying POEditor for the latest strings file...".magenta)
            var request = URLRequest(url: URL(string: "\(POEditorAPIURL)/projects/export")!)
            request.httpMethod = "POST"
            let parameters = ""
                + "api_token=\(token)&"
                + "id=\(id)&"
                + "language=\(language)&"
                + "type=apple_strings"
            request.httpBody = parameters.data(using: .utf8)
            let data = try URLSession.shared.syncDataTask(with: request)
            guard
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let result = json["result"] as? [String: Any],
                let urlString = result["url"] as? String,
                let url = URL(string: urlString)
            else {
                throw AppError.apiCouldNotFetchDownloadUrlError
            }
            print("✅ Successfully got the latest URL for the strings file from POEditor".green)

            print("🔄 Downloading the latest strings file from POEditor...".magenta)
            let downloadRequest = URLRequest(url: url)
            let downloadData = try URLSession.shared.syncDataTask(with: downloadRequest)
            guard let translationString = NSString(data: downloadData, encoding: String.Encoding.utf8.rawValue) as String? else {
                throw AppError.apiDownloadTermsError
            }
            print("✅ Successfully downloaded the latest strings file from POEditor!".green)

            print("ℹ️  Parsing strings file...".blue)
            let parser = StringTranslationParser(translation: translationString)
            let translations = try parser.parse()

            FileManager.default.createFile(atPath: swiftfile, contents: nil, attributes: nil)
            guard let swiftHandle = FileHandle(forWritingAtPath: swiftfile) else {
                throw AppError.writeFileError(file: swiftfile)
            }
            let fileCodeGenerator = FileCodeGenerator(fileHandle: swiftHandle)
            fileCodeGenerator.generateCode(translations: translations)
            print("✅ Success! Literals generated at \(swiftfile)".green)

            FileManager.default.createFile(atPath: stringsfile, contents: nil, attributes: nil)
            guard let stringsHandle = FileHandle(forWritingAtPath: stringsfile) else {
                throw AppError.writeFileError(file: stringsfile)
            }
            let stringsFileGenerator = StringsFileGenerator(fileHandle: stringsHandle)
            stringsFileGenerator.generateCode(translations: translations)
            print("✅ Success! Strings generated at \(stringsfile)".green)

        } catch let error {
            print("❌ [ERROR] \(error.localizedDescription)".red)
            throw error
        }
    }
}
