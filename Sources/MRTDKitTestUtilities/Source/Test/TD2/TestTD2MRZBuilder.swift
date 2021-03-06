import Foundation
import MRTDKitSpec
import MRTDKitCore

class TestTD2MRZBuilder: TestMRZBuilder, TestTD2MRZBuilderFields {

    let mrtdDescriptor: MRTDDescriptor = TD2Descriptor.init()

    var documentCode: String?

    var issuingState: String?
    var primaryIdentifier: String?
    var secondaryIdentifier: String?
    var documentNumber: String?
    var documentNumberCheckDigit: Character?
    var nationality: String?
    var dateOfBirth: String?
    var dateOfBirthCheckDigit: Character?
    var sex: Character?
    var dateOfExpiry: String?
    var dateOfExpiryCheckDigit: Character?

    var optionalData: String?
    var compositeCheckDigit: Character?

    func aValidMRZ() -> TestTD2MRZBuilder {

        let copy = self

        copy.documentCode = TestTD2MRZValues.documentCode
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
        copy.optionalData = TestTD2MRZValues.optionalData
        copy.compositeCheckDigit = TestTD2MRZValues.compositeCheckDigit

        return copy

    }

    func build(recalculateCheckDigits: Bool) -> MRZ {

        var documentCode = self.documentCode ?? ""
        while (documentCode.count < 2) {
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
        let compositeCheckDigit = self.compositeCheckDigit ?? "<"

        var line2 = """
                    \(documentNumber)\(String(docNumberCheckDigit))\(nationality)\(dateOfBirth)\(dateOfBirthCheckDigit)\(String(sex))\(dateOfExpiry)\(dateOfExpiryCheckDigit)\(optionalData)\(compositeCheckDigit)
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

            let compositeRange1Start = line2.index(line2.startIndex, offsetBy: 0)
            let compositeRange1End = line2.index(line2.startIndex, offsetBy: 10)
            let compositeRange1 = compositeRange1Start..<compositeRange1End

            let compositeRange2Start = line2.index(line2.startIndex, offsetBy: 13)
            let compositeRange2End = line2.index(line2.startIndex, offsetBy: 20)
            let compositeRange2 = compositeRange2Start..<compositeRange2End

            let compositeRange3Start = line2.index(line2.startIndex, offsetBy: 21)
            let compositeRange3End = line2.index(line2.startIndex, offsetBy: 35)
            let compositeRange3 = compositeRange3Start..<compositeRange3End

            // Re-calculate the composite check digit.
            let compositeString = line2[compositeRange1] + line2[compositeRange2] + line2[compositeRange3]

            let compositeCheckDigit = String(try! CheckDigitUtility.checkDigitForString(
                    value: String(compositeString)
            ))

            let compositeCheckDigitStart = line2.index(line2.startIndex, offsetBy: 35)
            let compositeCheckDigitEnd = line2.index(line2.startIndex, offsetBy: 35)
            let compositeCheckDigitRange = compositeCheckDigitStart...compositeCheckDigitEnd

            line2 = line2.replacingCharacters(
                    in: compositeCheckDigitRange, with: compositeCheckDigit
            )
        }

        try! checkLineLength(lines: [line1, line2])

        return MRZ(lines: [MRZLine(stringValue: line1), MRZLine(stringValue: line2)])

    }

}
