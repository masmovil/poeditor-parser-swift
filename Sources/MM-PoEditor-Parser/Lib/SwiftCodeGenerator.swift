import Foundation

public protocol SwiftCodeGenerator {
    func generateCode(translations: [Translation])
}

public class StringCodeGenerator: SwiftCodeGenerator {
    var generatedResult = ""
    let typeName: String
    let outputFormat: OutputFormat
    
    public init(typeName: String, outputFormat: OutputFormat) {
        self.typeName = typeName
        self.outputFormat = outputFormat
    }
    
    public func generateCode(translations: [Translation]) {
        generatedResult += POEConstants.fileHeader

        switch outputFormat {
        case .structure:
            generatedResult += POEConstants.literalsStructHeader(name: typeName)
            for (index, translation) in translations.enumerated() {
                generatedResult += translation.swiftCode
                if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
            }
            generatedResult += POEConstants.literalsStructFooter
            
        case .enumerated:
            generatedResult += POEConstants.literalsKeysHeader(keysName: typeName)
            for (index, translation) in translations.enumerated() {
                generatedResult += translation.swiftKeyCase
                if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
            }
            generatedResult += POEConstants.methodOrVariableSeparator
            generatedResult += POEConstants.methodOrVariableSeparator
            generatedResult += POEConstants.literalsKeysComputedKeyStart
            for (index, translation) in translations.enumerated() {
                generatedResult += translation.swiftKeyValue
                if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
            }
            generatedResult += POEConstants.literalsKeysComputedKeyEnd
            generatedResult += POEConstants.literalsKeysFooter
        }

        generatedResult += POEConstants.fileFooter
    }
}

public class FileCodeGenerator: SwiftCodeGenerator {
    let fileHandle: FileHandle
    let typeName: String
    let outputFormat: OutputFormat

    public init(fileHandle: FileHandle, typeName: String, outputFormat: OutputFormat) {
        self.fileHandle = fileHandle
        self.typeName = typeName
        self.outputFormat = outputFormat
    }

    public func generateCode(translations: [Translation]) {
        fileHandle += POEConstants.fileHeader

        switch outputFormat {
        case .structure:
            fileHandle += POEConstants.literalsStructHeader(name: typeName)
            for (index, translation) in translations.enumerated() {
                fileHandle += translation.swiftCode
                if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
            }
            fileHandle += POEConstants.literalsStructFooter
            
        case .enumerated:
            fileHandle += POEConstants.literalsKeysHeader(keysName: typeName)
            for (index, translation) in translations.enumerated() {
                fileHandle += translation.swiftKeyCase
                if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
            }
            fileHandle += POEConstants.methodOrVariableSeparator
            fileHandle += POEConstants.methodOrVariableSeparator
            fileHandle += POEConstants.literalsKeysComputedKeyStart
            for (index, translation) in translations.enumerated() {
                fileHandle += translation.swiftKeyValue
                if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
            }
            fileHandle += POEConstants.literalsKeysComputedKeyEnd
            fileHandle += POEConstants.literalsKeysFooter
        }

        fileHandle += POEConstants.fileFooter

        fileHandle.closeFile()
    }
}
