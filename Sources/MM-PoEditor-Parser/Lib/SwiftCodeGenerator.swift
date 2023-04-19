import Foundation

public protocol SwiftCodeGenerator {
    func generateCode(translations: [Translation])
}

public class StringCodeGenerator: SwiftCodeGenerator {
    var generatedResult = ""

    public func generateCode(translations: [Translation]) {
        generatedResult += POEConstants.fileHeader

        generatedResult += POEConstants.literalsObjectHeader
        for (index, translation) in translations.enumerated() {
            generatedResult += translation.swiftCode
            if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
        }
        generatedResult += POEConstants.literalsObjectFooter

        generatedResult += POEConstants.methodOrVariableSeparator

        generatedResult += POEConstants.literalsKeysObjectHeader
        for (index, translation) in translations.enumerated() {
            generatedResult += translation.swiftKey
            if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
        }
        generatedResult += POEConstants.literalsKeysObjectFooter

        generatedResult += POEConstants.fileFooter
    }
}

public class FileCodeGenerator: SwiftCodeGenerator {
    let fileHandle: FileHandle

    public init(fileHandle: FileHandle) {
        self.fileHandle = fileHandle
    }

    public func generateCode(translations: [Translation]) {
        fileHandle += POEConstants.fileHeader

        fileHandle += POEConstants.literalsObjectHeader
        for (index, translation) in translations.enumerated() {
            fileHandle += translation.swiftCode
            if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
        }
        fileHandle += POEConstants.literalsObjectFooter

        fileHandle += POEConstants.methodOrVariableSeparator

        fileHandle += POEConstants.literalsKeysObjectHeader
        for (index, translation) in translations.enumerated() {
            fileHandle += translation.swiftKey
            if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
        }
        fileHandle += POEConstants.literalsKeysObjectFooter

        fileHandle += POEConstants.fileFooter

        fileHandle.closeFile()
    }
}
