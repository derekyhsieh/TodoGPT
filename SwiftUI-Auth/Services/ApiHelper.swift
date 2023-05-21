//
//  ApiHelper.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/20/23.
//

import Foundation

// MARK: - ChatResponse
struct ChatResponse: Codable {
    let id, object: String
    let created: Int
    let model: String
    let usage: Usage
    let choices: [Choice]
}

// MARK: - Choice
struct Choice: Codable {
    let message: Message
    let finishReason: String
    let index: Int

    enum CodingKeys: String, CodingKey {
        case message
        case finishReason = "finish_reason"
        case index
    }
}

// MARK: - Message
struct Message: Codable {
    let role, content: String
}

struct ApiResponse: Codable {
    let response: String
    let newTodo: [String]
}


// MARK: - Usage
struct Usage: Codable {
    let promptTokens, completionTokens, totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

let OPENAI_KEY="YOUR_OPENAI_APIKEY"

func fetchChatGPTAPI(body: Data, handler: @escaping(_ response: ApiResponse?, _ plainText: String?) -> ()) {
    
    guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {return}
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST"
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(OPENAI_KEY)", forHTTPHeaderField: "Authorization")
    request.httpBody = body
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else { return }
        
//        let outputStr  = String(data: data, encoding: String.Encoding.utf8)! as String
        
        do {
            
            let response = try JSONDecoder().decode(ChatResponse.self, from: data)
            
            let jsonString = response.choices[0].message.content
            
            let jsonData = jsonString.data(using: .utf8)!
            
            do {
                
                let decoder = JSONDecoder()
                
                let apiResponse = try decoder.decode(ApiResponse.self, from: jsonData)
                
                handler(apiResponse, nil)
                
                
            } catch {
                print("Error decoding final JSON: \(error)")
                
                handler(nil, response.choices[0].message.content)
                
            }
            
            
            
        } catch {
            print(error)
        }
        
        
    }
    
    task.resume()
            
    
}

