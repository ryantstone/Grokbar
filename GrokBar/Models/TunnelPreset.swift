import Foundation

struct TunnelPreset: Codable, Equatable {
    let name: String?
    let address: Int
    let proto: String
    let hostName: String?
    let subDomain: String?
}
