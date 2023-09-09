//
//  Friend.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/7/23.
//

import Foundation
import PhotosUI

struct Friend: Codable, Comparable, Identifiable {
  enum CodingKeys: CodingKey {
    case id, name, image
  }
  
  let savePath = FileManager.documentsDirectory.appendingPathComponent("Friends")
  
  static let example = Friend(id: UUID(), name: "Spock", image: UIImage(systemName: "figure.wave.circle"))
  
  let id: UUID
  var name: String
  var image: UIImage?
  
  // Initializer for creating a UserImage instance elsewhere in the app
  init(id: UUID, name: String, image: UIImage?) {
    self.id = id
    self.name = name
    self.image = image
  }
  
  // Initializer for decoding the encoded data
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(UUID.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    
    let imageData = try container.decode(Data.self, forKey: .image)
    let decodedImage = UIImage(data: imageData) ?? UIImage()
    self.image = decodedImage
  }
  
  //encode the data
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    let imageData = image?.jpegData(compressionQuality: 0.8)
    try container.encode(imageData, forKey: .image)
  }
  
  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
  
  static func < (lhs: Friend, rhs: Friend) -> Bool {
    lhs.name < rhs.name
  }
}

