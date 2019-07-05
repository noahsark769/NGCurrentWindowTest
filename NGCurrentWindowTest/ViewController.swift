//
//  ViewController.swift
//  NGCurrentWindowTest
//
//  Created by Noah Gilmore on 7/5/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit

func generateRandomColor() -> UIColor {
    let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
    let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black

    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
}

extension UIViewController {
    var containingScene: UIWindowScene? {
        var currentResponder: UIResponder = self
        while let responder = currentResponder.next {
            if let windowScene = responder as? UIWindowScene {
                return windowScene
            }
            currentResponder = responder
        }
        return nil
    }

    var containingSceneUsingWindow: UIWindowScene? {
        return self.view.window?.windowScene
    }
}

class ViewController: UIViewController {
    var currentSceneController: ViewController? {
        return self.containingScene?.windows.first!.rootViewController as? ViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = generateRandomColor()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap(_:))))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear!")

        print("Containing scene using responder chain: \(self.containingScene)")
        print("Containing scene using window: \(self.containingSceneUsingWindow)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View did appear!")

        print("Containing scene using responder chain: \(self.containingScene)")
        print("Containing scene using window: \(self.containingSceneUsingWindow)")
    }

    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        self.currentSceneController?.view.backgroundColor = generateRandomColor()
    }
}

