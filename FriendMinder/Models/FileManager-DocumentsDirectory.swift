//
//  FileManager-DocumentsDirectory.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/7/23.
//

import Foundation

extension FileManager {
  static var documentsDirectory: URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}
