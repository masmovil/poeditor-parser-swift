import Foundation

enum VariableType {
    case numeric
    case textual
}

extension VariableType {
    var localizedRepresentation: String {
        switch self {
        case .numeric: return "%d"
        case .textual: return "%@"
        }
    }

    // Analyzes the string to match an appropriate VariableType
    init(string: String) {
        let str = string.lowercased()
        let variablesForNumbersThatShouldBeAnString = ["line_number", "phone_number"]
        let tests = [ { str.contains("number") && variablesForNumbersThatShouldBeAnString.filter(str.contains).isEmpty }]

        for test in tests where test() {
            self = .numeric
            return
        }

        self = .textual
    }
}

extension VariableType {
    private var swiftType: String {
        switch self {
        case .numeric: return "Int" // TODO: Decimal types?
        case .textual: return "String"
        }
    }

    func swiftParameter(key: String) -> String {
        return key.snakeCased() + ": " + swiftType
    }
}
