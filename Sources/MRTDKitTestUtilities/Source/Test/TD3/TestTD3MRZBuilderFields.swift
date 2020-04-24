import Foundation

protocol TestTD3MRZBuilderFields {

    var documentCode: String? { get set }
    var optionalData: String? { get set }
    var optionalDataCheckDigit: Character? { get set }
    var compositeCheckDigit: Character? { get set }

}
