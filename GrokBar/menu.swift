import Foundation
import AppKit

class MenuViewController: NSViewController {
    
    var tunnels: [Tunnel] = []
    
    override func viewDidLoad() {
        startParse()
    }
    
    func startParse() {
        let yaml = YmlParser.init(path: nil)
        do {
            tunnels = try yaml.parseTunnels()
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
