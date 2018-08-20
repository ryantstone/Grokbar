import Foundation

class TunnelService {
    
    let localPath = {
        return Bundle.main.bundlePath
    }()
    
    func startTunnelServer(_ tunnels: [Tunnel]) {
    func startTunnelServer(_ tunnels: [TunnelPreset]) {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = [ "-c", "\(localPath)/Contents/Resources/ngrok start\(tunnelCommand(tunnels))" ]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
    }

    private func tunnelCommand(_ tunnels: [Tunnel]) -> String {
    private func tunnelCommand(_ tunnels: [TunnelPreset]) -> String {
        return tunnels.reduce("") {text, tunnel in
            guard let name = tunnel.name else { return "" }
            return "\(text) \(name)"
        }
    }

}
