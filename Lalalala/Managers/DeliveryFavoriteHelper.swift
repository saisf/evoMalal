

import Foundation

// MARK: - Delivery Favorite Helper
protocol DeliveryFavoriteHelper {}

extension DeliveryFavoriteHelper {
    func deliveryIsFavorited(id: String) -> Bool {
        return UserDefaults.standard.bool(forKey: id)
    }
    
    func favoriteTheDelivery(id: String?, toFavorite: Bool) {
        guard let id = id else { return }
        if toFavorite, deliveryIsFavorited(id: id) == false {
            UserDefaults.standard.set(true, forKey: id)
        }
        
        if !toFavorite  {
            UserDefaults.standard.removeObject(forKey: id)
        }
        
    }
}
