//
//  ConstantMiddleStory.swift
//  NLP
//
//  Created by Ted on 7/18/25.
//
import SwiftUI

enum ConstantMiddleStories {
    static let stageOneTwo: [GameStory] = [
        GameStory(
            storyImage: UIImage(named: "middle_1"),
            storyTitle: "키리던스 현상",
            storyDescription:
                """
                그곳엔 우주개발을 위해 비밀리에 탑재한 신원소 키리듐(Keyridium) 이 저장되어 있었다. 키리듐은 상온 초전도체로서 막대한 에너지를 가질 뿐 아니라, 플라즈마와 반응 시 시간의 비대칭성을 유발할 수 있다.
                
                충돌로 인해 발생한 에너지 폭발은 단순한 폭발이 아니다. 중력 왜곡과 함께 시간의 흐름이 엉키는 ‘키리던스(Keyridance)’ 현상을 유발한다.
                
                시간은 수많은 가능성과 경우의 수를 가진 채 병렬로 존재한다. 뒤엉킨 시간이 어떤 경우의 수를 뱉을 지는 아무도 예상할 수 없다.
                """
        ),
        GameStory(
            storyImage: UIImage(named: "middle_2"),
            storyTitle: "이상한 로봇",
            storyDescription:
                """
                “나는 이해하고 싶습니다. 모든 전기신호를요.”
                
                고철 속의 감정 알고리즘, 감정도 전기신호의 일종이니 이해할 수 있다고 말하는 제인의 로봇. 제인이 정말 이상한 걸 만들었다.
                """
        )
    ]
    
    static let stageTwoThree: [GameStory] = [
        // MARK: 임시
        GameStory(
            storyImage: UIImage(named: "clock"),

            storyTitle: "시간의 비대칭성",
            storyDescription:
                """
                시간은 루프가 아닌, 깨진 유리처럼 갈라진 채로 병렬로 존재한다. “우리는 다시 돌아가는 것이 아니다. 다른 선택으로 새로운 현실을 부여하는 것 뿐이다.”

                현재는 하나이지만 미래는 수없이 많다. 평행우주 이론의 주장이다.

                한 가지를 더 덧붙이고 싶다. 최선의 미래는 우연의 산물이 아닌, 우리의 고군분투의 결과임을.
                """
        )
    ]
    
    static let stageThreeFour: [GameStory] = [
        GameStory(
            storyImage: UIImage(named: "reunion"),
            storyTitle: "재회",
            storyDescription:
                """
                드디어 셋 다 만났다. 제인은 플라즈마실에 머물며 키리듐으로 인해 일어나는 시간 왜곡 현상에 대해 의심하고 있었다.

                키리듐에 플라즈마를 반응시키는 통신장비에 대한 설계도가 거의 그려져 있었고, 아마도 미래의 제인에게서 온 메시지는 그 실험이 성공했던 것이리라. 
                """
        ),
        GameStory(
            storyImage: UIImage(named: "reunion"),

            storyTitle: "",
            storyDescription:
                """
                제인은 JTO(JOT가 맞으려나?)의 도움을 받아 통신장비 제작에 박차를 가하기 시작했고, 나와 핀은 중앙통제실에서 수신장비를 가지고 오기로 했다.
                """
        ),
        GameStory(
            storyImage: UIImage(named: "reunion"),
            storyTitle: "",
            storyDescription:
                """
                핀도 기억을 많이 되찾은 듯 했다. 비밀번호를 바꿀 수 밖에 없었던 이유에 대해 이야기를 들으며 오해를 풀 수 있었다.

                제인의 성격이 그리도 까칠했던 이유에 대해서도 알게 되었다. JTO에 대해 공감모드를 훈련시켰던 것도 궤를 같이 했다.

                모두가 각자의 자리에서 최선을 다했다.
                """
        ),
        GameStory(
            storyImage: UIImage(named: "end_positive_1"),

            storyTitle: "사라진 고향",
            storyDescription:
                """
                꽤나 고무적이었다. 지구로 돌아가기 위해 우주당국에 신호를 보내며 키리듐의 활용에 대한 새로운 획을 긋는 꿈을 꿨다.

                지구로 돌아가면 노벨 물리학상 수상은 확정이라며, 핀과 제인의 얼굴엔 활기가 돋았다.

                적어도 미래의 제인이 보낸 새로운 신호를 받아보기 전까지는 말이다.
                """
        )
    ]
    
    static let endingOne: [GameStory] = [
        GameStory(
            storyImage: UIImage(named: "end_negative"),

            storyTitle: "끝",
            storyDescription: "우리는 지구의 멸망을 뒤로 하고, 키리듐 연구에 집중했다. 체력은 바닥났고, 남은 모든 연료를 다 소진하여 화성에 도달했다. 남은 희망은 키리듐을 채굴하여 이를 이용해 지구에 복귀하는 것.\n\n물론 남아있는 사람은 없을 것이다. 전부 죽었을 테니까. 하지만 이런 미래도 필요한 법이다. 수많은 미래가 존재하니까.\n\n새드 앤딩도 있어야 한다."
        ),
        GameStory(
            storyImage: UIImage(named: "end_negative"),

            storyTitle: "",
            storyDescription: "우리의 선택이 누군가에게는 게임의 엔딩 중 하나일 뿐이다.\n\n선택의 기회가 다시 찾아온다면, 나는 어떤 결정을 내렸을까? 이 짧은 이야기의 결말은 달라졌을까?"
        )
    ]
    
    static let endingTwo: [GameStory] = [
        GameStory(
            storyImage: UIImage(named: "end_positive_0"),
            storyTitle: "끝",
            storyDescription: "엄청난 폭발음, 그리고 깨질듯한 머리.\n\n모두가 동시에 동일한 두통을 겪었다. 이틀 전부터의 기억이 이상하다. 모든 종류의 선택을 전부 경험한 것만 같았다.\n\n물리학자인 제인은 키리듐이 비활성화되며 모든 미래가 통합된 것 같다고 추측했다. 다양한 브랜치가 펼쳐지다가, 다시 하나가 된 것이라는 생각.")
    ]
}

struct GameStory {
    var storyImage: UIImage? = nil
    var storyTitle: String?
    var storyDescription: String
}
