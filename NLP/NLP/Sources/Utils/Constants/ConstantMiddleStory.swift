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
            storyImage: UIImage(named: "middle_1"),
            storyTitle: "키리던스 현상",
            storyDescription:
                """
                키리듐은 상온 초전도체로서 막대한 에너지를 가질 뿐 아니라, 플라즈마와 반응 시 시간의 비대칭성을 유발할 수 있다.
                충돌로 인해 발생한 에너지 충격은 단순한 폭발이 아니었다. 중력 왜곡과 함께, 시간 자체의 흐름이 엉키는 ‘키리던스(Keyridance)’ 현상을 낳았다.
                
                시간은 루프가 아닌, 깨진 유리처럼 갈라진 채로 병렬로 존재한다.
                “우리는 다시 돌아가는 것이 아니다. 다른 선택으로 새로운 현실을 부여하는 것 뿐이다.”
                """
        ),
        GameStory(
            storyImage: UIImage(named: "middle_2"),
            storyTitle: "이상한 로봇",
            storyDescription:
                """
                “나는 이해하려는 자입니다. 사랑이든 고장신호든.”

                철의 외피 속에 감정을 품은 자.
                말 없는 억겁의 시간을 살아가는 로봇.

                하지만 때로, 그대보다 더 인간적인 존재.
                죽은 척도, 살아 있음도, 결국 누군가를 위해서.

                그는 울지 않는다. 대신 우리를 대신해 고요 속에서 공명한다.”
                """
        )
    ]
    
    static let stageTwoThree: [GameStory] = [
        // MARK: 임시
        GameStory(
            storyTitle: "키리던스 현상",
            storyDescription:
                """
                키리듐은 상온 초전도체로서 막대한 에너지를 가질 뿐 아니라, 플라즈마와 반응 시 시간의 비대칭성을 유발할 수 있다.
                충돌로 인해 발생한 에너지 충격은 단순한 폭발이 아니었다. 중력 왜곡과 함께, 시간 자체의 흐름이 엉키는 ‘키리던스(Keyridance)’ 현상을 낳았다.
                
                시간은 루프가 아닌, 깨진 유리처럼 갈라진 채로 병렬로 존재한다. 무한한 현재와 미래가 얽혀있다.
                """
        ),
        GameStory(
            storyTitle: "이상한 로봇",
            storyDescription:
                """
                “나는 이해하려는 자입니다. 사랑이든 고장신호든.”

                철의 외피 속에 감정을 품은 자.
                말 없는 억겁의 시간을 살아가는 로봇.

                하지만 때로, 그대보다 더 인간적인 존재.
                죽은 척도, 살아 있음도, 결국 누군가를 위해서.

                그는 울지 않는다. 대신 우리를 대신해 고요 속에서 공명한다.”
                """
        )
    ]
    
    static let stageThreeFour: [GameStory] = [
        GameStory(
            storyTitle: "재회",
            storyDescription:
                """
                드디어 셋 다 만났다. 제인은 플라즈마실에 머물며 키리듐으로 인해 일어나는 시간 왜곡 현상에 대해 의심하고 있었다.

                키리듐에 플라즈마를 반응시키는 통신장비에 대한 설계도가 거의 그려져 있었고, 아마도 미래의 제인에게서 온 메시지는 그 실험이 성공했던 것이리라. 
                """
        ),
        GameStory(
            storyTitle: "",
            storyDescription:
                """
                제인은 JTO(JOT가 맞으려나?)의 도움을 받아 통신장비 제작에 박차를 가하기 시작했고, 나와 핀은 중앙통제실에서 수신장비를 가지고 오기로 했다.
                """
        ),
        GameStory(
            storyTitle: "",
            storyDescription:
                """
                핀도 기억을 많이 되찾은 듯 했다. 비밀번호를 바꿀 수 밖에 없었던 이유에 대해 이야기를 들으며 오해를 풀 수 있었다.

                제인의 성격이 그리도 까칠했던 이유에 대해서도 알게 되었다. JTO에 대해 공감모드를 훈련시켰던 것도 궤를 같이 했다.

                모두가 각자의 자리에서 최선을 다했다.
                """
        ),
        GameStory(
            storyTitle: "사라진 고향",
            storyDescription:
                """
                꽤나 고무적이었다. 지구로 돌아가기 위해 우주당국에 신호를 보내며 키리듐의 활용에 대한 새로운 획을 긋는 꿈을 꿨다.

                지구로 돌아가면 노벨 물리학상 수상은 확정이라며, 핀과 제인의 얼굴엔 활기가 돋았다.

                적어도 미래의 제인이 보낸 새로운 신호를 받아보기 전까지는 말이다.
                """
        )
    ]
}

struct GameStory {
    var storyImage: UIImage? = nil
    var storyTitle: String?
    var storyDescription: String
}
