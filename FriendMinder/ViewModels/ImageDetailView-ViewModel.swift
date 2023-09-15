//
//  ImageDetailView-ViewModel.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/13/23.
//

import SwiftUI
import MapKit

extension ImageDetailView {
  struct Location: Identifiable {
    var id: UUID
    var coordinate: CLLocationCoordinate2D
  }
  
  @MainActor class ViewModel: ObservableObject {
    @Published var showFriendLocation: Bool
    @Published var mapRegion: MKCoordinateRegion
    
    let friends: Friend
    
    var annotations: [Location] {
      var array = [Location]()
      if let friendLocation = friends.friendLocation {
        array.append(Location(id: UUID(), coordinate: friendLocation))
      }
      return array
    }
    
    init(friends: Friend) {
      self.friends = friends
      self.showFriendLocation = false
      let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      let mapCenter = friends.friendLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
      self.mapRegion = MKCoordinateRegion(center: mapCenter, span: mapSpan)
    }
  }
}
