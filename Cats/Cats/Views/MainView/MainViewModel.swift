//
//  MainViewModel.swift
//  Cats
//
//  Created by Andrey on 7.11.21.
//

import Foundation
import Combine
import SwiftUI

class MainViewModel: ObservableObject {
  
  private let networkService = NetworkService()
  
  @Published var cats: [CatsResponce] = []
  
  var cancellable: AnyCancellable?
  
  func fetchCats() {
    
    cancellable = networkService.load().sink(receiveCompletion: { _ in
    }, receiveValue: { [weak self] responce in
      self?.cats = responce
    })
    
  }
  
}
