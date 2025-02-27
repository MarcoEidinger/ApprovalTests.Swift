import Foundation

public class GenericDiffReporterBase: EquatableFailureReporter {
    let programPath: String
    let arguments: (String, String) -> [String]

    public init(programPath: String,
                arguments: @escaping (String, String) -> [String] = { received, approved in
                    [received, approved]
                }) {
        self.programPath = programPath
        self.arguments = arguments
    }

    public override func report(received: String, approved: String) -> Bool {
        if !doesProgramExist(programPath) {
            return false
        }
        do {
            try runProcess(received: received, approved: approved)
            return true
        } catch {
            print("Error in \(#function) for received \"\(received)\", approved \"\(approved)\": \(error)")
            return false
        }
    }

    public func doesProgramExist(_ programPath: String) -> Bool {
        FileManager.default.fileExists(atPath: programPath)
    }

    public override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let other = other as? GenericDiffReporterBase else { return false }
        return programPath == other.programPath
    }

    public func runProcess(received: String, approved: String) throws {
    }
}
