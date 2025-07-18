//
//  ConstantMiddleStory.swift
//  NLP
//
//  Created by Ted on 7/18/25.
//
import SwiftUI

struct ConstantMiddleStories {
    static let stageOneTwo: [GameStory] = [
        GameStory(
            storyTitle: "키리던스 현상",
            storyDescription:
                """
                그곳엔 우주개발을 위해 비밀리에 탑재한 신원소 키리듐(Keyridium) 이 저장되어 있었다. 키리듐은 상온 초전도체로서 막대한 에너지를 가질 뿐 아니라, 플라즈마와 반응 시 시간의 비대칭성을 유발할 수 있다. \n\n충돌로 인해 발생한 에너지 충격은 단순한 폭발이 아니었다. 중력 왜곡과 함께, 시간 자체의 흐름이 엉키는 ‘키리던스(Keyridance)’ 현상을 낳았다. \n\n시간은 루프가 아닌, 깨진 유리처럼 갈라진 채로 병렬로 존재한다. “우리는 다시 돌아가는 것이 아니다. 다른 선택으로 새로운 현실을 부여하는 것 뿐이다.”
                """
        ),
        GameStory(
            storyTitle: "이상한 로봇",
            storyDescription:
                """
                그곳엔 우주개발을 위해 비밀리에 탑재한 신원소 키리듐(Keyridium) 이 저장되어 있었다. 키리듐은 상온 초전도체로서 막대한 에너지를 가질 뿐 아니라, 플라즈마와 반응 시 시간의 비대칭성을 유발할 수 있다. \n\n충돌로 인해 발생한 에너지 충격은 단순한 폭발이 아니었다. 중력 왜곡과 함께, 시간 자체의 흐름이 엉키는 ‘키리던스(Keyridance)’ 현상을 낳았다. \n\n시간은 루프가 아닌, 깨진 유리처럼 갈라진 채로 병렬로 존재한다. “우리는 다시 돌아가는 것이 아니다. 다른 선택으로 새로운 현실을 부여하는 것 뿐이다.”
                """
        )
    ]
    
    static let stageTwoThree: [GameStory] = [
        // MARK: 임시
        GameStory(
            storyTitle: "키리던스 현상",
            storyDescription:
                """
                그곳엔 우주개발을 위해 비밀리에 탑재한 신원소 키리듐(Keyridium) 이 저장되어 있었다. 키리듐은 상온 초전도체로서 막대한 에너지를 가질 뿐 아니라, 플라즈마와 반응 시 시간의 비대칭성을 유발할 수 있다. \n\n충돌로 인해 발생한 에너지 충격은 단순한 폭발이 아니었다. 중력 왜곡과 함께, 시간 자체의 흐름이 엉키는 ‘키리던스(Keyridance)’ 현상을 낳았다. \n\n시간은 루프가 아닌, 깨진 유리처럼 갈라진 채로 병렬로 존재한다. “우리는 다시 돌아가는 것이 아니다. 다른 선택으로 새로운 현실을 부여하는 것 뿐이다.”
                """
        ),
        GameStory(
            storyTitle: "이상한 로봇",
            storyDescription:
                """
                그곳엔 우주개발을 위해 비밀리에 탑재한 신원소 키리듐(Keyridium) 이 저장되어 있었다. 키리듐은 상온 초전도체로서 막대한 에너지를 가질 뿐 아니라, 플라즈마와 반응 시 시간의 비대칭성을 유발할 수 있다. \n\n충돌로 인해 발생한 에너지 충격은 단순한 폭발이 아니었다. 중력 왜곡과 함께, 시간 자체의 흐름이 엉키는 ‘키리던스(Keyridance)’ 현상을 낳았다. \n\n시간은 루프가 아닌, 깨진 유리처럼 갈라진 채로 병렬로 존재한다. “우리는 다시 돌아가는 것이 아니다. 다른 선택으로 새로운 현실을 부여하는 것 뿐이다.”
                """
        )
    ]
}

struct GameStory {
    var storyImage: UIImage?
    var storyTitle: String
    var storyDescription: String
}
