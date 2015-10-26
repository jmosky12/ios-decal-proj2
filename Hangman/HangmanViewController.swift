//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var hangmanStateIV: UIImageView!
    @IBOutlet weak var lettersGuessedLabel: UILabel!
    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var nextGuessLabel: UILabel!
    
    var numGuesses: Int = 0
    let hangman = Hangman()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let beach: UIImage = UIImage(named: "sky")!
        view.backgroundColor = UIColor(patternImage: beach)
        lettersGuessedLabel.text = ""
        hangmanStateIV.image = UIImage(named: "hangman1")
        hangman.start()
    }
    
    @IBAction func letterPressed(sender: UIButton) {
        let letter: String = (sender.titleLabel?.text)!
        let result = hangman.guessLetter(letter)
        if result == false {
            let guesses: String = hangman.guesses()
            lettersGuessedLabel.text = guesses
            numGuesses++
        }
        
        
        sender.hidden = true
        
        if hangman.answer == hangman.knownString {
            let alert = UIAlertController(title: "You Win!", message: "Good work out there captain.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            newGamePressed()
        } else if numGuesses == 7 {
            let alert = UIAlertController(title: "You Lose!", message: "Better luck next time.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            newGamePressed()
        }
    }
    
    @IBAction func newGamePressed() {
        hangman.start()
        lettersGuessedLabel.text = ""
        numGuesses = 0
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.hidden = false
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

