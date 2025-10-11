//
//  bibleReaderView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI

struct BibleReaderView: View {
    @EnvironmentObject var viewModel: BibleLockViewModel
    @Environment(\.dismiss) var dismiss
    
    let reading: BibleReading
    
    @State private var scrollOffset: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    @State private var showingCompletion = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Progress bar
            GeometryReader { geometry in
                ProgressView(value: min(viewModel.readingProgress.scrollProgress, 1.0))
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .frame(height: 4)
            }
            .frame(height: 4)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(reading.book) \(reading.chapter)")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("Verses \(reading.verses)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Divider()
                        }
                        .padding(.top)
                        
                        // Content
                        Text(reading.content)
                            .font(.body)
                            .lineSpacing(8)
                        
                        Spacer(minLength: 100)
                    }
                    .padding()
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: geometry.frame(in: .named("scroll")).minY
                                )
                        }
                    )
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    updateScrollProgress(offset: value)
                }
            }
            
            // Complete button
            if viewModel.readingProgress.canCompleteReading() {
                Button {
                    completeReading()
                } label: {
                    Text("Complete Reading & Unlock Apps")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                VStack(spacing: 5) {
                    Text(timeRemainingText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "timer")
                            .foregroundColor(.blue)
                        Text("Keep reading...")
                            .font(.subheadline)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.1))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.startReading()
        }
        .alert("Reading Complete!", isPresented: $showingCompletion) {
            Button("Done") {
                dismiss()
            }
        } message: {
            Text("Your apps are now unlocked! Great job staying consistent with your Bible reading.")
        }
    
    }
    
    
    var timeRemainingText: String {
        guard let startTime = viewModel.readingProgress.readingStartTime else {
            return "Start reading..."
        }
        
        let elapsed = Date().timeIntervalSince(startTime)
        let remaining = max(0, viewModel.readingProgress.minimumTimeSpent - elapsed)
        
        if remaining > 0 {
            let minutes = Int(remaining) / 60
            let seconds = Int(remaining) % 60
            return String(format: "Time remaining: %d:%02d", minutes, seconds)
        } else {
            return "Scroll to the end to complete"
        }
    }
    
    func updateScrollProgress(offset: CGFloat) {
        // Calculate scroll progress (0.0 to 1.0)
        let progress = max(0, min(1, -offset / 1000))
        viewModel.readingProgress.updateProgress(progress)
    }
    
    func completeReading() {
        viewModel.completeReading()
        showingCompletion = true
    }
}


struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce( value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    // Sample data for preview
    let sampleReading = BibleReading(
        book: "John",
        chapter: 3,
        verses: "16-18",
        content: "For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life."
    )
    let vm = BibleLockViewModel()
    return BibleReaderView(reading: sampleReading)
        .environmentObject(vm)
}
