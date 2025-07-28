import ProjectDescription

let project = Project(
    name: "NLP",
    targets: [
        .target(
            name: "NLP",
            destinations: .iOS,
            product: .app,
            bundleId: "com.ADA.NLP",
            deploymentTargets: .iOS("26.0"),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "1.0.0",
                    "CGBundleVersion": "1",
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "UIUserInterfaceStyle": "Light",
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait",
                    ],
                    "UIStatusBarHidden": true,
                    "UIAppFonts": [
                        "Galmuri9.ttf",
                        "Galmuri11.ttf",
                        "Galmuri11-Bold.ttf",
                    ]
                ]
            ),
            sources: ["NLP/Sources/**"],
            resources: [
                "NLP/Resources/**"
            ],
            dependencies: [
            ]
        )
    ]
)
