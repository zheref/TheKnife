import UIKit

class RestaurantsView: UIView {
    
    // MARK: - Subviews
    var tableView: UITableView!
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout()
    }
    
    private func buildLayout() {
        tableView = UITableView()
        addSubview(tableView)
        
        tableView.backgroundColor = UIColor(named: "backDrop")
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(horizontal: 0, vertical: 15)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        
        tableView.snp.makeConstraints { make in
            make.size.equalTo(self.safeAreaLayoutGuide.snp.size)
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
    
}

extension RestaurantsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100.0 }
    
}
