import Foundation
import MRTDKitSpec
import MRTDKitCore

public protocol TestMRZBuilder: CommonMRZBuilderFields {

    var mrtdDescriptor: MRTDDescriptor { get }

    func withAnInvalidIssuingState() -> TestMRZBuilder

    func withAnInvalidNationality() -> TestMRZBuilder

    func withAnInvalidSex() -> TestMRZBuilder

    func withAnInvalidDateOfBirth() -> TestMRZBuilder

    func withAnInvalidExpiryDate() -> TestMRZBuilder

    func build(recalculateCheckDigits: Bool) -> MRZ

}
