import Foundation

public struct TestTD2MRZValues: TestTD2MRZFields {

    public static let validTD2Line1: String = "I<AIAERIKSSON<<ANNA<MARIA<<<<<<<<<<<"
    public static let validTD2Line2: String = "D231458907AIA7408122F1204159<<<<<<<6"

    public static let documentCode: String = "I"
    public static let optionalData: String = "<<<<<<<"
    public static let compositeCheckDigit: Character = Character("6")

}
