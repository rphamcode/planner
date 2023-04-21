//
//  Category.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable {
      case general = "General"
      case work = "Work"
      case study = "Study"
      case hobby = "Hobby"
      case rest = "Rest"
      case idea = "Idea"
      
      var color: Color {
            switch self {
                  case.general:
                        return Color("Gray")
                  case .work:
                        return Color("Blue")
                  case .study:
                        return Color("Green")
                  case .hobby:
                        return Color("Maroon")
                  case .rest:
                        return Color("Red")
                  case .idea:
                        return Color("Pink")
            }
      }
}
