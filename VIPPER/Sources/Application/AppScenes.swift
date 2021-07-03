//
//  AppScenes.swift
//  VIPPER
//
//  Created by Manh Pham on 06/06/2021.
//

enum AppScenes {
    case main
    case login
    case detail(event: Event)

    var viewController: UIViewController {
        switch self {
        case .main:
            let vc = StoryboardScene.Home.initialScene.instantiate()
            return MainRouter(viewController: vc).viewController
        case .login:
            let vc = StoryboardScene.Login.initialScene.instantiate()
            return LoginRouter(viewController: vc).viewController
        case let .detail(event):
            let vc = StoryboardScene.Detail.initialScene.instantiate()
            vc.title = event.repo?.name
            return DetailRouter(viewController: vc).viewController
        }
    }
}
