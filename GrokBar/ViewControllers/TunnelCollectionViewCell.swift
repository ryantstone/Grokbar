import Cocoa

class TunnelCollectionViewCell: NSCollectionViewItem {
    @IBOutlet weak var isSelectedCheckBox: NSButton!
    @IBOutlet weak var titleLabel: NSTextFieldCell!
    @IBOutlet weak var subdomainLabel: NSTextFieldCell!
    @IBOutlet weak var portLabel: NSTextFieldCell!
    var isSelectedState = false {
        didSet { isSelectedCheckBox.state = isSelected ? .on : .off }
    }
    
    var tunnel: Tunnel! {
        didSet { setupView() }
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSelectedCheckBox.state = .off
        view.wantsLayer = true
    }
    
    public func setTunnel(_ tunnel: Tunnel) {
        self.tunnel = tunnel
    }
    
    private func setupView() {
        titleLabel.title        = tunnel.name ?? "Unnamed"
        subdomainLabel.title    = tunnel.subDomain ?? "No Subdomain"
        portLabel.title         = "\(tunnel.address)"
    }
}
