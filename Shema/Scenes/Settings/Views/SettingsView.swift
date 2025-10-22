//
//  SettingsView.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import SwiftUI
import FamilyControls

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: BibleLockViewModel
    @State var selection = FamilyActivitySelection()
    @Environment(\.dismiss) var dismiss
    @State private var reminderTime = Date()
    @State private var showingAppPicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section ("App Management") {
                    Button {
                        showingAppPicker = true
                    } label : {
                        HStack {
                            Image(systemName: "apps.iphone")
                                .foregroundColor(.primary)
                            Text("Select Apps & Category to Lock")
                                .foregroundColor(.primary)
                            Spacer()
                            
                            Text("\((viewModel.appBlockingService.blockedApps.count)+(viewModel.appBlockingService.blockedCategories.count))")
                                .foregroundColor(.primary)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                    .familyActivityPicker(
                        isPresented: $showingAppPicker,
                        selection: $selection)
                    .onChange(of: selection) { oldValue, newValue in
                        viewModel.appBlockingService.saveBlockedApps(newValue)
                    }
                }
                .onAppear {
                    loadSavedSelection()
                }
                
                Section("Daily Reminders") {
                    DatePicker(
                        "Reading Reminder",
                        selection: $reminderTime,
                        displayedComponents: .hourAndMinute
                    )
                    .onChange(of: reminderTime) { oldValue, newValue in
                        let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                        if let hour = components.hour, let minute = components.minute {
                            viewModel.notificationService.scheduleReadingReminder(at: hour, minute: minute)
                        }
                    }
                }
                
                Section ("Reading Settings") {
                    HStack {
                        Text("Minium Reading Time")
                        Spacer()
                        Text("\(Int(viewModel.readingProgress.minimumTimeSpent / 60)) min")
                            .foregroundColor(.secondary)
                    }
                    
                    Stepper(
                        value: Binding(
                            get: { viewModel.readingProgress.minimumTimeSpent / 60 },
                            set: { viewModel.readingProgress.minimumTimeSpent = $0 * 60}
                        ),
                        in: 1...10,
                        step: 1
                    ) {
                        EmptyView()
                    }
                }
                
                Section("Statistics") {
                    HStack {
                       Text("Current Streak")
                       Spacer()
                       Text("\(viewModel.readingProgress.currentStreak) days")
                           .foregroundColor(.orange)
                           .fontWeight(.semibold)
                   }
                    
                    HStack {
                       Text("Today's Status")
                       Spacer()
                       if viewModel.readingProgress.hasCompletedTodaysReading {
                           Label("Complete", systemImage: "checkmark.circle.fill")
                               .foregroundColor(.green)
                       } else {
                           Label("Pending", systemImage: "clock")
                               .foregroundColor(.orange)
                       }
                   }
                }
                
                
                Section("Emergency Access") {
                    Button(role: .destructive) {
                        viewModel.appBlockingService.disableBlocking()
                    } label: {
                        Label("Unlock All Apps (Emergency)", systemImage: "exclamationmark.triangle").foregroundColor(.primary)
                    }
                }
                
                
                Section ("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.primary)
                    }

                    Link(destination: URL(string: "https://yourdomain.com/privacy")!) {
                        HStack {
                            Text("Privacy Policy")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    func loadSavedSelection() {
        if let loadedSelection = viewModel.appBlockingService.loadBlockedApps() {
            selection = loadedSelection
        }
    }
}

#Preview {
    let vm = BibleLockViewModel()
    SettingsView()
        .environmentObject(vm)
}
