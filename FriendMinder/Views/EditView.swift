//
//  EditView.swift
//  FriendMinder
//
//  Created by Chuck Condron on 9/7/23.
//  Inspired by Shae WIlles @FlyOstrich on the Hacking With Swift Forums
//  His github code is at https://github.com/Fly0strich/SwiftUI_Challenges
//
import SwiftUI

struct EditView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject var viewModel: ViewModel
  
  var onSave: (Friend) -> Void
  
  var body: some View {
    NavigationView {
      VStack {
        TextField("Edit Pic Name", text: $viewModel.friends.name)
          .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
          }
          .multilineTextAlignment(.center)
          .font(.title)
          .frame(height: 30)
          .foregroundColor(.blue)
          .fontWeight(.bold)
          .textFieldStyle(.roundedBorder)
        if let image = viewModel.friends.image {
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .overlay(RoundedRectangle(cornerRadius: 50).strokeBorder(.blue, lineWidth: 5))
            .padding([.horizontal, .top])
        } else {
          Image(systemName: "figure.wave.circle")
            .resizable()
            .scaledToFit()
        }
        Button("Select New Pic") {
          viewModel.showingImagePicker = true
        }
        .padding()
        .background(.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
        .sheet(isPresented: $viewModel.showingImagePicker) {
          ImagePicker(image: $viewModel.friends.image)
        }
        Spacer()
      }
      .navigationTitle("Edit Pic Info")
      .navigationBarTitleDisplayMode(.automatic)
      .toolbar {
        Button("Save") {
          onSave(viewModel.friends)
          dismiss()
        }
      }
    }
  }
  
  init(friends: Friend, onSave: @escaping (Friend) -> Void) {
    _viewModel = StateObject(wrappedValue: ViewModel(friends: friends))
    self.onSave = onSave
  }
}

struct EditView_Previews: PreviewProvider {
  static var previews: some View {
    EditView(friends: Friend.example) { friends in }
  }
}
