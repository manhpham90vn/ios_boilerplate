//
//  PKHUD+Extensions.swift
//  StoryApp
//
//  Created by Manh Pham on 14/06/2021.
//

import Foundation
import PKHUD

extension Reactive where Base: PKHUD {

    static var isAnimating: Binder<Bool> {
        return Binder(UIApplication.shared) {_, isVisible in
            if isVisible {
                HUD.show(.progress)
                UIApplication.shared.beginIgnoringInteractionEvents()
            } else {
                HUD.hide()
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }

}
