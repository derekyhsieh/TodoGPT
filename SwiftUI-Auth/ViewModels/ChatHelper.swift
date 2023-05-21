//
//  ChatHelper.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/20/23.
//

import SwiftUI




class ChatHelper: ObservableObject {
    @Published var messages: [MessageData] = [
        MessageData(content: "How can I help you today?", user: .system),
    ]
    
    
    init() {
        //        Task {
        //
        //            await getAIResponse()
        //        }
    }
    
    private func convertMessagesToGPT() -> [ChatGPTMessage] {
        var gptMessages: [ChatGPTMessage] = [ChatGPTMessage(role: "system", content: systemPrompt)]
        
        for message in messages {
            let newMessage = ChatGPTMessage(role: message.user == .system ? "assistant" : "user", content: message.content)
            
            gptMessages.append(newMessage)
        }
        
        return gptMessages
    }
    
    func sendMessage(_ chatMessage: MessageData) {
        
        DispatchQueue.main.async {
            self.messages.append(chatMessage)
        }
        
    }
    
    
    func getAIResponse() async {
        DispatchQueue.main.async {
            // update ui here
            
            self.messages.append(MessageData(content: "LOADING", user: .system))
        }
        
        let jsonBody = convertObjectTOJSON(messages: convertMessagesToGPT())
        
        fetchChatGPTAPI(body: jsonBody) { response, plainText in
            if let apiResponse = response {
                
                DispatchQueue.main.async {
                    self.messages.popLast()
                    
                    self.messages.append(MessageData(content: apiResponse.response, user: .system))
                }
            }
        }
    }
    
    
    private func convertObjectTOJSON(messages: [ChatGPTMessage]) -> Data {
        var tempMessages = messages
        
        tempMessages[tempMessages.count - 2].content = """
    Pretend you can only respond with a singular output json (given below) and NEVER include any other response before or after the response that does not conform with the following JSON output, your only output will be this JSON structure, {"response": String, "newTodo": String[]}. NEVER try to encapsulate the JSON response in a plain text introduction. Put whatever you want to say in the "response" key value pair. The response key value pair is what you will say back to the user, the newTodo is what you think is a good title for a new todo. If the user does not want to create a new todo, it's ok to return an empty array for the newTodo key value pair. The action of adding something new to the todolist can be achieved by responding with the same JSON structure and including whatever you want in the "newTodo" array. NEVER respond with anything other than the the JSON structure before, NEVER include "Here's your new JSON response" or anything after the JSON output. \nYou must only respond with the JSON schema, example response: { "response": "Hello", "newTodo": ["do homework", "eat lunch"] }\nHere is is an example: {"response": "This is a sample response to the user", "newTodo": ["new todo item title", "another todo item", "grab lunch"]}. \nThis is another example: {"response": "here is another example response", "newTodo": ["Study for test"]}\n.
"""
  
    }
}
