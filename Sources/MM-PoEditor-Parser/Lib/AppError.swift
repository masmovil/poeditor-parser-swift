import Foundation

public enum AppError: Error, LocalizedError {
    case misspelledTerm(term: String, translation: String)
    case writeFileError(file: String)
    case apiDownloadTermsError
    case apiConnectError

    public var errorDescription: String? {
        switch self {
        case .misspelledTerm(let key, let value):
            return "Misspelled term: \(key) = \(value)"
        case .writeFileError(let file):
            return "Couldn't write to file located at: \(file)"
        case .apiDownloadTermsError:
            return "Could not download terms from API: Check internet connection"
        case .apiConnectError:
            return "Could not connect to PoEditor API: Check Token or internet connection"
        }
    }
}
