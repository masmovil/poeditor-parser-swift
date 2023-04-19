import Foundation

public protocol SwiftCodeGenerator {
    func generateCode(translations: [Translation])
}

public class StringCodeGenerator: SwiftCodeGenerator {
    var generatedResult = ""
    let structname: String
    let structkeysname: String
    
    public init(structname: String, structkeysname: String) {
        self.structname = structname
        self.structkeysname = structkeysname
    }
    
    public func generateCode(translations: [Translation]) {
        generatedResult += POEConstants.fileHeader

        generatedResult += POEConstants.literalsStructHeader(name: structname)
        for (index, translation) in translations.enumerated() {
            generatedResult += translation.swiftCode
            if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
        }
        generatedResult += POEConstants.literalsStructFooter(keysName: structkeysname)

        generatedResult += POEConstants.methodOrVariableSeparator

        generatedResult += POEConstants.literalsKeysStructHeader(keysName: structkeysname)
        for (index, translation) in translations.enumerated() {
            generatedResult += translation.swiftKey
            if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
        }
        generatedResult += POEConstants.literalsKeysStructFooter

        generatedResult += POEConstants.fileFooter
    }
}

public class FileCodeGenerator: SwiftCodeGenerator {
    let fileHandle: FileHandle
    let structname: String
    let structkeysname: String
    let onlyKeys: Bool

    public init(fileHandle: FileHandle, structname: String, structkeysname: String, onlyKeys: Bool) {
        self.fileHandle = fileHandle
        self.structname = structname
        self.structkeysname = structkeysname
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
            fileHandle += POEConstants.literalsStructFooter(keysName: structkeysname)
        }

        fileHandle += POEConstants.methodOrVariableSeparator

        fileHandle += POEConstants.literalsKeysStructHeader(keysName: structkeysname)
        for (index, translation) in translations.enumerated() {
            fileHandle += translation.swiftKey
            if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
        }
        fileHandle += POEConstants.literalsKeysStructFooter

        fileHandle += POEConstants.fileFooter

        fileHandle.closeFile()
    }
}
