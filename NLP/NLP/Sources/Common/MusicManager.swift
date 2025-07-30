import AVFoundation
import Foundation

class MusicManager {
    static let shared = MusicManager()
    private var player: AVAudioPlayer?
    private(set) var currentFileName: String?

    // 효과음 재생용 AVAudioPlayer를 보관해, 소리가 끝나기 전에 해제되지 않도록 한다.
    private var effectPlayers: [AVAudioPlayer] = []

    private init() {}

    func playMusic(named fileName: String, fileExtension: String = "mp3", loop: Bool = true) {
        // 이미 같은 음악이 재생 중이면 아무것도 하지 않음
        if currentFileName == fileName, let player = player, player.isPlaying {
            return
        }

        stopMusic()

        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)

            guard let player = player else { return }

            player.numberOfLoops = loop ? -1 : 0
            player.prepareToPlay()
            player.play()
            currentFileName = fileName
            if fileName == "heart" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    print("[MusicManager] heart.wav isPlaying(0.5s): \(self?.player?.isPlaying ?? false)")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    print("[MusicManager] heart.wav isPlaying(1.0s): \(self?.player?.isPlaying ?? false)")
                }
            }
        } catch {
            print("[MusicManager] 음악 재생 실패: \(error)")
        }
    }

    func stopMusic(file: String = #file, function: String = #function, line: Int = #line) {
        guard let player = player else { return }
        player.stop()
        self.player = nil
        currentFileName = nil
    }

    var isPlaying: Bool {
        player?.isPlaying ?? false
    }

    func playClickSound() async {
        guard let url = Bundle.main.url(forResource: "click", withExtension: "wav") else {
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            await MainActor.run { [weak self] in
                self?.effectPlayers.append(player)
            }

            try? await Task.sleep(for: .seconds(player.duration + 0.1))
            await MainActor.run { [weak self] in
                self?.effectPlayers.removeAll { $0 == player }
            }
        } catch {
            print("[MusicManager] 효과음 재생 실패: \(error)")
        }
    }

    // 범용 효과음 재생
    func playEffect(named fileName: String, fileExtension: String = "mp3") {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            return
        }
        do {
            let effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer.prepareToPlay()
            effectPlayer.play()
            effectPlayers.append(effectPlayer)
            DispatchQueue.main.asyncAfter(deadline: .now() + effectPlayer.duration + 0.1) { [weak self] in
                self?.effectPlayers.removeAll { $0 == effectPlayer }
            }
        } catch {
            print("[MusicManager] 효과음 재생 실패: \(error)")
        }
    }
}
