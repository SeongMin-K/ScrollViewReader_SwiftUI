//
//  ContentView.swift
//  ScrollViewReader_SwiftUI
//
//  Created by SeongMinK on 2022/01/02.
//

import SwiftUI

struct ContentView: View {
    @State var selectedIndex = 0
    @Namespace var topID
    @Namespace var bottomID
    
    var selectedBG: (Int, Int) -> Color = { currentItemIndex, selectedItemIndex in
        return currentItemIndex == selectedItemIndex ? Color.green : Color.yellow
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    Button("Scroll to Bottom") {
                        withAnimation {
                            proxy.scrollTo(bottomID)
                        }
                    }.id(topID)
                    
                    ForEach(0..<100, content: { index in
                        Text("오늘도 빡코딩! \(index)")
                            .padding(.horizontal, 120)
                            .padding(.vertical, 20)
                            .background(selectedBG(index, selectedIndex))
                            .id(index)
                    }).onChange(of: selectedIndex, perform: { changedIndex in
                        print("changedIndex:", changedIndex)
                        withAnimation {
                            proxy.scrollTo(changedIndex, anchor: .center)
                        }
                    })
                    
                    Button("Scroll to Top") {
                        withAnimation {
                            proxy.scrollTo(topID)
                        }
                    }.id(bottomID)
                }
            }
            
            HStack(spacing: 10) {
                Button(action: {
                    selectedIndex = 7
                }, label: {
                    Text("7번으로!").padding()
                })
                Button(action: {
                    selectedIndex = 50
                }, label: {
                    Text("50번으로!").padding()
                })
                Button(action: {
                    selectedIndex = 90
                }, label: {
                    Text("90번으로!").padding()
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
