import Foundation
import AppKit
import Yams

class YmlParser {
    let userDirectory   = FileManager.default.homeDirectoryForCurrentUser
    var grokFile: URL!

    public init(path: String?) {
        setGrokFile(path)
    }
    
    func setGrokFile(_ path: String?) {
        let pathString = path ?? ".ngrok2/ngrok.yml"
        print(pathString)
        grokFile = userDirectory.appendingPathComponent(pathString)
    }
    
    func parseTunnels() throws -> [Tunnel] {
        let data        = try Data(contentsOf: grokFile)
        let contents    = String(data: data, encoding: String.Encoding.utf8)!
        let parsed      = try Yams.load(yaml: contents) as! [String: Any]
        let tunnelData  = parsed["tunnels"] as! [String: AnyObject]
        var tunnels: [Tunnel] = []
        
        for (key, value) in tunnelData {
            
            let object = (value as! [String: Any])
            guard let address = object["addr"] as? Int else {
                throw NGROKFileError.invalidAddress
            }
            
            guard let proto = object["proto"] as? String else {
                throw NGROKFileError.invalidProto
            }
            
            let subDomain: String?  = object["subdomain"] as?  String
            let hostName: String?   = object["hostName"] as? String
            let name: String?       = key
            
            tunnels.append(Tunnel(name: name,
                                  address: address,
                                  proto: proto,
                                  hostName: hostName,
                                  subDomain: subDomain))
        }
        return tunnels
    }
}

// MARK: - NGROK Parse Error
enum NGROKFileError: Error {
    case invalidProto,
    invalidAddress
}


















