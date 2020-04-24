import Foundation

struct TestTD2MRZValues: TestTD2MRZFields {

    static let validTD2Line1: String = "I<AIAERIKSSON<<ANNA<MARIA<<<<<<<<<<<"
    static let validTD2Line2: String = "D231458907AIA7408122F1204159<<<<<<<6"

    static let documentCode: String = "I"
    static let optionalData: String = "<<<<<<<"
    static let compositeCheckDigit: Character = Character("6")

}
