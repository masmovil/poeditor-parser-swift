import Foundation

class Program {
    func run(token: String,
             id: Int,
             language: String,
             swiftFile: String,
             stringsFile: String,
             structName: String,
             keysName: String,
             keysFormat: KeysFormat,
             onlyKeys: Bool) throws {
        do {
            print("🚀  Starting PoEditor Parser v\(POEConstants.version)".blue)
            print("-  Generating Swift: \(swiftFile)".white)
            print("-  Generating .strings: \(stringsFile)".white)
            print("-  Struct name: \(structName)".white)
            print("-  Keys name: \(keysName)".white)
            print("-  Keys format: \(keysFormat)".white)
            print("-  Only Keys: \(onlyKeys)".white)
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
            let parser = StringTranslationParser(translation: translationString,
                                                 keysName: keysName,
                                                 keysFormat: keysFormat)
            let translations = try parser.parse()

            FileManager.default.createFile(atPath: swiftFile, contents: nil, attributes: nil)
            guard let swiftHandle = FileHandle(forWritingAtPath: swiftFile) else {
                throw AppError.writeFileError(file: swiftFile)
            }
            let fileCodeGenerator = FileCodeGenerator(fileHandle: swiftHandle,
                                                      structname: structName,
                                                      keysName: keysName,
                                                      onlyKeys: onlyKeys)
            fileCodeGenerator.generateCode(translations: translations)
            print("✅ Success! Literals generated at \(swiftFile)".green)

            FileManager.default.createFile(atPath: stringsFile, contents: nil, attributes: nil)
            guard let stringsHandle = FileHandle(forWritingAtPath: stringsFile) else {
                throw AppError.writeFileError(file: stringsFile)
            }
            let stringsFileGenerator = StringsFileGenerator(fileHandle: stringsHandle)
            stringsFileGenerator.generateCode(translations: translations)
            print("✅ Success! Strings generated at \(stringsFile)".green)

        } catch let error {
            print("❌ [ERROR] \(error.localizedDescription)".red)
            throw error
        }
    }
}
