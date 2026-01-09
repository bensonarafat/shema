//
//  ShemaAIViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 07/01/2026.
//

import Foundation
import Combine
import FirebaseAILogic

struct AIMessage : Identifiable {
    let id = UUID()
    let isUser: Bool
    let fullText: String
    var displayedText: String = ""
    var isTypingComplete: Bool {
            displayedText.count == fullText.count
        }
}

class ShemaAIViewModel: ObservableObject {
    @Published var messages: [AIMessage] = []
    @Published var isLoading: Bool = false
    
    let ai = FirebaseAI.firebaseAI(backend: .googleAI())
    private var scriptureContext: String = ""
    
    @MainActor
    func loadScriptureContext(from bibleArg: BibleArg) async {
        scriptureContext = bibleArg.verses
            .map { "\($0.book ?? 1):\($0.chapter ?? 1):\($0.verse) \($0.text)" }
            .joined(separator: "\n")
        
        let prompt = """
            You are a Bible study assistant. 
            Explain the context of the following scripture
            in a short, clear summary (4–6 sentences).

            Focus on:
            • who God is
            • what is happening in the passage
            • why it matters spiritually

            Do NOT write a long commentary.
            Do NOT use excessive detail.
            \(scriptureContext)
            """
        
        await generateAIResponse(prompt: prompt)
    }
    
    
    @MainActor
    func askFollowup (question: String) async {
        let prompt = """
            You are a Bible study assistant. 
            
            Answer the question briefly (2–4 sentences).
            Be clear, faithful to Scripture, and pastoral.

            Use the provided scripture only.

            Scripture:
            
            \(scriptureContext)
            
            Question:
            \(question)
            """
        messages.append(AIMessage(isUser: true, fullText:question, displayedText: question))
        await generateAIResponse(prompt: prompt)
    }
    
    @MainActor
    private func generateAIResponse(prompt: String) async {
        isLoading = true
        let model = ai.generativeModel(modelName: "gemini-2.5-flash")
        
        do {
            let response = try await model.generateContent(prompt)
            let text = response.text ?? "No response."
            
            messages.append(AIMessage(isUser: false, fullText: text))
            
            let index = messages.count - 1
            isLoading = false
            
            // animate typing
            await typeText(text, messageIndex: index)
        } catch {
            isLoading = false
            messages.append(
                AIMessage(isUser: false, fullText: "Something went wrong. Please try again.", displayedText: "Something went wrong. Please try again.")
            )
        }
        
    }
   
    
    @MainActor
    func typeText ( _ text: String, messageIndex: Int, typingSpeed: UInt64 = 5_000_000) async {
        for char in text {
            messages[messageIndex].displayedText.append(char)
            try? await Task.sleep(nanoseconds: typingSpeed)
        }
    }
}

