import Foundation

extension String {
    func replacingRegexMatches(of pattern: String, with replacing: String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacing)
    }

    var unescaped: String {
        let entities = ["\0", "\t", "\n", "\r", "\"", "\'", "\\"]
        var current = self
        for entity in entities {
            let descriptionCharacters = entity.dropFirst().dropLast()
            current = current.replacingOccurrences(of: descriptionCharacters, with: entity)
        }
        return current
    }

    var first: String {
        return String(prefix(1))
    }

    var lowercaseFirst: String {
        return first.lowercased() + String(dropFirst())
    }

    mutating func snakeCase() -> String {
        return self
            .split(separator: "_")  // split to components
            .map(String.init)   // convert subsequences to String
            .enumerated()  // get indices
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() } // added lowercasing
            .joined()
    }

    func snakeCased() -> String {
        return self
            .split(separator: "_")  // split to components
            .map(String.init)   // convert subsequences to String
            .enumerated()  // get indices
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() } // added lowercasing
            .joined()
    }
}

public func += (lhs: FileHandle, rhs: String) {
    lhs.write(rhs.data(using: .utf8)!)
}
