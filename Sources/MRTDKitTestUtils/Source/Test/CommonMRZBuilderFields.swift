import Foundation

public protocol CommonMRZBuilderFields {

    var issuingState: String? { get set }
    var primaryIdentifier: String? { get set }
    var secondaryIdentifier: String? { get set }
    var documentNumber: String? { get set }
    var documentNumberCheckDigit: Character? { get set }
    var nationality: String? { get set }
    var dateOfBirth: String? { get set }
    var dateOfBirthCheckDigit: Character? { get set }
    var sex: Character? { get set }
    var dateOfExpiry: String? { get set }
    var dateOfExpiryCheckDigit: Character? { get set }

}
