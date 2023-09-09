//
//  EditView-ViewModel.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/7/23.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
  
  @Published var friends: Friend
  @Published var showingImagePicker: Bool
  
  init(friends: Friend) {
    self.friends = friends
    self.showingImagePicker = false
  }
  
}
