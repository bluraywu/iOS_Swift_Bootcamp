//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageViewOne: UIImageView!
    @IBOutlet weak var diceImageViewTwo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        let dicImages = [#imageLiteral(resourceName: "DiceOne"),
                                    #imageLiteral(resourceName: "DiceTwo"),
                                    #imageLiteral(resourceName: "DiceThree"),
                                    #imageLiteral(resourceName: "DiceFour"),
                                    #imageLiteral(resourceName: "DiceFive"),
                                    #imageLiteral(resourceName: "DiceSix"),
        ]

        let diceImageViews: [UIImageView] = [diceImageViewOne, diceImageViewTwo]
        for diceImageView in diceImageViews {
            // Closed range operator ...
            //let randomNum: Int = Int.random(in: 0...5)
            // non closed range operator ..< (exclusive)
            //let randomNum: Int = Int.random(in: 0..<6)
            // size
            //let randomNum: Int = Int.random(in: 0..<dicImages.count)
            // finally use randomElement
            diceImageView.image = dicImages.randomElement() ?? nil
        }
    }
}

