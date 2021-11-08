//
//  NetworkService.swift
//  Cats
//
//  Created by Andrey on 7.11.21.
//

import Foundation
import Combine

enum NetworkError: Error {
  case nillValue
}

final class NetworkService {
  
  private let urlString = "https://api.thecatapi.com/v1/images/search?limit=10&page=0&order=Desc"
  
  func load() -> AnyPublisher<[CatsResponce], Error> {
    
    let url = URL(string: urlString)
    guard let url = url else {
      return Fail<[CatsResponce], Error>(error: NetworkError.nillValue).eraseToAnyPublisher()
    }
    return URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: [CatsResponce].self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  
  }
  
  
}

