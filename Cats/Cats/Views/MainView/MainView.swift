//
//  ContentView.swift
//  Cats
//
//  Created by Andrey on 7.11.21.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct MainView: View {
  
  @ObservedObject var viewModel = MainViewModel()
  @State private var isAlertPresented = false
  
  var body: some View {
    
    NavigationView {
      List(viewModel.cats, id: \.self){ element in
        
        VStack {
          if let imageUrlString = element.url {
            WebImage(url: URL(string: imageUrlString))
              .placeholder {
                Text("Loading...")
              }
              .resizable()
              .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
              .cornerRadius(15)
              .padding()
          }
          
          Button(action: {
            let item = Favorites(context: viewModel.managedObjectContext)
            item.url = element.url
            PersistenceController.shared.save()
            
            isAlertPresented.toggle()
          }, label: {
            Text("Add to favorites")
          })
          .padding(.bottom, 0)
          .alert(isPresented: $isAlertPresented) {
            let button =  Alert.Button.default(Text("Ok"))
            return Alert(title: Text("Add to favorites"), dismissButton: button)
          }
        }
        .onAppear{
          if element == viewModel.cats.last {
            viewModel.fetchCats()
          }
        }
        
      }
      .padding()
      .navigationTitle(Text("Cats"))
    }
    .onAppear{
      viewModel.fetchCats()
    }
  }
  
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
