//
//  ChatView.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/13/23.
//

import SwiftUI

struct ChatView: View {
    
    @State private var typingMessage: String = ""
    @StateObject var chatModel: ChatHelper
    
    
    func sendMessage() {
        let newMessage = MessageData(content: typingMessage, user: .user)
        
        chatModel.sendMessage(newMessage)
        
        self.typingMessage = ""
        
        Task {
            await chatModel.getAIResponse()
        }
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            
            ScrollView {
                
                ForEach(chatModel.messages, id: \.self) { message in
                    
                    MessageView(message: message)
                    
                }
            }
            .padding()
            
            
            HStack {
                TextField("Type your message here", text: $typingMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                
                Button(action: {
                    
                    sendMessage()
                }) {
                    Text("Send")
                }
            }.frame(minHeight: 50).padding()
            
        }
    }
}
//
//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
