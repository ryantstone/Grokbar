import Foundation
import AppKit

class MenuViewController: NSViewController {
    //MARK: - Outlets
    @IBOutlet weak var tunnelCollectionView: TunnelCollectionView!
    @IBOutlet weak var startButton: NSButton!
    
    // MARK: - Actions
    @IBAction func didClickStart(_ sender: Any) {
        let selectedTunnels = getSelectedTunnels()
        _ = TunnelService().startTunnelServer(selectedTunnels)
    }
    
    override func viewDidLoad() {
        parseNgrokFile()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    func parseNgrokFile() {
        let yaml = YmlParser.init(path: nil)
        do {
            TunnelManager.shared.tunnels = try yaml.parseTunnels()
        } catch {
            print(error)
        }
    }
    
    private func getSelectedTunnels() -> [Tunnel] {
        let tunnels = tunnelCollectionView.visibleItems().compactMap { (item) -> Tunnel? in
            let item = item as! TunnelCollectionViewCell
            return item.state() ? item.tunnel : nil
        }
        return tunnels
    }
}

// MARK: - Setup Menu
extension MenuViewController {
    static func menuController() -> MenuViewController {
        let storyBoard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "MenuViewController")
        guard let viewController = storyBoard.instantiateController(withIdentifier: identifier) as? MenuViewController else {
            fatalError("Cant find storyboard")
        }
        return viewController
    }
}
