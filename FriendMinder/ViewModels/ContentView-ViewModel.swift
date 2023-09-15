//
//  ContentView-ViewModel.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/7/23.
//

import SwiftUI

extension ContentView {
  @MainActor class ViewModel: ObservableObject {
    @Published var friends: [Friend]
    @Published var selectedImage: UIImage?
    @Published var showingImagePicker = false
    @Published var showingEditView = false
    
    var sortedFriends: [Friend] {
      friends.sorted()
    }
    
    let locationFetcher = LocationFetcher()
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Friends")
    
    init() {
      do {
        let data = try Data(contentsOf: savePath)
        friends = try JSONDecoder().decode([Friend].self, from: data)
      } catch {
        friends = []
      }
    }
    
    func addFriend(newFriend: Friend) {
      friends.append(newFriend)
    }
    
    func save() {
      do {
        let data = try JSONEncoder().encode(friends)
        try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
      } catch {
        print("Unable to save data.")
      }
    }
  }
}
