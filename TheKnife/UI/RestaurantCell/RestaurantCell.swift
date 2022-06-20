import UIKit
import SwifterSwift

class RestaurantCell: UITableViewCell {
    
    // MARK: - Operational
    weak var favoritesDelegate: FavoritesDelegate?
    
    // MARK: - Data Holding
    var model: Restaurant!
    
    // MARK: - Subviews
    var cardView: UIView!
    var titleLabel: UILabel!
    var thumbnailImage: UIImageView!
    var cuisineLabel: UILabel!
    var addressLabel: UILabel!
    var ratingLabel: UILabel!
    var favoriteHeart: HeartButton!
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildUI()
    }
    
    private func buildUI() {
        backgroundColor = UIColor(named: "backDrop")
        
        cardView = UIView()
        addSubview(cardView)
        
        cardView.snp.makeConstraints { make in
            make.size.equalTo(self).inset(UIEdgeInsets(horizontal: 20, vertical: 10))
            make.center.equalTo(self)
        }
        
        cardView.backgroundColor = UIColor.white
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        thumbnailImage = UIImageView(image: UIImage(named: "food"))
        thumbnailImage.contentMode = .center
        cardView.addSubview(thumbnailImage)
        
        thumbnailImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 70, height: 70))
            
            make.centerY.equalTo(cardView)
            make.left.equalTo(cardView).offset(10)
        }
        
        thumbnailImage.layer.cornerRadius = 10
        thumbnailImage.clipsToBounds = true
        
        titleLabel = UILabel()
        cardView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top).offset(10)
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(12)
            make.trailing.equalTo(self).inset(50)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        cuisineLabel = UILabel()
        cardView.addSubview(cuisineLabel)
        
        cuisineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(titleLabel)
        }
        
        cuisineLabel.font = UIFont.systemFont(ofSize: 12)
        
        addressLabel = UILabel()
        cardView.addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(cuisineLabel.snp.bottom).offset(3)
            make.leading.equalTo(cuisineLabel)
        }
        
        addressLabel.font = UIFont.systemFont(ofSize: 10)
        
        ratingLabel = UILabel()
        cardView.addSubview(ratingLabel)
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.top).offset(10)
            make.right.equalTo(cardView).inset(10)
        }
        
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        favoriteHeart = HeartButton()
        cardView.addSubview(favoriteHeart)
        
        favoriteHeart.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.bottom.equalTo(cardView.snp.bottom).inset(20)
            make.right.equalTo(cardView).inset(10)
        }
        
        favoriteHeart.clipsToBounds = true
        favoriteHeart.addTarget(self, action: #selector(userDidTapHeart), for: .touchUpInside)
    }
    
    // MARK: - Operational
    
    func apply(_ restaurant: Restaurant) {
        self.model = restaurant
        titleLabel.text = model.name
        
        if let cuisine = model.servesCuisine {
            cuisineLabel.text = cuisine
        }
        
        if let address = model.address {
            addressLabel.text = RestaurantsListViewModel.readableAddress(address)
        }
        
        ratingLabel.text = RestaurantsListViewModel.readableRating(forRestaurant: model)
        
        thumbnailImage.image = nil
        
        if let photo = self.model.mainPhoto, let url = URL(string: photo.small) {
            thumbnailImage.download(from: url, contentMode: .center, placeholder: UIImage(named: "food"))
        }
        
        if let isFavorite = model.isFavorite {
            favoriteHeart.setStatus(isFavorite)
        }
    }
    
    // MARK: - Actions
    
    @objc func userDidTapHeart() {
        print("Heart \(favoriteHeart.status)!")
        if favoriteHeart.status {
            favoritesDelegate?.favorite(restaurantWithUUID: model.uuid)
        } else {
            favoritesDelegate?.unfavorite(restaurantWithUUID: model.uuid)
        }
    }

}
