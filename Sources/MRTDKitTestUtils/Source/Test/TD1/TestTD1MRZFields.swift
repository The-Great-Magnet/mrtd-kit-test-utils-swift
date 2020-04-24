import Foundation

public protocol TestTD1MRZFields {

    static var documentCode: String { get }
    static var optionalData1: String { get }
    static var optionalData2: String { get }
    static var compositeCheckDigit: Character { get }

}
