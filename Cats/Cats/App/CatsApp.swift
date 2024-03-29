//
//  CatsApp.swift
//  Cats
//
//  Created by Andrey on 7.11.21.
//

import SwiftUI

@main
struct CatsApp: App {
  
  let persistenceController = PersistenceController.shared
  
  @Environment(\.scenePhase) var scenePhase
  
  var body: some Scene {
    WindowGroup {
      MainView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
    .onChange(of: scenePhase) { newScenePhase in
      switch newScenePhase {
      case .background:
        print("Scene is in background")
        persistenceController.save()
      case .inactive:
        print("Scene is inactive")
      case .active:
        print("Scene is active")
      @unknown default:
        print("Apple must have changed something")
      }
    }
  }
}
