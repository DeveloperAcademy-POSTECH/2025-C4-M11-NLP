import SwiftUI
import AVFoundation

@main
struct NLPApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("[NLPApp] AVAudioSession 설정 실패: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .statusBarHidden(true)
        }
    }
}
