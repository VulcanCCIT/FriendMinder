//
//  ContentView.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/5/23.
//  Inspired by Shae WIlles @FlyOstrich on the Hacking With Swift Forums
//  His github code is at https://github.com/Fly0strich/SwiftUI_Challenges
//
import SwiftUI


struct ContentView: View {
  
  @StateObject private var viewModel = ViewModel()
  
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.sortedFriends) { friend in
          NavigationLink {
            ImageDetailView(friends: friend)
          } label: {
            HStack {
              if let image = friend.image {
                Image(uiImage: image)
                  .resizable()
                //.scaledToFit()
                  .frame(width: 75, height: 75)
                  .clipShape(Circle())
                  .padding(5)
                  .overlay(Circle().stroke(Color.white, lineWidth: 4))
                
                  .shadow(color:.blue, radius: 10)
              } else {
                Image(systemName: "figure.wave.circle")
                  .resizable()
                  .scaledToFit()
              }
              
              Text(friend.name)
                .foregroundColor(.blue)
            }
          }
        }
        .onDelete(perform: deleteNamedFace)
      }
      .navigationTitle("FriendMinder")
      .toolbar {
        Button {
          viewModel.showingImagePicker = true
        } label: {
          Image(systemName: "plus")
        }
        .sheet(isPresented: $viewModel.showingImagePicker) {
          ImagePicker(image: $viewModel.selectedImage)
        }
      }
      .onChange(of: viewModel.selectedImage) { _ in
        viewModel.locationFetcher.start()
        viewModel.showingEditView = true
      }
      .sheet(isPresented: $viewModel.showingEditView) {
        EditView(friends: Friend(id: UUID(), name: "", image: viewModel.selectedImage, friendLocation: viewModel.locationFetcher.lastKnownLocation)) { newNamedFace in
          viewModel.addFriend(newFriend: newNamedFace)
        }
      }
    }
  }
  
  func deleteNamedFace(at offsets: IndexSet) {
    Task { @MainActor in
      for offset in offsets {
        let deletableID = viewModel.sortedFriends[offset].id
        let deletableIndex = viewModel.friends.firstIndex(where: { $0.id == deletableID })
        viewModel.friends.remove(at: deletableIndex!)
      }
      viewModel.save()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
