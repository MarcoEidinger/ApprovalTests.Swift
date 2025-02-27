import Foundation

/**
 A reporter that creates a command line `mv` command for approving the last failed test, and places it on the clipboard.
 
 This will overwrite the previous clipboard contents.
 */
public class ReportMoveCommandToClipboard: EquatableFailureReporter {
    public override init() {}

    public override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        other is ReportMoveCommandToClipboard
    }

    public override func report(received: String, approved: String) -> Bool {
        let command = ReportMoveCommandToClipboard.makeCommandLineMove(received: received, approved: approved)
        SystemUtils.pasteToClipboard(command)
        return true
    }

    public static func makeCommandLineMove(received: String, approved: String) -> String {
        "mv \"\(received)\" \"\(approved)\""
    }
}
