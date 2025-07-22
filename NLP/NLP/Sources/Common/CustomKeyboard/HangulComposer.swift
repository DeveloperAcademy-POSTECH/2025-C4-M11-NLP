// HangulComposer.swift
// 한글 자모 조합 유틸리티
// 참고: https://github.com/jaemyeong/Hangul/blob/main/Sources/Hangul/Hangul.swift (MIT)

import Foundation

struct HangulComposer {
    static let choseong: [String] = [
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    static let jungseong: [String] = [
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"
    ]
    static let jongseong: [String] = [
        "", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    static let complexJungseong: [String: String] = [
        "ㅗㅏ": "ㅘ", "ㅗㅐ": "ㅙ", "ㅗㅣ": "ㅚ",
        "ㅜㅓ": "ㅝ", "ㅜㅔ": "ㅞ", "ㅜㅣ": "ㅟ",
        "ㅡㅣ": "ㅢ", "ㅏㅣ": "ㅐ", "ㅑㅣ": "ㅒ", "ㅓㅣ": "ㅔ", "ㅕㅣ": "ㅖ"
    ]
    static let complexJongseong: [String: String] = [
        "ㄱㅅ": "ㄳ", "ㄴㅈ": "ㄵ", "ㄴㅎ": "ㄶ", "ㄹㄱ": "ㄺ", "ㄹㅁ": "ㄻ",
        "ㄹㅂ": "ㄼ", "ㄹㅅ": "ㄽ", "ㄹㅌ": "ㄾ", "ㄹㅍ": "ㄿ", "ㄹㅎ": "ㅀ", "ㅂㅅ": "ㅄ"
    ]

    /// 겹받침 분리: (앞받침, 넘길 초성)
    private static func splitJongseong(_ jong: String) -> (String, String) {
        // 겹받침 분리 테이블
        let map: [String: (String, String)] = [
            "ㄳ": ("ㄱ", "ㅅ"), "ㄵ": ("ㄴ", "ㅈ"), "ㄶ": ("ㄴ", "ㅎ"),
            "ㄺ": ("ㄹ", "ㄱ"), "ㄻ": ("ㄹ", "ㅁ"), "ㄼ": ("ㄹ", "ㅂ"),
            "ㄽ": ("ㄹ", "ㅅ"), "ㄾ": ("ㄹ", "ㅌ"), "ㄿ": ("ㄹ", "ㅍ"),
            "ㅀ": ("ㄹ", "ㅎ"), "ㅄ": ("ㅂ", "ㅅ")
        ]
        if let pair = map[jong] {
            return pair
        } else {
            return ("", jong) // 단일 받침이면 앞받침 없음, 전체가 초성으로 넘어감
        }
    }

    /// 자모 배열을 완성형 한글 문자열로 조합 (복합 중성/종성, 종성+중성 분리까지 완벽 지원)
    static func compose(_ jamo: [String]) -> String {
        var result = ""
        var i = 0
        while i < jamo.count {
            // 초성
            guard i < jamo.count, let choIdx = choseong.firstIndex(of: jamo[i]) else {
                result += jamo[i]
                i += 1
                continue
            }
            // 중성 (복합 모음 우선)
            var jung: String? = nil
            var jungLen = 1
            if i+2 < jamo.count, let comp = complexJungseong[jamo[i+1] + jamo[i+2]] {
                jung = comp
                jungLen = 2
            } else if i+1 < jamo.count, jungseong.contains(jamo[i+1]) {
                jung = jamo[i+1]
            }
            guard let jungStr = jung, let jungIdx = jungseong.firstIndex(of: jungStr) else {
                result += jamo[i]
                i += 1
                continue
            }
            // 종성 (복합 받침 우선)
            var jong: String? = nil
            var jongLen = 1
            if i+1+jungLen+1 < jamo.count, let comp = complexJongseong[jamo[i+1+jungLen] + jamo[i+1+jungLen+1]] {
                jong = comp
                jongLen = 2
            } else if i+1+jungLen < jamo.count, jongseong.contains(jamo[i+1+jungLen]) {
                jong = jamo[i+1+jungLen]
            }
            // 종성+중성 조합 시, 종성의 마지막 자음을 초성으로 넘김
            if let jongStr = jong, i+1+jungLen+jongLen < jamo.count, jungseong.contains(jamo[i+1+jungLen+jongLen]) {
                let (prevJong, nextCho) = splitJongseong(jongStr)
                // 이전 글자: 초성+중성+앞받침
                let scalar = 0xAC00 + (choIdx * 21 * 28) + (jungIdx * 28) + (prevJong != "" ? (jongseong.firstIndex(of: prevJong) ?? 0) : 0)
                if let uni = UnicodeScalar(scalar) {
                    result += String(uni)
                }
                // 다음 글자: 초성(분리된 받침) + 중성(새로 입력된 모음)
                let nextJamo = [nextCho, jamo[i+1+jungLen+jongLen]]
                result += compose(nextJamo)
                i = i+1+jungLen+jongLen+1
                continue
            }
            let jongIdx = jong.flatMap { jongseong.firstIndex(of: $0) } ?? 0
            let scalar = 0xAC00 + (choIdx * 21 * 28) + (jungIdx * 28) + jongIdx
            if let uni = UnicodeScalar(scalar) {
                result += String(uni)
                i += 1 + jungLen + (jong == nil ? 0 : jongLen)
            } else {
                result += jamo[i]
                i += 1
            }
        }
        return result
    }

    /// 자모 배열이 완성형 한글이 될 수 있으면 조합, 아니면 nil
    private static func tryCompose(_ jamo: [String]) -> String? {
        guard jamo.count >= 2 else { return nil }
        guard let choIdx = choseong.firstIndex(of: jamo[0]),
              let jungIdx = jungseong.firstIndex(of: jamo[1]) else { return nil }
        var jongIdx = 0
        if jamo.count >= 3, let idx = jongseong.firstIndex(of: jamo[2]) {
            jongIdx = idx
        }
        let scalar = 0xAC00 + (choIdx * 21 * 28) + (jungIdx * 28) + jongIdx
        if let uni = UnicodeScalar(scalar) {
            return String(uni)
        }
        return nil
    }
}

