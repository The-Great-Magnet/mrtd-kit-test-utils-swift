import Foundation
import MRTDKitSpec
import MRTDKitCore
import os.log

public class TestTD1MRZBuilder: TestMRZBuilder, TestTD1MRZBuilderFields {

    public let mrtdDescriptor: MRTDDescriptor = TD1Descriptor.init()

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

    public var optionalData1: String?
    public var optionalData2: String?
    public var compositeCheckDigit: Character?
    
    public init() {
        
    }

    public func aValidMRZ() -> TestTD1MRZBuilder {

        let copy = self

        copy.documentCode = TestTD1MRZValues.documentCode

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

        copy.optionalData1 = TestTD1MRZValues.optionalData1
        copy.optionalData2 = TestTD1MRZValues.optionalData2
        copy.compositeCheckDigit = TestTD1MRZValues.compositeCheckDigit

        return copy

    }

    public func build(recalculateCheckDigits: Bool) -> MRZ {

        var documentCode = self.documentCode ?? ""
        while documentCode.count < 2 {
            documentCode.append("<")
        }

        let issuingState = self.issuingState ?? "<<<"

        var optionalData1 = self.optionalData1 ?? ""
        if optionalData1.count < 15 {
            optionalData1.append("<")
        }

        var documentNumber = self.documentNumber ?? ""
        if documentNumber.count > 9 {
            documentNumber = String(documentNumber.prefix(9))
        }
        let docNumberCheckDigit = self.documentNumberCheckDigit ?? "<"

        var line1 = "\(documentCode)\(issuingState)\(documentNumber)\(docNumberCheckDigit)\(optionalData1)"

        let nationality = self.nationality ?? "<<<"
        let dateOfBirth = self.dateOfBirth ?? "<<<<<<"
        let dateOfBirthCheckDigit = self.dateOfBirthCheckDigit ?? "<"
        let sex = self.sex ?? "<"
        let dateOfExpiry = self.dateOfExpiry ?? "<<<<<<"
        let dateOfExpiryCheckDigit = self.dateOfBirthCheckDigit ?? "<"

        var optionalData2 = self.optionalData2 ?? ""
        if optionalData2.count < 11 {
            optionalData2.append("<")
        }

        let compositeCheckDigit = self.compositeCheckDigit ?? "<"

        var line2 = """
                    \(dateOfBirth)\(String(dateOfBirthCheckDigit))\(String(sex))\(dateOfExpiry)\(dateOfExpiryCheckDigit)\(nationality)\(optionalData2)\(compositeCheckDigit)
                    """

        let primaryIdentifier = self.primaryIdentifier ?? ""
        let secondaryIdentifier = self.secondaryIdentifier ?? ""

        var line3 = "\(primaryIdentifier)<<\(secondaryIdentifier)"

        while line3.count < mrtdDescriptor.mrzDescriptor.mrtdSize.mrzLineLength {
            line3.append("<")
        }

        if recalculateCheckDigits {

            let docNumberRange = StringUtils.stringIndexRangeFromIntRange(
                    range: mrtdDescriptor.mrzDescriptor.docNumberCheckDigitDescriptor.characterRange, string: line1)

            line1 =
                    line1.replacingCharacters(in: docNumberRange,
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

            let compositeRange1Start = line1.index(line1.startIndex, offsetBy: 5)
            let compositeRange1End = line1.index(line1.startIndex, offsetBy: 29)
            let compositeRange1 = compositeRange1Start...compositeRange1End

            let compositeRange2Start = line2.index(line2.startIndex, offsetBy: 0)
            let compositeRange2End = line2.index(line2.startIndex, offsetBy: 6)
            let compositeRange2 = compositeRange2Start...compositeRange2End

            let compositeRange3Start = line2.index(line2.startIndex, offsetBy: 8)
            let compositeRange3End = line2.index(line2.startIndex, offsetBy: 14)
            let compositeRange3 = compositeRange3Start...compositeRange3End

            let compositeRange4Start = line2.index(line2.startIndex, offsetBy: 18)
            let compositeRange4End = line2.index(line2.startIndex, offsetBy: 28)
            let compositeRange4 = compositeRange4Start...compositeRange4End

            // Re-calculate the composite check digit.
            let compositeString = String(
                    line1[compositeRange1] + line2[compositeRange2] + line2[compositeRange3] + line2[compositeRange4])

            let compositeCheckDigit = String(try! CheckDigitUtility.checkDigitForString(
                    value: compositeString
            ))

            let compositeCheckDigitStart = line2.index(line2.startIndex, offsetBy: 29)
            let compositeCheckDigitEnd = line2.index(line2.startIndex, offsetBy: 29)
            let compositeCheckDigitRange = compositeCheckDigitStart...compositeCheckDigitEnd

            line2 = line2.replacingCharacters(
                    in: compositeCheckDigitRange, with: compositeCheckDigit
            )

        }

        try! checkLineLength(lines: [line1, line2, line3])

        return MRZ(lines: [MRZLine(stringValue: line1), MRZLine(stringValue: line2), MRZLine(stringValue: line3)])

    }

}
