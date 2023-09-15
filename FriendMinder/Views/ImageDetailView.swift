//
//  ImageDetailView.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/7/23.
//  Inspired by Shae WIlles @FlyOstrich on the Hacking With Swift Forums
//  His github code is at https://github.com/Fly0strich/SwiftUI_Challenges
//

import MapKit
import SwiftUI

struct ImageDetailView: View {
  
  //@State var friends: Friend
  @StateObject private var viewModel: ViewModel
  
  var body: some View {
    VStack {
      Text(viewModel.friends.name)
        .font(.title)
        .foregroundColor(.blue)
      Image(uiImage: viewModel.friends.image ?? UIImage(systemName: "person")!)
        .resizable()
        .scaledToFit()
        .padding()
    }
    
    Toggle("Show friend location", isOn: $viewModel.showFriendLocation)
    
    if viewModel.showFriendLocation {
      Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.annotations) { annotation in
        MapAnnotation(coordinate: annotation.coordinate) {
          Image(systemName: "mappin.and.ellipse")
            .resizable()
            .foregroundColor(.red)
            .frame(width: 35, height: 25)
        }
      }
      .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
    } else {
      Spacer()
    }
  }
  
  init(friends: Friend) {
    _viewModel = StateObject(wrappedValue: ViewModel(friends: friends))
  }
}

struct ImageDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ImageDetailView(friends: Friend.example)
  }
}
