import XCTest
@testable import GrokBar

class YmlParserTests: XCTestCase {
    var ymlParser: YmlParser!
    var validStubbedParser: YmlParser!
    var testBundle: Bundle!
    var validNgrokStub: URL!
    
    override func setUp() {
        super.setUp()
        ymlParser           = YmlParser(path: nil)
        testBundle          = Bundle(for: type(of: self))
        validNgrokStub      = testBundle.url(forResource: "validNgrok", withExtension: "yml")
        validStubbedParser  = YmlParser(path: nil)
        validStubbedParser.grokFile = validNgrokStub
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
        let tunnels = try! validStubbedParser.parseTunnels()
        XCTAssert(tunnels.count == 2)
    }
    
    func testParsingOfTunnels() {
        let tunnels = [
            Tunnel(name: "fake-client", address: 4200, proto: "http", hostName: nil, subDomain: "fake-client"),
            Tunnel(name: "fake-api", address: 3000, proto: "http", hostName: nil, subDomain: "fake-api")
        ]
        let parsedTunnels = try! validStubbedParser.parseTunnels()
        XCTAssert(tunnels == parsedTunnels)
    }
    
    func testParsingDefaultGrokFile(){}

}
