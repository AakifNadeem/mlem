//
//  Favorites Tracker.swift
//  Mlem
//
//  Created by David Bureš on 16.05.2023.
//

import Combine
import Dependencies
import Foundation

class FavoriteCommunitiesTracker: ObservableObject {
    
    @Dependency(\.persistenceRepository) var persistenceRepository
    
    @Published var favoriteCommunities: [FavoriteCommunity] = .init()
    private var updateObserver: AnyCancellable?

    init() {
        self.favoriteCommunities = persistenceRepository.loadFavoriteCommunities()
        self.updateObserver = $favoriteCommunities.sink { [weak self] in
            self?.persistenceRepository.saveFavoriteCommunities($0)
        }
    }
}
