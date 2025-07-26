//
//  GradientHaptic.swift
//  NLP
//
//  Created by 양시준 on 7/25/25.
//

import CoreHaptics

class GradientHaptic {
    var hapticEngine: CHHapticEngine?
    var curve: [(time: TimeInterval, intensity: Float)] = []
    
    init() {
        prepareHaptics()
    }
    
    func setCurve(_ curve: [(time: TimeInterval, intensity: Float)]) {
        self.curve = curve
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Haptic Engine error: \(error)")
        }
    }
    
    func playHapticGradient(duration: TimeInterval) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events: [CHHapticEvent] = []
        
        for i in 0..<curve.count - 1 {
            let start = curve[i]
            let end = curve[i + 1]
            
            let intensityCurve = CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: [
                    CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: start.intensity),
                    CHHapticParameterCurve.ControlPoint(relativeTime: end.time - start.time, value: end.intensity)
                ],
                relativeTime: start.time
            )
            
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            
            let event = CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: [sharpness],
                relativeTime: start.time,
                duration: end.time - start.time
            )
            
            events.append(event)
            
            do {
                let pattern = try CHHapticPattern(events: events, parameterCurves: [intensityCurve])
                let player = try hapticEngine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play haptic gradient: \(error)")
            }
        }
    }
}
