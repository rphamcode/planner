//
//  AddTaskView.swift
//  planner
//
//  Created by Pham on 4/21/23.
//

import SwiftUI

struct AddTaskView: View {
      var onAdd: (Task) -> ()
      
      @Environment(\.dismiss) private var dismiss
      @State private var taskName: String = ""
      @State private var taskDate: Date = .init()
      @State private var description: String = ""
      @State private var category: Category = .general
      
      @State private var animationColor: Color = Category.general.color
      @State private var animate: Bool = false
      
    var body: some View {
          VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 10) {
                      Button {
                            dismiss()
                      } label: {
                            Image(systemName: "chevron.left")
                                  .foregroundColor(.white)
                                  .contentShape(Rectangle())
                      }
                      
                      Text("New Task")
                            .ibmPlexMono(28, .light)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                      
                      TitleView("NAME")
                      
                      TextField("Some Task", text: $taskName)
                            .ibmPlexMono(16, .regular)
                            .tint(.white)
                            .padding(.top, 2)
                      
                      Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                      
                      TitleView("DATE")
                            .padding(.top, 15)
                      
                      HStack(alignment: .bottom, spacing: 12) {
                            HStack(spacing: 12) {
                                  Text(taskDate.toString("EEEE dd, MMMM"))
                                        .ibmPlexMono(16, .regular)
                                  
                                  Image(systemName: "calendar")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                        .overlay {
                                              DatePicker("", selection: $taskDate, displayedComponents: [.date])
                                                    .blendMode(.destinationOver)
                                        }
                            }
                            .offset(y: -5)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .fill(.white.opacity(0.7))
                                    .frame(height: 1)
                                    .offset(y: 5)
                            }
                            
                            HStack(spacing: 12) {
                                  Text(taskDate.toString("hh:mm a"))
                                        .ibmPlexMono(15, .regular)
                                  
                                  Image(systemName: "clock")
                                      .font(.title3)
                                      .foregroundColor(.white)
                                      .overlay {
                                          DatePicker("", selection: $taskDate,displayedComponents: [.hourAndMinute])
                                              .blendMode(.destinationOver)
                                      }
                              }
                              .offset(y: -5)
                              .overlay(alignment: .bottom) {
                                  Rectangle()
                                      .fill(.white.opacity(0.7))
                                      .frame(height: 1)
                                      .offset(y: 5)
                              }
                      }
                      .padding(.bottom, 15)
                }
                .environment(\.colorScheme, .dark)
                .HorizontalAlign(.leading)
                .padding(15)
                .background {
                    ZStack{
                        category.color
                        
                        GeometryReader{
                            let size = $0.size
                            Rectangle()
                                .fill(animationColor)
                                .mask {
                                    Circle()
                                }
                                .frame(width: animate ? size.width * 2 : 0, height: animate ? size.height * 2 : 0)
                                .offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
                        }
                        .clipped()
                    }
                    .ignoresSafeArea()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    TitleView("DESCRIPTION",.gray)
                    
                    TextField("About The Task", text: $description)
                        .ibmPlexMono(16, .regular)
                        .padding(.top,2)
                    
                    Rectangle()
                        .fill(.black.opacity(0.2))
                        .frame(height: 1)
                    
                    TitleView("CATEGORY",.gray)
                        .padding(.top,15)
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible(),spacing: 20), count: 3),spacing: 15) {
                        ForEach(Category.allCases,id: \.rawValue) { category in
                            Text(category.rawValue.uppercased())
                                .ibmPlexMono(12, .regular)
                                .HorizontalAlign(.center)
                                .padding(.vertical,5)
                                .background {
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .fill(category.color.opacity(0.25))
                                }
                                .foregroundColor(category.color)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    guard !animate else { return }
                                    animationColor = category.color
                                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1, blendDuration: 1)) {
                                        animate = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                        animate = false
                                          self.category = category
                                    }
                                }
                        }
                    }
                    .padding(.top,5)
                    
                    Button {
                        let task = Task(taskName: taskName, dateAdded: taskDate, description: description, category: category)
                        onAdd(task)
                        dismiss()
                    } label: {
                        Text("Create Task")
                            .ibmPlexMono(16, .regular)
                            .foregroundColor(.white)
                            .padding(.vertical,15)
                            .HorizontalAlign(.center)
                            .background {
                                Capsule()
                                    .fill(animationColor.gradient)
                            }
                    }
                    .VerticalAlign(.bottom)
                    .disabled(taskName == "" || animate)
                    .opacity(taskName == "" ? 0.6 : 1)
                }
                .padding(15)
          }
          .VerticalAlign(.top)
    }
      
      @ViewBuilder
      func TitleView(_ value: String, _ color: Color = .white.opacity(0.7)) -> some View {
            Text(value)
                  .ibmPlexMono(12, .regular)
                  .foregroundColor(color)
      }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
          AddTaskView { task in }
    }
}
