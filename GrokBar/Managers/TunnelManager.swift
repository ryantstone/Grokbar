import Foundation

class TunnelManager {
    static var shared = TunnelManager.init()
    var tunnels: [Tunnel] = []
}
