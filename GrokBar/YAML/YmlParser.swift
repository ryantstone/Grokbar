import Foundation
import AppKit
import Yams

public class YmlParser {
    let userDirectory   = FileManager.default.homeDirectoryForCurrentUser
    var grokFile: URL!
    
    public init() {
        setGrokFile()
    }
    
    func setGrokFile() {
        let path = ".ngrok2/ngrok.yml"
//        let path = ".ngrok-alt/ngrok-working.yml"
        grokFile = userDirectory.appendingPathComponent(path)
    }
    
    func grokFileContents() -> String {
        do  {
            let data = try Data(contentsOf: grokFile)
            let contents = String(data: data, encoding: String.Encoding.utf8)!
            
            let parsed = try Yams.load(yaml: contents) as! [String: Any]
            let tunnels = parsed["tunnels"] as! [String: AnyObject]
            
            for (key, value) in tunnels {
                let object = (value as! [String: Any])
                let address: String     = object["addr"] as? String ?? ""
                let subdomain: String   = object["subdomain"] as? String ?? ""
                let proto: String       = object["proto"] as? String ?? ""
                let host = ""
                let name: String = key
                
                Tunnel(name: name, address: address, subdomain: subdomain, proto: proto, host: host)
                
                print(address)
                print(subdomain)
                print(proto)
                print(key)
//                print(value)
            }
            
            return "foo"
        } catch {
            return error.localizedDescription
        }
    }
    
    func parse() {
        do {
            let decoder = YAMLDecoder.init()
            let file = try decoder.decode(NgrokFile.self, from: grokFileContents())
            print(file)
        } catch {
            print(error.localizedDescription)
        }
    }
}


