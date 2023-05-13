//
//  MessageView.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/13/23.
//

import SwiftUI

struct MessageView: View {
    
    let message: MessageData
    
    var body: some View {
        HStack(spacing: 8) {
            
            if(message.user == .system) {
                Image(systemName: "person")
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
            } else {
                Spacer()
            }
            ContentMessageView(messageContent: message.content, isCurrentUser: message.user == .system ? false : true)
            
            if(message.user == .system) {
                Spacer()
            }
            
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: MessageData(content: "Hello world", user: .user))
    }
}
