//
//  FavoritesView.swift
//  Cats
//
//  Created by Andrey on 8.11.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
  
  @FetchRequest(
    entity: Favorites.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Favorites.url, ascending: true)]
  ) var favorites: FetchedResults<Favorites>
  
  @State private var tapped = false
  @State private var isActionSheetPresented = false
  @State private var selectedIndex: Int = 0
  @State private var savedImages: [UIImage] = []

  var body: some View {
    ScrollView(.horizontal, content: {
      HStack(alignment: .center, spacing: 50) {
        
        Spacer()
        ForEach (0..<favorites.count, id: \.self) { i in
          ZStack {
      
            if let imageUrlString = favorites[i].url {
              
              let webImage =  WebImage(url: URL(string: imageUrlString))
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
                .cornerRadius(15)
                
              webImage
              
              Image("")
                .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
                .background(Color.white.opacity(0.1))
                .onTapGesture {
                  self.tapped.toggle()
                  self.selectedIndex = i
                  self.isActionSheetPresented.toggle()
                }
                .actionSheet(isPresented: $isActionSheetPresented) {
                  
                  var buttons = [ActionSheet.Button]()
                  
                  let saveButton = ActionSheet.Button.default(Text("Save to the photo library \(selectedIndex)")) {
                    if let url = URL(string: favorites[selectedIndex].url ?? ""),
                       let data = try? Data(contentsOf: url),
                       let iamge = UIImage(data: data) {
                      
                      saveImage(image: iamge)
                    }
                  }
                  let deleteButton = ActionSheet.Button.destructive(Text("Delete")){
                    PersistenceController.shared.delete(favorites[selectedIndex])
                  }
                  let cancelButton = ActionSheet.Button.cancel()
                  
                  buttons.append(saveButton)
                  buttons.append(deleteButton)
                  buttons.append(cancelButton)
                  
                  return ActionSheet(title: Text(""), message: nil, buttons: buttons)
                }
            }
          }
        }
        Spacer()
          .navigationTitle(Text("Favorites"))
      }
    })
  }
  
  private func saveImage(image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
  }
}

struct FavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    FavoritesView()
  }
}
