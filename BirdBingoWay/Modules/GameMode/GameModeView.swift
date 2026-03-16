import SwiftUI

struct GameModeView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var navigateToFindByPic = false
    @State var navigateToFindByText = false
    @State var navigateToFindBySound = false

    var body: some View {
        BgView {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(.backBtn)
                            .resizable().scaledToFit().frame(height: 54.fitH)
                    }
                    
                    Spacer()
                }
                
                Image(.gameModeLbl)
                    .resizable().scaledToFit().padding(.horizontal, 100.fitW)
                
                HStack {
                    Button(action: {
                        navigateToFindByPic = true
                    }) {
                        Image(.findBirdBtn)
                            .resizable().scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 2 - 40.fitW)
                    }
                    
                    Button(action: {
                        navigateToFindByText = true
                    }) {
                        Image(.findPicBtn)
                            .resizable().scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 2 - 40.fitW)
                    }
                }
                
                Button(action: {
                    navigateToFindBySound = true
                }) {
                    Image(.findBySoundBtn)
                        .resizable().scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 2 - 40.fitW)
                }
                
                NavigationLink(destination: FindByPicView(), isActive: $navigateToFindByPic) {
                    EmptyView()
                }
                
                NavigationLink(destination: FindByText(), isActive: $navigateToFindByText) {
                    EmptyView()
                }
                
                NavigationLink(destination: FindBySoundView(), isActive: $navigateToFindBySound) {
                    EmptyView()
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 55.fitH)
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
    }
}
