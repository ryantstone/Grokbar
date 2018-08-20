import XCTest
@testable import GrokBar

class YmlParserTests: XCTestCase {
    var ymlParser: YmlParser!
    var testBundle: Bundle!
    var validNgrokStub: URL!
    var invalidNgrokStub: URL!
    
    override func setUp() {
        super.setUp()
        ymlParser           = YmlParser(path: nil)
        testBundle          = Bundle(for: type(of: self))
        validNgrokStub      = testBundle.url(forResource: "validNgrok", withExtension: "yml")
        invalidNgrokStub    = testBundle.url(forResource: "invalidNgrok", withExtension: "yml")
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSettingDefaultGrokFile() {
        let defaultPath = ".ngrok2/ngrok.yml"
        let grokFile    = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(defaultPath)
        XCTAssertTrue(ymlParser.grokFile == grokFile)
    }
    
    func testCustomerGrokFile() {
        let customYmlParser = YmlParser(path: ".fakeGrokLocation/test.yml")
        let customGrokFileLocation = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".fakeGrokLocation/test.yml")
        XCTAssertTrue(customYmlParser.grokFile == customGrokFileLocation)
    }
    
    func testValidNgrokFile() {
        ymlParser.grokFile = validNgrokStub
        let tunnels = try! ymlParser.parseTunnels()
        XCTAssert(tunnels.count == 2)
    }
    
    func testParsingOfTunnels() {
        ymlParser.grokFile = validNgrokStub
        
        let tunnels = [
            TunnelPreset(name: "fake-client", address: 4200, proto: "http", hostName: nil, subDomain: "fake-client"),
            TunnelPreset(name: "fake-api", address: 3000, proto: "http", hostName: nil, subDomain: "fake-api")
        ]
        let parsedTunnels = try! ymlParser.parseTunnels()
        XCTAssert(tunnels == parsedTunnels)
    }

    func testInvalidNgrokFile() {
        ymlParser.grokFile = invalidNgrokStub
        XCTAssertThrowsError(try ymlParser.parseTunnels())
    }
}



