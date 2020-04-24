import Foundation
import MRTDKitSpec
import MRTDKitCore

public class TestMRVBMRZBuilder: TestMRZBuilder, TestMRVBMRZBuilderFields {

    public let mrtdDescriptor: MRTDDescriptor = MRVBDescriptor.init()

    public var documentCode: String?

    public var issuingState: String?
    public var primaryIdentifier: String?
    public var secondaryIdentifier: String?
    public var documentNumber: String?
    public var documentNumberCheckDigit: Character?
    public var nationality: String?
    public var dateOfBirth: String?
    public var dateOfBirthCheckDigit: Character?
    public var sex: Character?
    public var dateOfExpiry: String?
    public var dateOfExpiryCheckDigit: Character?

    public var optionalData: String?
    
    public init() {
        
    }

    public func aValidMRZ() -> TestMRVBMRZBuilder {

        let copy = self

        copy.documentCode = TestMRVBMRZValues.documentCode
        copy.issuingState = TestMRZValues.issuingState
        copy.primaryIdentifier = TestMRZValues.primaryIdentifier
        copy.secondaryIdentifier = TestMRZValues.secondaryIdentifier
        copy.documentNumber = TestMRZValues.documentNumber
        copy.documentNumberCheckDigit = TestMRZValues.documentNumberCheckDigit
        copy.nationality = TestMRZValues.nationality
        copy.dateOfBirth = TestMRZValues.dateOfBirth
        copy.dateOfBirthCheckDigit = TestMRZValues.dateOfBirthCheckDigit
        copy.sex = TestMRZValues.sex
        copy.dateOfExpiry = TestMRZValues.dateOfExpiry
        copy.dateOfExpiryCheckDigit = TestMRZValues.dateOfExpiryCheckDigit
        copy.optionalData = TestMRVBMRZValues.optionalData

        return copy

    }

    public func build(recalculateCheckDigits: Bool) -> MRZ {

        var documentCode = self.documentCode ?? ""
        while documentCode.count < 2 {
            documentCode.append("<")
        }

        let issuingState = self.issuingState ?? "<<<"
        let primaryIdentifier = self.primaryIdentifier ?? ""
        let secondaryIdentifier = self.secondaryIdentifier ?? ""

        var line1 = "\(documentCode)\(issuingState)\(primaryIdentifier)<<\(secondaryIdentifier)"

        var documentNumber = self.documentNumber ?? ""
        if documentNumber.count > 9 {
            documentNumber = String(documentNumber.prefix(9))
        }

        let docNumberCheckDigit = self.documentNumberCheckDigit ?? "<"
        let nationality = self.nationality ?? "<<<"
        let dateOfBirth = self.dateOfBirth ?? "<<<<<<"
        let dateOfBirthCheckDigit = self.dateOfBirthCheckDigit ?? "<"
        let sex = self.sex ?? "<"
        let dateOfExpiry = self.dateOfExpiry ?? "<<<<<<"
        let dateOfExpiryCheckDigit = self.dateOfBirthCheckDigit ?? "<"
        let optionalData = self.optionalData ?? ""

        var line2 = """
                    \(documentNumber)\(String(docNumberCheckDigit))\(nationality)\(dateOfBirth)\(dateOfBirthCheckDigit)\(String(sex))\(dateOfExpiry)\(dateOfExpiryCheckDigit)\(optionalData)
                    """

        while line1.count < mrtdDescriptor.mrzDescriptor.mrtdSize.mrzLineLength {
            line1.append("<")
        }

        if recalculateCheckDigits {

            let docNumberRange = StringUtils.stringIndexRangeFromIntRange(
                    range: mrtdDescriptor.mrzDescriptor.docNumberCheckDigitDescriptor.characterRange, string: line2)

            line2 =
                    line2.replacingCharacters(in: docNumberRange,
                            with: String(try! CheckDigitUtility.checkDigitForString(value: documentNumber)))

            let dobRange = StringUtils.stringIndexRangeFromIntRange(
                    range: mrtdDescriptor.mrzDescriptor.dobCheckDigitDescriptor.characterRange, string: line2)

            line2 =
                    line2.replacingCharacters(in: dobRange,
                            with: String(try! CheckDigitUtility.checkDigitForString(value: dateOfBirth)))

            let expiryDateRange = StringUtils.stringIndexRangeFromIntRange(
                    range: mrtdDescriptor.mrzDescriptor.dateOfExpCheckDigitDescriptor.characterRange, string: line2)

            line2 =
                    line2.replacingCharacters(in: expiryDateRange,
                            with: String(try! CheckDigitUtility.checkDigitForString(value: dateOfExpiry)))

        }

        try! checkLineLength(lines: [line1, line2])

        return MRZ(lines: [MRZLine(stringValue: line1), MRZLine(stringValue: line2)])

    }

}
