import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var service: HapticService?
    
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
                
                ZStack {
                    Image(.settingsRect)
                        .resizable().scaledToFit().padding()
                    
                    VStack(spacing: 20.fitH) {
                        // Vibration Section
                        VStack(spacing: 8.fitH) {
                            Image(.vibroLbl)
                                .resizable().scaledToFit().frame(height: 22.fitH)
                            
                            HStack {
                                Image(.vibroIcon)
                                    .resizable().scaledToFit().frame(height: 44.fitH)
                                
                                Spacer()
                                
                                if let service = service {
                                    Button(action: {
                                        service.toggleVibro()
                                    }) {
                                        Image(service.isVibro ? .onBtn : .offBtn)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 44.fitH)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        
                        // Volume Section
                        VStack(spacing: 8.fitH) {
                            Image(.volumeLbl)
                                .resizable().scaledToFit().frame(height: 22.fitH)
                            
                            HStack {
                                Image(.volumeIcon)
                                    .resizable().scaledToFit().frame(height: 44.fitH)
                                
                                Spacer()
                            }
                            
                            if let service = service {
                                CustomSlider(
                                    value: Binding(
                                        get: { Double(service.volumeLevel) },
                                        set: { service.updateVolumeLevel(Int($0)) }
                                    ),
                                    range: 0...10
                                )
                                .frame(height: 44.fitH)
                            }
                        }
                    }
                    .padding(.horizontal, 70.fitW)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 55.fitH)
        }
        .onAppear {
            if service == nil {
                service = HapticService(context: context)
            }
        }
    }
}
struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    
    @State private var isDragging = false
    
    var body: some View {
        HStack {
            Spacer()
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background track
                    Image(.soundRect)
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height)
                    
                    // Thumb
                    Image(.soundEll)
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height * 0.6)
                        .offset(x: thumbOffset(in: geometry.size.width))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gesture in
                                    isDragging = true
                                    updateValue(from: gesture.location.x, width: geometry.size.width)
                                }
                                .onEnded { _ in
                                    isDragging = false
                                }
                        )
                }
                .contentShape(Rectangle())
                .onTapGesture { location in
                    updateValue(from: location.x, width: geometry.size.width)
                }
            }
            .frame(width: 200.fitW)
            
            Spacer()
        }
    }
    
    private func thumbOffset(in width: CGFloat) -> CGFloat {
        let percentage = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        let thumbWidth = width * 0.08
        let availableWidth = width - thumbWidth
        return availableWidth * CGFloat(percentage)
    }
    
    private func updateValue(from x: CGFloat, width: CGFloat) {
        let thumbWidth = width * 0.08
        let availableWidth = width - thumbWidth
        let percentage = max(0, min(1, x / availableWidth))
        let newValue = range.lowerBound + (range.upperBound - range.lowerBound) * Double(percentage)
        value = round(newValue)
    }
}
