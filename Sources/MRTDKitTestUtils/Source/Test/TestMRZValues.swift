import Foundation
import MRTDKitSpec
import MRTDKitCore

public struct TestMRZValues: CommonMRZValues {

    public static let issuingState: String = ISO3166Country.AIA.localeDetails.alpha3Code
    public static let primaryIdentifier: String = "ERIKSSON"
    public static let secondaryIdentifier: String = "ANNA<MARIA"
    public static let documentNumber: String = "D23145890"
    public static let documentNumberCheckDigit: Character = Character("7")
    public static let nationality: String = ISO3166Country.AIA.localeDetails.alpha3Code
    public static let dateOfBirth: String = MRZDateUtility.mrzStringFromDate(
            temporal: FullDate(year: 1974, month: 8, dayOfMonth: 12))
    public static let dateOfBirthCheckDigit: Character = Character("2")
    public static let sex: Character = Sex.female.mrzValue
    public static let dateOfExpiry: String = MRZDateUtility.mrzStringFromDate(
            temporal: FullDate(year: 2012, month: 4, dayOfMonth: 15))
    public static let dateOfExpiryCheckDigit: Character = Character("9")

}
