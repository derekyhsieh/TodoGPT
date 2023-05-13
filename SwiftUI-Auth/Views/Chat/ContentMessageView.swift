//
//  ContentMessageView.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/13/23.
//

import SwiftUI

struct ContentMessageView: View {
    
    var messageContent: String
    var isCurrentUser: Bool
    
    var body: some View {
        
        if(messageContent == "LOADING") {
            
            TypingIndicator()
                .padding(10)
                .foregroundColor(isCurrentUser ? Color.white : Color.black)
                .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                .cornerRadius(10)
            
        } else {
            Text(messageContent)
                .padding(10)
                .foregroundColor(isCurrentUser ? Color.white : Color.black)
                .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
                .cornerRadius(10)
            
        }
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMessageView(messageContent: "Hello world", isCurrentUser: true)
    }
}
