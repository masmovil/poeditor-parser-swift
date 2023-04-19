import Foundation

extension URLSession {
    func syncDataTask(with request: URLRequest) throws -> Data {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = self.dataTask(with: request) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        if let error = error {
            throw error
        }
        if let data = data, let _ = response {
            return data
        }
        throw NSError(domain: "WTF", code: 69, userInfo: nil)
    }
}

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
