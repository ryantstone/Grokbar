import AppKit

class TunnelCollectionView: NSCollectionView {
    
    override func viewWillMove(toWindow newWindow: NSWindow?) {
        super.viewWillMove(toWindow: newWindow)
        dataSource = self
        setupFlowLayout()
    }
    
    
    private func setupFlowLayout() {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: frame.width, height: 25)
        collectionViewLayout = layout
        wantsLayer = true
    }
}

// MARK: - Data Source
extension TunnelCollectionView: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return TunnelManager.shared.tunnels.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let identifier = NSUserInterfaceItemIdentifier("TunnelCollectionViewCell")
        let item = makeItem(withIdentifier: identifier, for: indexPath)
        guard let collectionViewItem = item as? TunnelCollectionViewCell else  {
            return item
        }
        collectionViewItem.setTunnel(TunnelManager.shared.tunnels[indexPath.item])
        return collectionViewItem
    }
}
