import Foundation
import MRTDKitSpec
import MRTDKitCore

struct TestMRZValues: CommonMRZValues {

    static let issuingState: String = ISO3166Country.AIA.localeDetails.alpha3Code
    static let primaryIdentifier: String = "ERIKSSON"
    static let secondaryIdentifier: String = "ANNA<MARIA"
    static let documentNumber: String = "D23145890"
    static let documentNumberCheckDigit: Character = Character("7")
    static let nationality: String = ISO3166Country.AIA.localeDetails.alpha3Code
    static let dateOfBirth: String = MRZDateUtility.mrzStringFromDate(
            temporal: FullDate(year: 1974, month: 8, dayOfMonth: 12))
    static let dateOfBirthCheckDigit: Character = Character("2")
    static let sex: Character = Sex.female.mrzValue
    static let dateOfExpiry: String = MRZDateUtility.mrzStringFromDate(
            temporal: FullDate(year: 2012, month: 4, dayOfMonth: 15))
    static let dateOfExpiryCheckDigit: Character = Character("9")

}
