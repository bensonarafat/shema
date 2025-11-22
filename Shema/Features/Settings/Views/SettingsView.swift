//
//  SettingsView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI
import FamilyControls

struct SettingsView: View {

    @EnvironmentObject var viewModel: FamilyControlViewModel
    @State private var selection: FamilyActivitySelection = .init()
    @Environment(\.dismiss) var dismiss
    @State private var reminderTime: Date = .init()
    @State private var showingAppPicker = false
    
//    private var appManagementLabel: some View {
//        HStack {
//            Image(systemName: "apps.iphone")
//                .foregroundColor(.primary)
//            Text("Select Apps & Category to Lock")
//                .foregroundColor(.primary)
//            Spacer()
//            Text("\((viewModel.appBlockingService.blockedApps.count)+(viewModel.appBlockingService.blockedCategories.count))")
//                .foregroundColor(.primary)
//            Image(systemName: "chevron.right")
//                .foregroundColor(.secondary)
//        }
//    }
//
//    private var minimumTimeBinding: Binding<Double> {
//        Binding<Double>(
//            get: { viewModel.readingProgress.minimumTimeSpent / 60 },
//            set: { viewModel.readingProgress.minimumTimeSpent = $0 * 60 }
//        )
//    }
//    
    var body: some View {
        
        Text("Here is the settings")
    
//        Form {
//            Section ("App Management") {
//                Button {
//                    showingAppPicker = true
//                } label: {
//                    appManagementLabel
//                }
//                .familyActivityPicker(
//                    isPresented: $showingAppPicker,
//                    selection: $selection)
//                .onChange(of: selection) { _, newValue in
//                    viewModel.appBlockingService.saveBlockedApps(newValue)
//                }
//            }
//            .onAppear {
//                loadSavedSelection()
//            }
//            
//            Section("Daily Reminders") {
//                DatePicker(
//                    "Reading Reminder",
//                    selection: $reminderTime,
//                    displayedComponents: .hourAndMinute
//                )
//                .onChange(of: reminderTime) { _, newValue in
//                    let comps = Calendar.current.dateComponents([.hour, .minute], from: newValue)
//                    guard let hour = comps.hour, let minute = comps.minute else { return }
//                    viewModel.notificationService.scheduleReadingReminder(at: hour, minute: minute)
//                }
//            }
//            
//            Section ("Reading Settings") {
//                HStack {
//                    Text("Minium Reading Time")
//                    Spacer()
//                    Text("\(Int(viewModel.readingProgress.minimumTimeSpent / 60)) min")
//                        .foregroundColor(.secondary)
//                }
//                
//                Stepper(value: minimumTimeBinding, in: 1...10, step: 1) {
//                    EmptyView()
//                }
//            }
//            
//            Section("Statistics") {
//                HStack {
//                   Text("Current Streak")
//                   Spacer()
//                   Text("\(viewModel.readingProgress.currentStreak) days")
//                       .foregroundColor(.orange)
//                       .fontWeight(.semibold)
//               }
//                
//                HStack {
//                   Text("Today's Status")
//                   Spacer()
//                   if viewModel.readingProgress.hasCompletedTodaysReading {
//                       Label("Complete", systemImage: "checkmark.circle.fill")
//                           .foregroundColor(.green)
//                   } else {
//                       Label("Pending", systemImage: "clock")
//                           .foregroundColor(.orange)
//                   }
//               }
//            }
//            
//            
//            Section("Emergency Access") {
//                Button(role: .destructive) {
//                    viewModel.appBlockingService.disableBlocking()
//                } label: {
//                    Label("Unlock All Apps (Emergency)", systemImage: "exclamationmark.triangle").foregroundColor(.primary)
//                }
//            }
//            
//            
//            Section ("About") {
//                HStack {
//                    Text("Version")
//                    Spacer()
//                    Text("1.0.0")
//                        .foregroundColor(.primary)
//                }
//
//                Link(destination: URL(string: "https://yourdomain.com/privacy")!) {
//                    HStack {
//                        Text("Privacy Policy")
//                            .foregroundColor(.primary)
//                        Spacer()
//                        Image(systemName: "arrow.up.right")
//                            .font(.caption)
//                            .foregroundColor(.primary)
//                    }
//                }
//            }
//        }
//        .navigationTitle("Settings")
//        .navigationBarTitleDisplayMode(.inline)
//        
    
    }
    
    func loadSavedSelection() {
        if let loadedSelection = viewModel.appBlockingService.loadBlockedApps() {
            selection = loadedSelection
        }
    }
}

#Preview {
    let vm = FamilyControlViewModel()
    SettingsView()
        .environmentObject(vm)
}
