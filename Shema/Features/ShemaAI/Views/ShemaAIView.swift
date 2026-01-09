//
//  ShemaAIView.swift
//  Shema
//
//  Created by Benson Arafat on 07/01/2026.
//

import SwiftUI

struct ShemaAIView: View {
    var bibleArg: BibleArg
    @StateObject private var viewModel: ShemaAIViewModel = ShemaAIViewModel()
    @State private var userInput: String = ""
    @FocusState private var userInputIsFocus: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            messageBubble(message)
                                .id(message.id)
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                    .padding()
                }
                
                Divider()
                
                HStack {
                    
                    ZStack (alignment: .leading) {
                        if userInput.isEmpty {
                            Text("Ask a question about this passage...")
                                .foregroundColor(.theme.secondaryTextColor)
                        }
                        TextField("", text: $userInput)
                            .foregroundColor(Color.theme.secondaryTextColor)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .textContentType(.emailAddress)
                            .onSubmit {
                                submitQuestion()
                            }
                            
                            
                    }
                    .padding()
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                userInputIsFocus ? Color.theme.secondaryColor :
                                Color.theme.surfaceColor, lineWidth: 1)
                    )
                    .focused($userInputIsFocus)
                 
                    
                    Button {
                        submitQuestion()
                    } label : {
                        Image(systemName: "paperplane.fill")
                    }
                }
                .padding()
            }
            .navigationTitle("Shema AI")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.theme.backgroundColor.ignoresSafeArea())
            .onAppear {
                Task {
                    await viewModel.loadScriptureContext(from: bibleArg)
                }
            }
            .onChange(of: viewModel.messages.count) { oldValue, newValue in
                scrollToBottom(proxy)
            }
            .onChange(of: lastDisplayedText) { oldValue, newValue in
                scrollToBottom(proxy)
            }
        }

    }
    
    func submitQuestion () {
        let question = userInput.trimmingCharacters(in: .whitespaces)
        guard !question.isEmpty else { return }
        
        userInput = ""
        
        Task {
            await viewModel.askFollowup(question: question)
        }
    }
    
    private var lastDisplayedText: String {
          viewModel.messages.last?.displayedText ?? ""
    }
    
    private func scrollToBottom(_ proxy: ScrollViewProxy) {
         guard let lastID = viewModel.messages.last?.id else { return }
         withAnimation(.easeOut(duration: 0.2)) {
             proxy.scrollTo(lastID, anchor: .bottom)
         }
     }
    
    private func messageBubble (_ message: AIMessage) -> some View {
        HStack {
            if message.isUser { Spacer() }
            
            Group {
                if message.isTypingComplete {
                    // Use AttributedString to render any inline styling/links once typing is complete
                    Text(AttributedString(message.displayedText))
                } else {
                    // While typing, render plain text to avoid partial formatting issues
                    Text(message.displayedText)
                }
            }
                .font(.fontNunitoBold(size: 18))
                .foregroundColor(.white)
                .padding()
                .background(message.isUser ? Color.theme.primaryColor.opacity(0.2) : Color.green.opacity(0.2))
                .cornerRadius(12)
                .animation(.easeOut, value: message.displayedText)
            
            if !message.isUser { Spacer() }
        }
    }
}

#Preview {
    ShemaAIView(bibleArg: BibleArg(verses: [], chapter: 1, book: nil),)
}
