# 🌌 NLP (Natural Language Project)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue.svg)
![SpriteKit](https://img.shields.io/badge/SpriteKit-2D%20Game%20Engine-green.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-UI%20Framework-red.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

> **우주정거장에서 펼쳐지는 AI와 인간의 감정적 모험**  
> SwiftUI와 SpriteKit으로 구현된 iOS 어드벤처 게임

---

## 📋 목차
- [🎮 게임 소개](#-게임-소개)
- [🚀 주요 기능](#-주요-기능)
- [🛠 기술 스택](#-기술-스택)
- [📱 게임 플레이](#-게임-플레이)
- [🏗 프로젝트 구조](#-프로젝트-구조)
- [🎯 개발 과정](#-개발-과정)
- [🔧 설치 및 실행](#-설치-및-실행)
- [📖 게임 가이드](#-게임-가이드)
- [🤝 기여하기](#-기여하기)
- [📄 라이선스](#-라이선스)

---

## 🎮 게임 소개

**NLP**는 우주정거장을 배경으로 한 스토리 중심의 어드벤처 게임입니다. 플레이어는 정체불명의 사고로 인해 우주정거장에 고립된 상황에서, AI 로봇들과의 대화를 통해 진실을 파헤치게 됩니다.

### 🌟 핵심 특징
- **감정적 스토리텔링**: AI와 인간의 감정적 교감을 중심으로 한 깊이 있는 스토리
- **다중 엔딩**: 플레이어의 선택에 따라 달라지는 다양한 엔딩
- **실시간 대화 시스템**: OpenAI API를 활용한 자연스러운 AI 대화
- **몰입감 있는 환경**: 우주정거장을 재현한 2D 게임 환경

---

## 🚀 주요 기능

### 🎯 핵심 게임플레이
- **스테이지별 진행**: 4개의 주요 스테이지를 통한 점진적 스토리 전개
- **물리 기반 상호작용**: SpriteKit을 활용한 정교한 충돌 감지 및 상호작용
- **다이얼로그 시스템**: 다양한 캐릭터와의 자연스러운 대화
- **아이템 수집**: 게임 내 아이템을 통한 스토리 진행

### 🎵 사운드 & 음악
- **동적 BGM 시스템**: 상황에 따른 자동 음악 전환
- **효과음**: 버튼 클릭, 충돌, 대화 등 다양한 상황별 효과음
- **햅틱 피드백**: iOS 디바이스의 진동을 활용한 몰입감 증대

### 🎨 시각적 효과
- **페이드 전환**: 부드러운 장면 전환 효과
- **스트리밍 텍스트**: 타이핑 효과를 통한 자연스러운 텍스트 표시
- **반응형 UI**: 다양한 iOS 디바이스에 최적화된 인터페이스

---

## 🛠 기술 스택

### 📱 프레임워크 & 라이브러리
- **SwiftUI**: 모던 iOS UI 개발
- **SpriteKit**: 2D 게임 엔진 및 물리 시스템
- **Combine**: 반응형 프로그래밍
- **Foundation**: 기본 iOS 프레임워크

### 🏗 아키텍처
- **MVVM**: Model-View-ViewModel 패턴
- **Coordinator Pattern**: 화면 전환 관리
- **Protocol-Oriented Programming**: Swift의 프로토콜 지향 설계

### 🔧 개발 도구
- **Xcode 15.0+**: iOS 개발 IDE
- **Swift 5.9**: 프로그래밍 언어
- **iOS 17.0+**: 최소 지원 버전
- **Git**: 버전 관리

---

## 📱 게임 플레이

### 🎮 스테이지 구성
1. **Stage One**: 우주정거장 도킹 및 초기 탐험
2. **Stage Two**: AI 로봇과의 첫 만남과 대화
3. **Stage Three**: 핀(Finn) 캐릭터와의 만남
4. **Stage Four**: 최종 선택과 엔딩

### 🎯 주요 상호작용
- **대화 시스템**: 로봇, 컴퓨터, 산소발생기 등과의 대화
- **아이템 수집**: 수첩, PDA 등 스토리 관련 아이템
- **퍼즐 해결**: 비밀번호 입력, 기계 조작 등
- **선택지**: 스토리 진행에 영향을 주는 중요한 선택

### 🎵 음악 시스템
- **bgm_1~5**: 스테이지별 배경음악
- **bgm_oxygen**: 산소 부족 상황
- **bgm_ending**: 엔딩 전용 음악

---

## 🏗 프로젝트 구조

```
📦NLP
┣ 📂NLP
┃ ┣ 📂Sources
┃ ┃ ┣ 📂App
┃ ┃ ┃ ┣ 📜AppDelegate.swift
┃ ┃ ┃ ┣ 📜Coordinator.swift
┃ ┃ ┃ ┗ 📜CoordinatorPath.swift
┃ ┃ ┣ 📂Common
┃ ┃ ┃ ┣ 📂CustomKeyboard
┃ ┃ ┃ ┣ 📂DesignSystem
┃ ┃ ┃ ┗ 📜MusicManager.swift
┃ ┃ ┣ 📂Dialog
┃ ┃ ┃ ┣ 📜DialogManager.swift
┃ ┃ ┃ ┗ 📂Tool
┃ ┃ ┣ 📂Entity
┃ ┃ ┃ ┣ 📜Dialog.swift
┃ ┃ ┃ ┗ 📜MonologueAction.swift
┃ ┃ ┣ 📂Enum
┃ ┃ ┃ ┣ 📜DialogPartnerType.swift
┃ ┃ ┃ ┣ 📜DialogSender.swift
┃ ┃ ┃ ┗ 📜LightMode.swift
┃ ┃ ┣ 📂Game
┃ ┃ ┃ ┣ 📂Enum
┃ ┃ ┃ ┣ 📂GameScene
┃ ┃ ┃ ┣ 📂Shapes
┃ ┃ ┃ ┣ 📂Sprites
┃ ┃ ┃ ┗ 📂Stage*GameScene
┃ ┃ ┣ 📂Presentation
┃ ┃ ┃ ┣ 📂RootScene
┃ ┃ ┃ ┣ 📂Stage*Scene
┃ ┃ ┃ ┣ 📂MiddleStoryScene
┃ ┃ ┃ ┗ 📂StartGameScene
┃ ┃ ┗ 📂Utils
┃ ┃   ┣ 📂Constants
┃ ┃   ┗ 📂Extensions
┃ ┣ 📂Resources
┃ ┃ ┣ 📂Assets.xcassets
┃ ┃ ┣ 📂Fonts
┃ ┃ ┗ 📂Audio
┃ ┗ 📂Tests
┗ 📜README.md
```

### 📁 주요 디렉토리 설명
- **App**: 앱의 진입점과 네비게이션 관리
- **Common**: 공통 컴포넌트와 유틸리티
- **Dialog**: AI 대화 시스템
- **Game**: SpriteKit 게임 로직
- **Presentation**: SwiftUI 뷰와 뷰모델
- **Utils**: 상수, 확장 등 유틸리티

---

## 🎯 개발 과정

### 📅 개발 타임라인
- **2025.06.23**: 프로젝트 기획 및 설계
- **2025.07.04**: 개발 시작
- **2025.07.28**: 개발 완료
- **2025.08.01**: 프로젝트 마무리

### 🔄 개발 단계
1. **기획 단계**: 스토리 구성 및 게임플레이 설계
2. **프로토타입**: 핵심 메커니즘 구현
3. **개발 단계**: 스테이지별 기능 구현
4. **통합 단계**: 전체 시스템 통합 및 최적화
5. **테스트 단계**: 버그 수정 및 사용성 개선

### 🎨 디자인 철학
- **사용자 중심**: 직관적이고 접근하기 쉬운 인터페이스
- **몰입감**: 스토리와 게임플레이의 자연스러운 융합
- **성능**: 부드러운 60fps 게임플레이 보장

---

## 🔧 설치 및 실행

### 📋 요구사항
- iOS 17.0 이상
- Xcode 15.0 이상
- Swift 5.9 이상

### 🚀 설치 방법
```bash
# 1. 저장소 클론
git clone https://github.com/your-username/NLP.git

# 2. 프로젝트 디렉토리로 이동
cd NLP

# 3. Xcode에서 프로젝트 열기
open NLP.xcodeproj

# 4. 시뮬레이터 또는 실제 디바이스에서 실행
```

### ⚙️ 설정
1. **API 키 설정**: OpenAI API 키를 `DialogManager.swift`에 설정
2. **번들 ID**: 프로젝트 설정에서 적절한 번들 ID 설정
3. **디바이스**: iOS 17.0 이상의 디바이스 또는 시뮬레이터

---

## 📖 게임 가이드

### 🎮 기본 조작
- **터치**: 아이템 선택 및 상호작용
- **스와이프**: 캐릭터 이동 (일부 스테이지)
- **텍스트 입력**: 대화 및 비밀번호 입력

### 🎯 게임 팁
1. **대화 활용**: AI와의 대화를 통해 힌트를 얻으세요
2. **아이템 수집**: 모든 아이템을 수집하여 스토리를 완성하세요
3. **선택의 중요성**: 각 선택이 엔딩에 영향을 줍니다
4. **환경 탐험**: 우주정거장의 모든 구역을 탐험해보세요

### 🎵 음악 가이드
- 각 스테이지마다 고유한 배경음악이 있습니다
- 상황에 따라 음악이 자동으로 변경됩니다
- 엔딩에서는 특별한 음악이 재생됩니다

---

## 🤝 기여하기

### 🔧 개발 환경 설정
1. 프로젝트를 포크합니다
2. 기능 브랜치를 생성합니다 (`git checkout -b feature/AmazingFeature`)
3. 변경사항을 커밋합니다 (`git commit -m 'Add some AmazingFeature'`)
4. 브랜치에 푸시합니다 (`git push origin feature/AmazingFeature`)
5. Pull Request를 생성합니다

### 📝 코딩 컨벤션
- **Swift**: Swift API Design Guidelines 준수
- **네이밍**: 명확하고 의미있는 이름 사용
- **주석**: 복잡한 로직에 대한 적절한 주석 작성
- **테스트**: 새로운 기능에 대한 테스트 코드 작성

### 🐛 버그 리포트
버그를 발견하셨다면 [Issues](https://github.com/your-username/NLP/issues)에 등록해주세요.

---

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

---

## 👥 Team NLP

<div align="center">

| <img src="https://github.com/yangsijun.png" width="100"/><br/>**Air**<br/>[@yangsijun](https://github.com/yangsijun)<br/>iOS Developer | <img src="https://github.com/Gojaehyun.png" width="100"/><br/>**Go**<br/>[@Gojaehyeon](https://github.com/Gojaehyeon)<br/>iOS Developer | <img src="https://github.com/keon22han.png" width="100"/><br/>**Ted**<br/>[@keon22han](https://github.com/keon22han)<br/>iOS Developer |
|:---:|:---:|:---:|
| <img src="https://github.com/mingky1017.png" width="100"/><br/>**Mingky**<br/>[@mingky1017](https://github.com/mingky1017)<br/>iOS Developer | <img src="https://github.com/chawj1234.png" width="100"/><br/>**Wonjun**<br/>[@chawj1234](https://github.com/chawj1234)<br/>iOS Developer | <img src="https://github.com/freedobby77.png" width="100"/><br/>**Nyx**<br/>[@freedobby77](https://github.com/freedobby77)<br/>iOS Developer |

</div>

---

<div align="center">

**⭐ 이 프로젝트가 도움이 되었다면 스타를 눌러주세요!**

</div>
