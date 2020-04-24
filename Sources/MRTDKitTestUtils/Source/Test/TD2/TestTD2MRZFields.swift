import Foundation

public protocol TestTD2MRZFields {

    static var documentCode: String { get }
    static var optionalData: String { get }
    static var compositeCheckDigit: Character { get }

}
