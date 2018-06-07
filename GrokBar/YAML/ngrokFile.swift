//import Foundation
//import AppKit
//import Cocoa
//
//struct NgrokFile: Codable {
//    let authToken: String
//    let tunnels: Tunnel
//    
//    enum CodingKeys: String, CodingKey {
//        case authToken  = "authtoken"
//        case tunnels    = "tunnels"
//    }
//}
//
//struct Tunnel: Codable {
//    let title: TunnelDetails
//}
//
////struct CodingKeys: CodingKey {
////    var stringValue: String
////    init?(stringValue: String){ self.stringValue = stringValue }
////    
////    static func makeKey(name: String) -> CodingKeys {
////        return CodingKeys(stringValue: name)!
////    }
////}
//
//struct TunnelDetails: Codable {
//    
//    let address: String
//    let subdomain: String
//    let proto: String
//    let host: String?
//    
//    enum codingKeys: String, CodingKey {
//        case address    = "addr"
//        case subdomain  = "subdomain"
//        case proto      = "proto"
//        case host       = "host_header"
//    }
//}

import Foundation
import AppKit
import Cocoa

struct NgrokFile: Codable {
    let tunnels: [Tunnel]
    
    private enum CodingKeys: String, CodingKey {
        case tunnels = "tunnels"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let tunnel = try values.decode([String: Tunnel].self, forKey: .tunnels)
        print(tunnel)
        tunnels = Array(tunnel.values)
    }
}

struct Tunnel: Codable {
    let name: String
    let address: String
    let subdomain: String
    let proto: String
    let host: String?
}


