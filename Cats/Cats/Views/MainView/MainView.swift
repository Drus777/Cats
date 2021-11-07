//
//  ContentView.swift
//  Cats
//
//  Created by Andrey on 7.11.21.
//

import SwiftUI
import Combine

struct ContentView: View {
  
  @ObservedObject var viewModel = MainViewModel()
  
  var body: some View {
    NavigationView {
      
      List(viewModel.cats, id: \.self){ cats in
        
        if let imageUrl = cats.url {
          Image(uiImage: imageUrl.load())
            .resizable()
            .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
            .cornerRadius(15)
            .padding()
        }
      }.padding()
      
    }
    .onAppear{
      viewModel.fetchCats()
    }
//    .navigationTitle(Text("Cats"))
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
