import Foundation
import AVFoundation

class MusicManager {
    static let shared = MusicManager()
    private var player: AVAudioPlayer?
    private(set) var currentFileName: String?

    // 효과음 재생용 AVAudioPlayer를 보관해, 소리가 끝나기 전에 해제되지 않도록 한다.
    private var effectPlayers: [AVAudioPlayer] = []

    private init() {}

    func playMusic(named fileName: String, fileExtension: String = "mp3", loop: Bool = true) {
        print("[MusicManager] playMusic called with: \(fileName).\(fileExtension)")
        // 이미 같은 음악이 재생 중이면 아무것도 하지 않음
        if currentFileName == fileName, player?.isPlaying == true {
            print("[MusicManager] 이미 같은 음악 재생 중, 무시")
            return
        }
        stopMusic()
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("[MusicManager] 파일을 찾을 수 없음: \(fileName).\(fileExtension)")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = loop ? -1 : 0
            player?.prepareToPlay()
            print("[MusicManager] AVAudioPlayer prepared, try play()")
            player?.play()
            print("[MusicManager] AVAudioPlayer play() 호출됨")
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
        print("[MusicManager] stopMusic() called from \(file):\(function):\(line)")
        player?.stop()
        player = nil
        currentFileName = nil
    }

    var isPlaying: Bool {
        player?.isPlaying ?? false
    }

    func playClickSound() {
        print("[MusicManager] playClickSound() called")
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            print("[MusicManager] try to load click.wav from bundle")
            guard let url = Bundle.main.url(forResource: "click", withExtension: "wav") else {
                print("[MusicManager] 효과음 파일을 찾을 수 없음: click.wav")
                return
            }
            do {
                print("[MusicManager] AVAudioPlayer 생성 시도")
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                print("[MusicManager] AVAudioPlayer prepared, try play()")
                player.play()
                print("[MusicManager] AVAudioPlayer play() 호출됨")
                DispatchQueue.main.async {
                    self?.effectPlayers.append(player)
                }
                DispatchQueue.global().asyncAfter(deadline: .now() + player.duration + 0.1) { [weak self] in
                    DispatchQueue.main.async {
                        self?.effectPlayers.removeAll { $0 === player }
                    }
                }
            } catch {
                print("[MusicManager] 효과음 재생 실패: \(error)")
            }
        }
    }
} 
