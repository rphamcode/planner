//
//  Task.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import Foundation

struct Task: Identifiable {
      var id: UUID = .init()
      var taskName: String
      var dateAdded: Date
      var description: String
      var category: Category
}

var samples: [Task] = [
      .init(taskName: "Example Task 1", dateAdded: Date(timeIntervalSince1970: 1682102790), description: "", category: .general),
      .init(taskName: "Example Task 2", dateAdded: Date(timeIntervalSince1970: 1682102770), description: "", category: .work),
      .init(taskName: "Example Task 3", dateAdded: Date(timeIntervalSince1970: 1682102750), description: "", category: .study),
      .init(taskName: "Example Task 4", dateAdded: Date(timeIntervalSince1970: 1682102730), description: "", category: .hobby),
      .init(taskName: "Example Task 5", dateAdded: Date(timeIntervalSince1970: 1682102710), description: "", category: .rest),
      .init(taskName: "Example Task 6", dateAdded: Date(timeIntervalSince1970: 1682102650), description: "", category: .idea),
]
