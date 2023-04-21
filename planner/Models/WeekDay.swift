//
//  WeekDay.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import Foundation

struct WeekDay: Identifiable {
      var id: UUID = .init()
      var string: String
      var date: Date
      var isToday: Bool = false
}
