import SwiftUI

struct WinView: View {
    let elapsedTime: TimeInterval
    let onRestart: () -> Void
    let onHome: () -> Void
    
    private var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ZStack {
                    Image(.winView)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 40.fitW)
                    
                    VStack(spacing: 20.fitH) {
                        Spacer()
                            .frame(height: 190.fitH)
                        
                        ZStack {
                            Image(.timeRect)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130.fitW)
                            
                            HStack(spacing: 12.fitW) {
                                
                                Text(formattedTime)
                                    .font(.system(size: 20.fitH, weight: .heavy))
                                    .foregroundColor(Color(red: 200/255, green: 50/255, blue: 50/255))
                                    .padding(.leading, 30.fitW)
                            }
                        }
                    }
                }
                
                HStack(spacing: 40.fitW) {
                    Button(action: onRestart) {
                        Image(.restartBtn)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120.fitW)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: onHome) {
                        Image(.homeBtn)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120.fitW)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 20.fitH)
            }
        }
    }
}

struct Bird: Identifiable {
    let id = UUID()
    let name: String
}

struct BirdButton: View {
    let bird: Bird
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(bird.name)
                .font(.system(size: 14.fitH, weight: .heavy))
                .foregroundColor(Color(red: 200/255, green: 50/255, blue: 50/255))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.horizontal, 12.fitW)
                .padding(.vertical, 14.fitH)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(red: 255/255, green: 235/255, blue: 180/255))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(isSelected ? Color.green : Color.clear, lineWidth: 3)
                )
        }
        .buttonStyle(.plain)
    }
}
