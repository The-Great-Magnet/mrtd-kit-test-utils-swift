import Foundation

protocol TestTD3MRZFields {

    static var documentCode: String { get }
    static var optionalData: String { get }
    static var optionalDataCheckDigit: Character { get }
    static var compositeCheckDigit: Character { get }

}
