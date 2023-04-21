import Foundation

public protocol SwiftCodeGenerator {
    func generateCode(translations: [Translation])
}

public class StringCodeGenerator: SwiftCodeGenerator {
    var generatedResult = ""
    let structname: String
    let keysName: String
    
    public init(structname: String, keysName: String) {
        self.structname = structname
        self.keysName = keysName
    }
    
    public func generateCode(translations: [Translation]) {
        generatedResult += POEConstants.fileHeader

        generatedResult += POEConstants.literalsStructHeader(name: structname)
        for (index, translation) in translations.enumerated() {
            generatedResult += translation.swiftCode
            if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
        }
        generatedResult += POEConstants.literalsStructFooter(keysName: keysName)

        generatedResult += POEConstants.methodOrVariableSeparator

        generatedResult += POEConstants.literalsKeysHeader(keysName: keysName)
        for (index, translation) in translations.enumerated() {
            generatedResult += translation.swiftKey
            if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
        }
        generatedResult += POEConstants.literalsKeysFooter

        generatedResult += POEConstants.fileFooter
    }
}

public class FileCodeGenerator: SwiftCodeGenerator {
    let fileHandle: FileHandle
    let structname: String
    let keysName: String
    let onlyKeys: Bool

    public init(fileHandle: FileHandle, structname: String, keysName: String, onlyKeys: Bool) {
        self.fileHandle = fileHandle
        self.structname = structname
        self.keysName = keysName
        self.onlyKeys = onlyKeys
    }

    public func generateCode(translations: [Translation]) {
        fileHandle += POEConstants.fileHeader

        if !onlyKeys {
            fileHandle += POEConstants.literalsStructHeader(name: structname)
            for (index, translation) in translations.enumerated() {
                fileHandle += translation.swiftCode
                if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
            }
            fileHandle += POEConstants.literalsStructFooter(keysName: keysName)
        }

        fileHandle += POEConstants.methodOrVariableSeparator

        fileHandle += POEConstants.literalsKeysHeader(keysName: keysName)
        for (index, translation) in translations.enumerated() {
            fileHandle += translation.swiftKey
            if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
        }
        fileHandle += POEConstants.literalsKeysFooter

        fileHandle += POEConstants.fileFooter

        fileHandle.closeFile()
    }
}
