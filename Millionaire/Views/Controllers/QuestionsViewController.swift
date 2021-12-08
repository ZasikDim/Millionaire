//
//  QuestionsViewController.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import UIKit

protocol GameDelegate: AnyObject {
    func didEndGame(howMuchTrue: Int, howMuchFalse: Int)
}

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionNumberStackView: UIStackView!
    @IBOutlet weak var questionNumberLable: UILabel!
    @IBOutlet weak var howMuchQuastionsLable: UILabel!
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    weak var gameDelegate: GameDelegate?
    
    var game: GameSession?
    
    private let orderOfQuestions: OrderOfQuestions = Game.shared.orderOfQuestions
    
    private lazy var createQuestionsStrategy: CreateQuestionsStrategy = {
        switch self.orderOfQuestions {
        case .straight:
            return CreateStraightQuestionStrategy()
        case .random:
            return CreateRandonQuestionStrategy()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let game = game else { return }
        howMuchQuastionsLable.text = "/ \(game.questions.count)"
        game.questions = createQuestionsStrategy.createQuestions(for: game.questions)
        game.questionNumber.addObserver(self, options: [.new, .initial], closure: { [weak self] (questionNumber, _) in
            self?.questionNumberLable.text = "\(questionNumber + 1)"
        })
        createViews()
    }
    
    @objc func pressedAction(_ sender: UIButton) {
        guard let game = game else { return }
        let correctAnsver = game.questions[game.questionNumber.value].correctAnswer
        if sender.currentTitle == correctAnsver {
            game.questionNumber.value += 1
            game.howMuchTrue += 1
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
    
    private func createViews() {
        guard let game = game else { return }
        if game.questionNumber.value < game.questions.count {
            questionLable.text = game.questions[game.questionNumber.value].question
            createButtons(answers: game.questions[game.questionNumber.value].answers)
        } else {
            winnerAnimation()
        }
    }
    
    private func createButtons(answers: [Answer]) {
        for answer in answers {
            DispatchQueue.main.async {
                let button = UIButton()
                button.setTitle(answer.answer, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.setCorner(radius: 24)
                button.backgroundColor = UIColor.systemGray5
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(self.pressedAction(_:)), for: .touchUpInside)
                self.stackView.addArrangedSubview(button)
            }
        }
    }
    
    private func calculateFalse() {
        guard let game = game else { return }
        game.howMuchFalse = game.questions.count - game.howMuchTrue
    }
    
    private func gameFinished() {
        guard let game = game else { return }
        gameDelegate?.didEndGame(howMuchTrue: game.howMuchTrue, howMuchFalse: game.howMuchFalse)
    }
    
    private func winnerAnimation() {
        stackView.isHidden = true
        questionNumberStackView.isHidden = true
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
