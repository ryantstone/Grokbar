import Cocoa

class TunnelCollectionViewCell: NSCollectionViewItem {
    
    // MARK: - Outlets
    @IBOutlet weak var isSelectedCheckBox: NSButton!
    @IBOutlet weak var titleLabel: NSTextFieldCell!
    @IBOutlet weak var subdomainLabel: NSTextFieldCell!
    @IBOutlet weak var portLabel: NSTextFieldCell!
    
    var tunnel: TunnelPreset! {
        didSet {
            setupView()
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isSelectedCheckBox.state = .off
        view.wantsLayer = true
    }
    
    public func setTunnel(_ tunnel: TunnelPreset) {
        self.tunnel = tunnel
    }
    
    private func setupView() {
        titleLabel.title        = tunnel.name ?? "Unnamed"
        subdomainLabel.title    = tunnel.subDomain ?? "No Subdomain"
        portLabel.title         = "\(tunnel.address)"
    }

    public func state() -> Bool {
        return isSelectedCheckBox.state.rawValue == 1 ? true : false
    }
}
