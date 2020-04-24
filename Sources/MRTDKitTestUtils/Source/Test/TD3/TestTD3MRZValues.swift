import Foundation

public struct TestTD3MRZValues: TestTD3MRZFields {

    public static let validTD3Line1: String = "P<AIAERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<"
    public static let validTD3Line2: String = "D231458907AIA7408122F1204159<<<<<<<<<<<<<<06"

    public static let documentCode: String = "P"
    public static let optionalData: String = "<<<<<<<<<<<<<<"
    public static let optionalDataCheckDigit: Character = Character("0")
    public static let compositeCheckDigit: Character = Character("6")

}
