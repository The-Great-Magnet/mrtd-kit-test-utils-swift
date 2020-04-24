import Foundation
import os.log

extension TestMRZBuilder {

    func checkLineLength(lines: [String]) throws {

        let mrtdSize = mrtdDescriptor.mrzDescriptor.mrtdSize

        for line in lines {

            if line.count != mrtdSize.mrzLineLength {

                throw TestError.generalError
            }
        }
    }

    func withAnInvalidIssuingState() -> TestMRZBuilder {
        var copy = self
        copy.issuingState = "XYZ"
        return copy
    }

    func withAnInvalidNationality() -> TestMRZBuilder {
        var copy = self
        copy.nationality = "XYZ"
        return copy
    }

    func withAnInvalidSex() -> TestMRZBuilder {
        var copy = self
        copy.sex = Character("N")
        return copy
    }

    func withAnInvalidDateOfBirth() -> TestMRZBuilder {
        var copy = self
        copy.dateOfBirth = "741312"
        return copy
    }

    func withAnInvalidExpiryDate() -> TestMRZBuilder {
        var copy = self
        copy.dateOfExpiry = "121315"
        return copy
    }

}
