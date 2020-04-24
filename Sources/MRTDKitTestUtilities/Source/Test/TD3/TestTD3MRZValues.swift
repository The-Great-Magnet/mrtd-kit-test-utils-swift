import Foundation

struct TestTD3MRZValues: TestTD3MRZFields {

    static let validTD3Line1: String = "P<AIAERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<"
    static let validTD3Line2: String = "D231458907AIA7408122F1204159<<<<<<<<<<<<<<06"

    static let documentCode: String = "P"
    static let optionalData: String = "<<<<<<<<<<<<<<"
    static let optionalDataCheckDigit: Character = Character("0")
    static let compositeCheckDigit: Character = Character("6")

}
