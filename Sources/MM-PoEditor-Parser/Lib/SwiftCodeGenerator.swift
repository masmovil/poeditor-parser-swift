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
        case .struct:
            generatedResult += POEConstants.literalsStructHeader(name: typeName)
            for (index, translation) in translations.enumerated() {
                generatedResult += translation.swiftStaticFuncCode
                if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
            }
            generatedResult += POEConstants.literalsStructFooter
            
        case .enum:
            generatedResult += POEConstants.literalsEnumHeader(keysName: typeName)
            for (index, translation) in translations.enumerated() {
                generatedResult += translation.swiftEnumCaseCode
                if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
            }
            generatedResult += POEConstants.methodOrVariableSeparator
            generatedResult += POEConstants.methodOrVariableSeparator

            generatedResult += POEConstants.literalsEnumValueFuncStart
            for (index, translation) in translations.enumerated() {
                generatedResult += translation.swiftEnumCaseForValue
                if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
            }
            generatedResult += POEConstants.literalsEnumValueFuncEnd

            generatedResult += POEConstants.methodOrVariableSeparator

            generatedResult += POEConstants.literalsEnumStringKeyStart
            for (index, translation) in translations.enumerated() {
                generatedResult += translation.swiftEnumCaseForKey
                if index < translations.count - 1 { generatedResult += POEConstants.methodOrVariableSeparator }
            }
            generatedResult += POEConstants.literalsEnumStringKeyEnd

            generatedResult += POEConstants.literalsEnumFooter
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
        case .struct:
            fileHandle += POEConstants.literalsStructHeader(name: typeName)
            for (index, translation) in translations.enumerated() {
                fileHandle += translation.swiftStaticFuncCode
                if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
            }
            fileHandle += POEConstants.literalsStructFooter
            
        case .enum:
            fileHandle += POEConstants.literalsEnumHeader(keysName: typeName)
            for (index, translation) in translations.enumerated() {
                fileHandle += translation.swiftEnumCaseCode
                if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
            }
            fileHandle += POEConstants.methodOrVariableSeparator
            fileHandle += POEConstants.methodOrVariableSeparator
            
            fileHandle += POEConstants.literalsEnumValueFuncStart
            for (index, translation) in translations.enumerated() {
                fileHandle += translation.swiftEnumCaseForValue
                if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
            }
            fileHandle += POEConstants.literalsEnumValueFuncEnd
            
            fileHandle += POEConstants.methodOrVariableSeparator

            fileHandle += POEConstants.literalsEnumStringKeyStart
            for (index, translation) in translations.enumerated() {
                fileHandle += translation.swiftEnumCaseForKey
                if index < translations.count - 1 { fileHandle += POEConstants.methodOrVariableSeparator }
            }
            fileHandle += POEConstants.literalsEnumStringKeyEnd
            
            fileHandle += POEConstants.literalsEnumFooter
        }

        fileHandle += POEConstants.fileFooter

        fileHandle.closeFile()
    }
}
