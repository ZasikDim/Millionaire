//
//  ViewController.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var logo: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    
    var session: GameSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "startSegue":
            if let destination = segue.destination as? QuestionsViewController {
                destination.gameDelegate = self
            }
        default:
            break
        }
    }
    
    @IBAction func umnwindAction(unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        session = GameSession()
        Game.shared.session = session
    }
    
    private func startAnimation() {
        logo.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseIn]) {
            self.logo.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}

extension ViewController: GameDelegate{
    func didEndGame(questionNumber: Int, howMuchTrue: Int, howMuchFalse: Int) {
        session?.questionNumber = questionNumber
        session?.howMuchTrue = howMuchTrue
        session?.howMuchFalse = howMuchFalse
        Game.shared.getResult()

    }
}
