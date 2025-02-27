/**
 A composite reporter that goes through a list of reporters, running all that are available on the current machine.
 */
public class ReportWithEverything: EquatableFailureReporter {
    private let reporters: [EquatableFailureReporter]

    public init(_ reporters: EquatableFailureReporter...) {
        self.reporters = reporters
    }

    public override func report(received: String, approved: String) -> Bool {
        var worked = false
        for reporter in reporters {
            worked = reporter.report(received: received, approved: approved) || worked
        }
        return worked
    }

    public override func isEqualTo(_ other: ApprovalFailureReporter) -> Bool {
        guard let other = other as? ReportWithEverything else { return false }
        return reporters == other.reporters
    }
}
