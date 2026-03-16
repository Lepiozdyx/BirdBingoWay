import SwiftUI
import SwiftData

struct HomeView: View {
    @State var isPresentHowToPlay = false
    @State var isSettings = false
    @State var navigateToGameMode = false
    
    var body: some View {
        NavigationStack {
            BgView {
                VStack {
                    HStack {
                        Button(action: {
                            isPresentHowToPlay = true
                        }) {
                            Image(.howToPlayBtn)
                                .resizable().scaledToFit().frame(height: 54.fitH)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            isSettings = true
                        }) {
                            Image(.settingBtn)
                                .resizable().scaledToFit().frame(height: 54.fitH)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Image(.logo)
                        .resizable().scaledToFit().padding(.horizontal, 40.fitW)
                    
                    Spacer()
                    
                    Button(action: {
                        navigateToGameMode = true
                    }) {
                        Image(.playBtn)
                            .resizable().scaledToFit().frame(height: 110.fitH)
                            .padding(.bottom, 200.fitH)
                    }
                    
                    NavigationLink(destination: GameModeView(), isActive: $navigateToGameMode) {
                        EmptyView()
                    }
                }
                .padding(.top, 55.fitH)
            }
            .navigationBarHidden(true)
            .toolbar(.hidden, for: .navigationBar)
            .fullScreenCover(isPresented: $isPresentHowToPlay) {
                HowToPlayView()
            }
            .fullScreenCover(isPresented: $isSettings) {
                SettingsView()
            }
        }
        .modelContainer(for: [
            SettingsModel.self
        ])
    }
}

#Preview {
    HomeView()
}
