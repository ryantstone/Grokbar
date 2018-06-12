import Foundation

class TunnelService {
    
    func startTunnelServer(_ tunnels: [Tunnel]) {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = [ "-c", "/usr/local/bin/ngrok start\(tunnelCommand(tunnels))" ]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
    }
    private func tunnelCommand(_ tunnels: [Tunnel]) -> String {
        return tunnels.reduce("") {text, tunnel in
            guard let name = tunnel.name else { return "" }
            return "\(text) \(name)"
        }
    }
    
}
