//
//  FavoritesView.swift
//  Cats
//
//  Created by Andrey on 8.11.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
  
//  var urlString: String
  
  var body: some View {
    ScrollView(.horizontal, content: {
      
      HStack(alignment: .center, spacing: 50) {
       
       Spacer()
        Image(systemName: "square.and.arrow.up.fill")
          .resizable(capInsets: EdgeInsets())
          .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
          .cornerRadius(15)
          
        
        Spacer()
      }
    })
  }
}

struct FavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    FavoritesView()
  }
}
