//
//  Path.swift
//  voiceMemo
//

import Foundation

@available(iOS 13.0, *)
class PathModel: ObservableObject {
  @Published var paths: [PathType]
  
  init(paths: [PathType] = []) {
    self.paths = paths
  }
}
