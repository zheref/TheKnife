import UIKit
import SnapKit

protocol FavoritesDelegate: AnyObject {
    func favorite(restaurantWithUUID uuid: String)
    func unfavorite(restaurantWithUUID uuid: String)
    func isFavorite(restaurantWithUUID uuid: String) -> Bool?
}

class RestaurantsListController: UIViewController {
    
    // Operations and Data
    var vm: RestaurantsListViewModel!
    
    // MARK: - Subviews/Outlets
    var customView: RestaurantsView {
        return view as! RestaurantsView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = RestaurantsView()
        vm.prepare()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        customizeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBindings()
    }
    
    // MARK: Configuration
    
    private func setupNavigation() {
        self.title = "🔪 The Knife"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sort"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(userDidTapSort))
    }
    
    private func customizeView() {
        view.backgroundColor = UIColor.white
    }
    
    private func setupBindings() {
        vm.restaurants.bind(to: customView.tableView, cellType: RestaurantCell.self) { [unowned self] cell, restaurant in
            cell.apply(restaurant)
            cell.favoritesDelegate = self.vm
        }
    }
    
    // MARK: - Actions
    
    @objc func userDidTapSort() {
        let sortOptionsMenu = UIAlertController(title: nil, message: "Sort By", preferredStyle: .actionSheet)
        
        let byNameAction = UIAlertAction(title: "Name", style: .default, handler: {
            [weak self] action -> Void in
            self?.vm.sort(by: .name)
        })
        
        let byRatingAction = UIAlertAction(title: "Rating", style: .default, handler: {
            [weak self] action -> Void in
            self?.vm.sort(by: .rating)
        })
        
        let byCuisineAction = UIAlertAction(title: "Cuisine", style: .default, handler: {
            [weak self] action -> Void in
            self?.vm.sort(by: .cuisine)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action -> Void in
            print("Cancelled")
        })
        
        sortOptionsMenu.addAction(byNameAction)
        sortOptionsMenu.addAction(byRatingAction)
        sortOptionsMenu.addAction(byCuisineAction)
        sortOptionsMenu.addAction(cancelAction)
        
        present(sortOptionsMenu, animated: true, completion: nil)
    }

}
