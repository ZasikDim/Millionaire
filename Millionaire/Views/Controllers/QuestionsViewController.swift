//
//  QuestionsViewController.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import UIKit

protocol GameDelegate: AnyObject {
    func didEndGame(questionNumber: Int, howMuchTrue: Int, howMuchFalse: Int)
}

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    weak var gameDelegate: GameDelegate?
    
    private var questions = QuestionDB.shared.allQuestions
    private var questionNumber = 0
    private var howMuchTrue = 0
    private var howMuchFalse = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
    }
    
    private func createViews() {
        if questionNumber < questions.count {
            questionLable.text = questions[questionNumber].question
            createButtons(answers: questions[questionNumber].answers)
        } else {
            winnerAnimation()
        }
    }
    
    private func createButtons(answers: [Answer]) {
        for answer in answers {
            let button = UIButton()
            button.setTitle(answer.answer, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setCorner(radius: 24)
            button.backgroundColor = UIColor.systemGray5
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(pressedAction(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func pressedAction(_ sender: UIButton) {
        let correctAnsver = questions[questionNumber].correctAnswer
        if sender.currentTitle == correctAnsver {
            questionNumber += 1
            howMuchTrue += 1
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear) {
                sender.backgroundColor = .systemGreen
            } completion: { _ in
                self.stackView.removeAllArrangedSubviews()
                self.createViews()
            }
        } else {
            questionLable.text = "Неверно!"
            questionLable.textColor = .systemRed
            calculateFalse()
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear) {
                sender.backgroundColor = .systemRed
            }
            UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseIn]) {
                self.questionLable.transform = CGAffineTransform(scaleX: 2, y: 2)
            } completion: { _ in
                self.gameFinished()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func calculateFalse() {
        howMuchFalse = questions.count - howMuchTrue
    }
    
    private func gameFinished() {
        gameDelegate?.didEndGame(questionNumber: questions.count, howMuchTrue: howMuchTrue, howMuchFalse: howMuchFalse)
    }
    
    private func winnerAnimation() {
        stackView.isHidden = true
        questionLable.text = "Победа!"
        questionLable.textColor = .systemRed
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseIn]) {
            self.questionLable.transform = CGAffineTransform(scaleX: 2, y: 2)
        } completion: { _ in
            self.gameFinished()
            self.dismiss(animated: true, completion: nil)
        }
    }

}
