import Foundation

enum TranslationValueParser {
    static func parseTranslationValue(translationValue: String) throws -> (localizedDescription: String, variables: [Variable]) {
        let str = Scanner(string: translationValue)
        str.charactersToBeSkipped = nil

        /*
         Algorithm:
         
         1. Scan up to { into a buffer.
         ¿Scanned something?
         1.1 YES: Add that to the localizedString result
         2. Check if we are are at the end
         2.1 YES: we have finished. Go to END
         2.2 NO: Go to 3
         3. Scan for a number
         Found?
         3.1: YES: we need to take into account order. Go to 4
         3.2: NO: Go to 4
         4. Scan up to '}}' into a variable. Both adding it to the list and adding the localizedRepresentation to the localizedString result.
         5. Go to 1.
         
         END: Sort the variables array
         
         */
        var localizedString = ""
        var variables = [(order: Int, variable: Variable)]()

        while true {
            var out: NSString?
            str.scanUpTo("{", into: &out)

            if let outUwrapped = out {
                localizedString += outUwrapped as String
            }

            if str.isAtEnd {
                break
            }
            str.scanLocation += 1

            var intOut: Int32 = 0
            let intScanned = str.scanInt32(&intOut)

            if intScanned {
                // ordered var
            } else {
                //unordered var
            }

            if str.isAtEnd {
                throw AppError.misspelledTerm(term: translationValue)
            }
            str.scanLocation += 1

            var variableName: NSString?
            str.scanUpTo("}}", into: &variableName)

            // AssociateOrder if ordered
            let variable = Variable(rawKey: variableName! as String)
            localizedString += variable.type.localizedRepresentation
            variables.append((order: Int(intOut), variable: variable))

            if str.scanLocation + 2 > translationValue.count {
                throw AppError.misspelledTerm(term: translationValue)
            }
            str.scanLocation += 2 // Advance the '}}'
        }

        variables.sort(by: { $0.order < $1.order })
        let orderedVariables = variables.map { $0.variable }
        return (localizedString, orderedVariables)
    }
}
