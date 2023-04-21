//
//  FontExtension.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import SwiftUI

enum IBMPlexMono {
      case bold
      case semi_bold
      case medium
      case light
      case extra_light
      case regular
      
      var weight: Font.Weight {
            switch self {
                  case .bold:
                        return .bold
                  case .semi_bold:
                        return .semibold
                  case .medium:
                        return .medium
                  case .light:
                        return .light
                  case .extra_light:
                        return .ultraLight
                  case .regular:
                        return .regular
            }
      }
}

extension View {
      func ibmPlexMono(_ size: CGFloat, _ weight: IBMPlexMono) -> some View {
            self
                  .font(.custom("IBMPlexMono", size: size))
                  .fontWeight(weight.weight)
      }
}
