import SwiftUI
import AVFoundation

struct FindBySoundView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var service: HapticService?
    @State private var currentBird: Bird?
    @State private var selectedBird: Bird?
    @State private var showWinView = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var audioPlayer: AVAudioPlayer?
    
    let birds: [Bird] = [
        Bird(name: "Canary"),
        Bird(name: "Crane"),
        Bird(name: "Crow"),
        Bird(name: "Duck"),
        Bird(name: "Eagle"),
        Bird(name: "Falcon"),
        Bird(name: "Finch"),
        Bird(name: "Flamingo"),
        Bird(name: "Hawk"),
        Bird(name: "Heron"),
        Bird(name: "Hummingbird"),
        Bird(name: "Kingfisher"),
        Bird(name: "Magpie"),
        Bird(name: "Owl"),
        Bird(name: "Parrot"),
        Bird(name: "Peacock"),
        Bird(name: "Penguin"),
        Bird(name: "Pigeon"),
        Bird(name: "Seagull"),
        Bird(name: "Sparrow"),
        Bird(name: "Stork"),
        Bird(name: "Swallow"),
        Bird(name: "Swan"),
        Bird(name: "Woodpecker")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            BgView {
                VStack(spacing: 12.fitH) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(.backBtn)
                                .resizable().scaledToFit().frame(height: 54.fitH)
                        }
                        
                        Spacer()
                    }

                    Image(.findBySoundLbl)
                        .resizable().scaledToFit().padding(.horizontal, 50.fitW)
                    
                    Button(action: {
                        playBirdSound()
                    }) {
                        Image(.playSoundBtn)
                            .resizable().scaledToFit().padding(.horizontal, 100.fitW)
                    }
                    .padding(.bottom, 12.fitH)
                    
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 12.fitH) {
                            ForEach(birds, id: \.name) { bird in
                                BirdButton(
                                    bird: bird,
                                    isSelected: selectedBird?.name == bird.name,
                                    action: {
                                        checkAnswer(bird)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 30.fitH)
                    }
                    
                    Spacer()
                }
                .padding(.top, 55.fitH)
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            
            if showWinView {
                WinView(
                    elapsedTime: elapsedTime,
                    onRestart: {
                        showWinView = false
                        startNewRound()
                    },
                    onHome: {
                        dismiss()
                    }
                )
                .zIndex(100)
            }
        }
        .onAppear {
            if service == nil {
                service = HapticService(context: context)
            }
            startNewRound()
        }
        .onDisappear {
            audioPlayer?.stop()
        }
    }
    
    private func startNewRound() {
        currentBird = birds.randomElement()
        selectedBird = nil
        elapsedTime = 0
        audioPlayer?.stop()
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func playBirdSound() {
        guard let bird = currentBird else { return }
        guard let url = Bundle.main.url(forResource: bird.name, withExtension: "mp3") else {
            print("Sound file not found: \(bird.name).mp3")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    private func checkAnswer(_ bird: Bird) {
        selectedBird = bird
        
        if bird.name == currentBird?.name {
            service?.vibrateSuccess()
            stopTimer()
            audioPlayer?.stop()
            showWinView = true
        } else {
            service?.vibrateLight()
        }
    }
}
