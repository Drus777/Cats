//
//  String.swift
//  Cats
//
//  Created by Andrey on 7.11.21.
//

import UIKit

extension String {
  
  func load() -> UIImage {
    
    do {
      guard let url = URL(string: self) else { return UIImage() }
      let data: Data = try Data(contentsOf: url)
      return UIImage(data: data) ?? UIImage()
    } catch {
      
    }
    
    return UIImage()
  }
  
}
