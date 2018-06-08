import Foundation
import AppKit

class MenuViewController: NSViewController {
    @IBOutlet weak var tunnelCollectionView: TunnelCollectionView! 
    @IBOutlet weak var startButton: NSButton!
    @IBAction func didClickStart(_ sender: Any) {
        print("clicked start")
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
