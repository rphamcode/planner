//
//  HomeView.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import SwiftUI

struct HomeView: View {
      @State private var addNewTask: Bool = false
      @State private var currentDay: Date = .init()
      @State private var tasks: [Task] = samples
      
    var body: some View {
          ScrollView(.vertical, showsIndicators: false) {
                TimelineView()
                      .padding(15)
          }
          .safeAreaInset(edge: .top,spacing: 0) {
                HeaderView()
          }
          .fullScreenCover(isPresented: $addNewTask) {
                AddTaskView { task in
                      tasks.append(task)
                }
          }
    }
      
      @ViewBuilder
      func TaskRow(_ task: Task) -> some View {
            VStack(alignment: .leading, spacing: 8) {
                  Text(task.taskName.uppercased())
                        .ibmPlexMono(16, .regular)
                        .foregroundColor(task.category.color)
                        .lineLimit(1)
                  
                  if task.description != "" {
                        Text(task.description)
                              .ibmPlexMono(14, .light)
                              .foregroundColor(task.category.color.opacity(0.8))
                              .lineLimit(6)
                  }
            }
            .HorizontalAlign(.leading)
            .padding(12)
            .background {
                  ZStack(alignment: .leading) {
                        Rectangle()
                              .fill(task.category.color)
                              .frame(width: 4)
                        
                        Rectangle()
                              .fill(task.category.color.opacity(0.25))
                  }
            }
      }
      
      @ViewBuilder
      func TimelineViewRow(_ date: Date) -> some View {
            HStack(alignment: .top) {
                  Text(date.toString("h a"))
                        .ibmPlexMono(14, .regular)
                        .frame(width: 45, alignment: .leading)
                  
                  let calendar = Calendar.current
                  let filteredTasks = tasks.filter {
                        if let hour = calendar.dateComponents([.hour], from: date).hour,
                           let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour,
                           hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: currentDay) {
                              return true
                        }
                        return false
                  }
                  
                  if filteredTasks.isEmpty {
                        Rectangle()
                              .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                              .frame(height: 0.5)
                              .offset(y: 10)
                  } else {
                        VStack(spacing: 10){
                              ForEach(filteredTasks) { task in
                                    TaskRow(task)
                              }
                        }
                  }
            }
            .HorizontalAlign(.leading)
            .padding(.vertical,15)
      }
      
      @ViewBuilder
      func TimelineView() -> some View {
            ScrollViewReader { proxy in
                  let hours = Calendar.current.hours
                  let midHour = hours[hours.count / 2]
                  
                  VStack{
                        ForEach(hours,id: \.self) { hour in
                              TimelineViewRow(hour)
                                    .id(hour)
                        }
                  }
                  .onAppear {
                        proxy.scrollTo(midHour)
                  }
            }
      }
      
      @ViewBuilder
      func WeekRow() -> some View {
            HStack(spacing: 0) {
                  ForEach(Calendar.current.currentWeek) { weekDay in
                        let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                        
                        VStack(spacing: 6) {
                              Text(weekDay.string.prefix(3))
                                    .ibmPlexMono(12, .medium)
                              Text(weekDay.date.toString("dd"))
                                    .ibmPlexMono(16, status ? .medium : .regular)
                        }
                        .overlay(alignment: .bottom, content: {
                              if weekDay.isToday{
                                    Circle()
                                          .frame(width: 6, height: 6)
                                          .offset(y: 12)
                              }
                        })
                        .foregroundColor(status ? Color("Green") : .gray)
                        .HorizontalAlign(.center)
                        .contentShape(Rectangle())
                        .onTapGesture {
                              withAnimation(.easeInOut(duration: 0.3)){
                                    currentDay = weekDay.date
                              }
                        }
                  }
            }
            .padding(.vertical,10)
            .padding(.horizontal,-15)
      }
      
      @ViewBuilder
      func HeaderView() -> some View {
            VStack {
                  HStack {
                        VStack(alignment: .leading, spacing: 6) {
                              Text("Today")
                                    .ibmPlexMono(30, .light)
                        }
                        .HorizontalAlign(.leading)
                        
                        Button {
                              addNewTask.toggle()
                        } label: {
                              HStack(spacing: 10) {
                                    Image(systemName: "plus")
                                    Text("Add Task")
                                          .ibmPlexMono(15, .regular)
                              }
                              .padding(.vertical, 10)
                              .padding(.horizontal, 15)
                              .background {
                                    Capsule()
                                          .fill(Color("Green").gradient)
                              }
                              .foregroundColor(.white)
                        }
                  }
                  
                  Text(Date().toString("MMM YYYY"))
                        .ibmPlexMono(16, .medium)
                        .HorizontalAlign(.leading)
                        .padding(.top, 15)
                  
                  WeekRow()
            }
            .padding(15)
            .background {
                  VStack(spacing: 0) {
                        Color.white
                        
                        Rectangle()
                              .fill(.linearGradient(colors: [
                                    .white,
                                    .clear
                              ], startPoint: .top, endPoint: .bottom))
                              .frame(height: 20)
                  }
                  .ignoresSafeArea()
            }
      }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
