import Foundation
import AVFoundation

class MusicManager {
    static let shared = MusicManager()
    private var player: AVAudioPlayer?
    private(set) var currentFileName: String?

    private init() {}

    func playMusic(named fileName: String, fileExtension: String = "mp3", loop: Bool = true) {
        guard currentFileName != fileName else {
            // 이미 재생 중이면 무시
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
            player?.play()
            currentFileName = fileName
        } catch {
            print("[MusicManager] 음악 재생 실패: \(error)")
        }
    }

    func stopMusic() {
        player?.stop()
        player = nil
        currentFileName = nil
    }

    var isPlaying: Bool {
        player?.isPlaying ?? false
    }
} 