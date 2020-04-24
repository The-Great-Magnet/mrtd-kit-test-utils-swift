import Foundation

struct TestMRVAMRZValues: TestMRVAMRZFields {

    static let validMRVALine1: String = "V<AIAERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<"
    static let validMRVALine2: String = "D231458907AIA7408122F1204159<<<<<<<<<<<<<<<<"

    static let documentCode: String = "V"
    static let optionalData: String = "<<<<<<<<<<<<<<<<"
}
