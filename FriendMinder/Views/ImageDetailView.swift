//
//  ImageDetailView.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/7/23.
//  Inspired by Shae WIlles @FlyOstrich on the Hacking With Swift Forums
//  His github code is at https://github.com/Fly0strich/SwiftUI_Challenges
//

import SwiftUI


struct ImageDetailView: View {
  
  @State var friends: Friend
  
  var body: some View {
    VStack {
      Text(friends.name)
        .font(.title)
        .foregroundColor(.blue)
      Image(uiImage: friends.image ?? UIImage(systemName: "person")!)
        .resizable()
        .scaledToFit()
        .padding()
    }
    
    Spacer()
    
  }
}

struct ImageDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ImageDetailView(friends: Friend.example)
  }
}
