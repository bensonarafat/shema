//
//  SelectAppsView.swift
//  Shema
//
//  Created by Benson Arafat on 29/10/2025.
//

import SwiftUI
import FamilyControls

struct SelectAppsView: View {
    @Binding var path: NavigationPath
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var viewModel: BibleLockViewModel
    @State var selection = FamilyActivitySelection()
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text("Connect Shema to Screen Time, Securely.")
                    .font(.fontNotoSansBlack(size: 25))
                    .lineSpacing(1.5)
                
                Text("To analyse your Screen Time on this iPhone Sheme will need your permission.")
                    .font(.fontNotoSansRegular(size: 14))
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
            
            
            Spacer()
            
            
            if viewModel.appBlockingService.blockedApps.isEmpty || viewModel.appBlockingService.blockedCategories.isEmpty {
                _appPickerButton()
            }else {
                _continueButton()
            }

        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    func _continueButton() -> some View {
        Button {
            if !viewModel.appBlockingService.blockedApps.isEmpty || !viewModel.appBlockingService.blockedCategories.isEmpty {
//                path.append(AppDestination.)
            }
        } label : {
            HStack(spacing: 20) {
                
                Text("Continue")
                    .font(.fontNotoSansMedium(size: 20))
                   
                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(
                        colorScheme == .dark ? .black :  .white)
                    .font(.system(size: 24))
            }
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 25)
            .background(colorScheme == .dark ? .white : .black)
            .cornerRadius(20)
            .padding(.horizontal, 25)
        }
    }
    
    func _appPickerButton () -> some View {
        Button {
            
            guard viewModel.appBlockingService.isAuthorized else {
                print("Permission is required to access app list")
                return
            }
            viewModel.showingAppPicker = true
            
        } label: {
           
            HStack (spacing: 20) {
                
                Image(systemName: "plus")
                    .foregroundColor(
                        colorScheme == .dark ? .black :  .white)
                    .font(.system(size: 24))
                
                Text("Select Apps to limit")
                    .font(.fontNotoSansMedium(size: 20))
                   

            }
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 25)
            .background(colorScheme == .dark ? .white : .black)
            .cornerRadius(20)
            .padding(.horizontal, 25)
            
        }.familyActivityPicker(isPresented: $viewModel.showingAppPicker, selection: $selection
        ).onChange(of: selection) { oldValue, newValue in
            viewModel.appBlockingService.saveBlockedApps(newValue)
        }

    }
}

#Preview {
    let vm = BibleLockViewModel()
    SelectAppsView(path: .constant(NavigationPath()))
        .environmentObject(vm)
}
