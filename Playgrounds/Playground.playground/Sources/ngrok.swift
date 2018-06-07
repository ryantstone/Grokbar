import Foundation
import AppKit
import Cocoa

struct Tunnel: Codable {
    let name: String
    let address: String
    let subdomain: String
    let proto: String
    let host: String?
}


struct NgrokTestFile: Codable {
    let tunnels: [Tunnel]
    
    private enum CodingKeys: String, CodingKey {
        case tunnels = "tunnels"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let tunnel = try values.decode([String: Tunnel].self, forKey: .tunnels)
        tunnels = Array(tunnel.values)
    }
}
