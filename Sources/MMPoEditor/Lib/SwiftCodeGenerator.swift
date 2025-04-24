import Foundation

public protocol SwiftCodeGenerator {
    func generateCode(translations: [Translation])
}

public class StringCodeGenerator: SwiftCodeGenerator {
    var generatedResult = ""
    let typeName: String
    let tableName: String?
    let outputFormat: OutputFormat

    public init(typeName: String, tableName: String?, outputFormat: OutputFormat) {
        self.typeName = typeName
        self.tableName = tableName
        self.outputFormat = outputFormat
    }

    public func generateCode(translations: [Translation]) {
        generatedResult += POEConstants.fileHeader

        switch outputFormat {
        case .struct:
            generatedResult += POEConstants.literalsStructHeader(name: typeName)
            generatedResult += POEConstants.literalsStructStaticTableName(name: tableName)
            for (_, translation) in translations.enumerated() {
                generatedResult += translation.swiftStaticFuncCode
                generatedResult += POEConstants.methodOrVariableSeparator
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
            for (_, translation) in translations.enumerated() {
                generatedResult += translation.swiftEnumCaseForValue
                generatedResult += POEConstants.methodOrVariableSeparator
            }
            if translations.count > 1_000 {
                generatedResult += POEConstants.literalsEnumDefaultCase
            }
            generatedResult += POEConstants.literalsEnumValueFuncEnd

            generatedResult += POEConstants.methodOrVariableSeparator

            generatedResult += POEConstants.literalsEnumStringKeyStart
            for (_, translation) in translations.enumerated() {
                generatedResult += translation.swiftEnumCaseForKey
                generatedResult += POEConstants.methodOrVariableSeparator
            }
            if translations.count > 1_000 {
                generatedResult += POEConstants.literalsEnumDefaultCase
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
    let tableName: String?
    let outputFormat: OutputFormat

    public init(fileHandle: FileHandle, typeName: String, tableName: String?, outputFormat: OutputFormat) {
        self.fileHandle = fileHandle
        self.typeName = typeName
        self.tableName = tableName
        self.outputFormat = outputFormat
    }

    public func generateCode(translations: [Translation]) {
        fileHandle += POEConstants.fileHeader

        switch outputFormat {
        case .struct:
            fileHandle += POEConstants.literalsStructHeader(name: typeName)
            fileHandle += POEConstants.literalsStructStaticTableName(name: tableName)
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
            for (_, translation) in translations.enumerated() {
                fileHandle += translation.swiftEnumCaseForValue
                fileHandle += POEConstants.methodOrVariableSeparator
            }
            if translations.count > 1_000 {
                fileHandle += POEConstants.literalsEnumDefaultCase
            }
            fileHandle += POEConstants.literalsEnumValueFuncEnd

            fileHandle += POEConstants.methodOrVariableSeparator

            fileHandle += POEConstants.literalsEnumStringKeyStart
            for (_, translation) in translations.enumerated() {
                fileHandle += translation.swiftEnumCaseForKey
                fileHandle += POEConstants.methodOrVariableSeparator
            }
            if translations.count > 1_000 {
                fileHandle += POEConstants.literalsEnumDefaultCase
            }
            fileHandle += POEConstants.literalsEnumStringKeyEnd

            fileHandle += POEConstants.literalsEnumFooter
        }

        fileHandle += POEConstants.fileFooter

        fileHandle.closeFile()
    }
}
