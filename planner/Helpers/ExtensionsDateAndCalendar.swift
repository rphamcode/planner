//
//  ExtensionsDateAndCalendar.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import SwiftUI

extension Date {
      func toString(_ format: String) -> String {
            let converter = DateFormatter()
            converter.dateFormat = format
            
            return converter.string(from: self)
      }
}

extension Calendar {
      var hours: [Date] {
            let start = self.startOfDay(for: Date())
            var hours: [Date] = []
            
            for index in  0..<24 {
                  if let date = self.date(byAdding: .hour, value: index, to: start) {
                        hours.append(date)
                  }
            }
            
            return hours
      }
      
      var currentWeek: [WeekDay]{
            guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else{return []}
            var week: [WeekDay] = []
            for index in 0..<7{
                  if let day = self.date(byAdding: .day, value: index, to: firstWeekDay){
                        let weekDaySymbol: String = day.toString("EEEE")
                        let isToday = self.isDateInToday(day)
                        week.append(.init(string: weekDaySymbol, date: day,isToday: isToday))
                  }
            }
            
            return week
      }
}
