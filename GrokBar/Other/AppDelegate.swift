import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem  = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover     = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(AppDelegate.togglePopover(_:))
        }
        let menu = MenuViewController.menuController()
        menu.startParse()
        popover.contentViewController = menu
    }
    
    @objc func togglePopover(_ sender: Any?) {
        popover.isShown ? closePopover(sender: sender) : showPopover(sender: sender)
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {}
}

