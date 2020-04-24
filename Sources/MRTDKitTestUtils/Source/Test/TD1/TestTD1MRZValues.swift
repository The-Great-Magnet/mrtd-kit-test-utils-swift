import Foundation

struct TestTD1MRZValues: TestTD1MRZFields {

    static let validTD1Line1: String = "I<AIAD231458907<<<<<<<<<<<<<<<"
    static let validTD1Line2: String = "7408122F1204159AIA<<<<<<<<<<<6"
    static let validTD1Line3: String = "ERIKSSON<<ANNA<MARIA<<<<<<<<<<"

    static let documentCode: String = "I"
    static let optionalData1: String = "<<<<<<<<<<<<<<<"
    static let optionalData2: String = "<<<<<<<<<<<"
    static let compositeCheckDigit: Character = Character("6")

}
