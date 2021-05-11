import Foundation

public enum AppError: Error, LocalizedError {
    case misspelledTerm(term: String)
    case writeFileError(file: String)
    case apiDownloadTermsError
    case apiCouldNotFetchDownloadUrlError

    public var errorDescription: String? {
        switch self {
        case .misspelledTerm(let term):
            return "Misspelled term: \(term)"
        case .writeFileError(let file):
            return "Couldn't write to file located at: \(file)"
        case .apiDownloadTermsError:
            return "Could not download terms from API!"
        case .apiCouldNotFetchDownloadUrlError:
            return "Could not recover download url from API!"
        }
    }
}
