//
//  ChatView.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/13/23.
//

import SwiftUI

struct ChatView: View {
    
    @State private var typingMessage: String = ""
    
    private let dummyMessages: [MessageData] = [
        MessageData(content: "Hello world", user: .system),
        MessageData(content: "I'm doing great", user: .user),
        MessageData(content: "Thats great to hear", user: .system),
        MessageData(content: "Can you help me with my todolist", user: .user),
        MessageData(content: "LOADING", user: .system),
    ]
    
    
    var body: some View {
        VStack {
            Spacer()
            
            ScrollView {
                
                ForEach(dummyMessages, id: \.self) { message in
                    
                    MessageView(message: message)
                    
                }
            }
            .padding()
            
            
            HStack {
                TextField("Type your message here", text: $typingMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                
                Button(action: {}) {
                    Text("Send")
                }
            }.frame(minHeight: 50).padding()
            
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
