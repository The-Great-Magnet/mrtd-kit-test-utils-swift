import Foundation

public struct TestTD1MRZValues: TestTD1MRZFields {

    public static let validTD1Line1: String = "I<AIAD231458907<<<<<<<<<<<<<<<"
    public static let validTD1Line2: String = "7408122F1204159AIA<<<<<<<<<<<6"
    public static let validTD1Line3: String = "ERIKSSON<<ANNA<MARIA<<<<<<<<<<"

    public static let documentCode: String = "I"
    public static let optionalData1: String = "<<<<<<<<<<<<<<<"
    public static let optionalData2: String = "<<<<<<<<<<<"
    public static let compositeCheckDigit: Character = Character("6")

}
