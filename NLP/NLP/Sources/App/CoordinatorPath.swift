//
//  CoordinatorPath.swift
//  NLP
//
//  Created by Ted on 7/14/25.
//

enum CoordinatorPath: Hashable {
    /// 게임 실행 시 "이어서 진행" 또는 "처음부터 시작하기" 를 선택 가능한 화면입니다.
    case startGameScene
    /// 2045년, 인류는 스스로 신이라.... 의 멘트가 나오는 게임 첫 시작 시 세계관 설명이 진행되는 화면입니다.
    case gameIntroScene
    /// 세계관 설명이 끝난 후 암전 효과와 함께 플레이어의 게임 시작 상황을 알리는 문구가  함께 나오는 화면입니다.
    case stageOneIntroScene
    /// 플레이어가 게임 첫 시작 시 깨어나게 되는 Stage1 화면입니다.
    case stageOneScene
    /// Stage1 클리어 시 넘어가는 Stage2 화면입니다.
    case stageTwoScene
    
    /// Stage 넘어가는 사이의 스토리 전개 화면입니다.
    case middleStoryScene(StoriesType)
    
    /// Stage3 화면입니다.
    case stageThreeScene
    /// Ending, Credit 화면입니다.
    case endingCreditScene
}
