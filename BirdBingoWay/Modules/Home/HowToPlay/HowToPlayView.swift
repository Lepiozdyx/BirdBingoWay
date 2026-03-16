import SwiftUI

struct HowToPlayView: View {
    @Environment(\.dismiss) var dismiss
    
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
                .padding(.horizontal)
                
                ScrollView {
                    Image(.howToPlayView)
                        .resizable().scaledToFit().padding()
                    
                    Spacer(minLength: 50.fitH)
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top, 55.fitH)
        }
    }
}
