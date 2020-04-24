import Foundation

public protocol CommonMRZValues {

    static var issuingState: String { get }
    static var primaryIdentifier: String { get }
    static var secondaryIdentifier: String { get }
    static var documentNumber: String { get }
    static var documentNumberCheckDigit: Character { get }
    static var nationality: String { get }
    static var dateOfBirth: String { get }
    static var dateOfBirthCheckDigit: Character { get }
    static var sex: Character { get }
    static var dateOfExpiry: String { get }
    static var dateOfExpiryCheckDigit: Character { get }

}
