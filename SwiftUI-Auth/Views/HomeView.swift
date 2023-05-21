//
//  HomeView.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/13/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isChatOpen: Bool = true
    
    @StateObject var chatModel = ChatHelper()
    
    
    @State var dummyTodoData: [String] = ["eat lunch", "read before bed", "study for finals"]
    
    
    var body: some View {
        VStack {
            HStack {
                Text(isChatOpen ? "Chat" : "Todos")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
            }
            .padding()
            .onTapGesture {
                withAnimation {
                    isChatOpen.toggle()
                }
            }
            
            Spacer()
            
            if isChatOpen {
                ChatView(chatModel: chatModel)
                
            } else {
                
                List {
                    ForEach(dummyTodoData, id: \.self) { todo in
                        
                        Text(todo)
                        
                    }.onDelete { indexTodo in
                        self.dummyTodoData.remove(atOffsets: indexTodo)
                    }
                }
                
            }
            
            
            
        }
        .environment(\.colorScheme, isChatOpen ? .light : .dark)
        .background(
            Color(isChatOpen ? .white : .black).edgesIgnoringSafeArea(.all)
        )
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
