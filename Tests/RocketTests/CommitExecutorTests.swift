import XCTest
@testable import RocketLib
import Logger
import Nimble
import TestSpy

final class CommitExecutorTests: ExecutorTestCase {
    func testItUsesTheCommitMessageIfAny() {
        let testMessage = "test"
        let dictionary = ["message": testMessage]
        
        executeCommitStep(withDictionary: dictionary)
        
        expect(self.scriptLauncher).to(haveReceived(.launchScript(content: "git commit -m \"\(testMessage)\"")))
    }
    
    func testItUsesTheStandardCommitMessageIfNoMessageIsProvided() {
        executeCommitStep(withDictionary: nil)
        
        expect(self.scriptLauncher).to(haveReceived(.launchScript(content: "git commit -m \"Version 1.0.0\"")))
    }
    
    private func givenACommitExecutor(dictionary: [String:Any]?) -> CommitExecutor {
        return CommitExecutor(dictionary: dictionary, scriptLauncher: scriptLauncher)
    }
    
    private func executeCommitStep(withDictionary dictionary: [String:Any]?) {
         givenACommitExecutor(dictionary: dictionary).executeStep(version: "1.0.0", logger: Logger.testLogger)
    }
}