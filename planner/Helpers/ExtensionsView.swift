//
//  ExtensionsView.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import SwiftUI

extension View {
      func HorizontalAlign(_ alignment: Alignment) -> some View {
            self
                  .frame(maxWidth: .infinity, alignment: alignment)
      }
      
      func VerticalAlign(_ alignment: Alignment) -> some View {
            self
                  .frame(maxHeight: .infinity, alignment: alignment)
      }
}
