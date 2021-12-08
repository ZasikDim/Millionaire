//
//  AddQuestionViewController.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 07.12.21.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var questionLable: UITextField!
    @IBOutlet weak var correctAnswerLable: UITextField!
    @IBOutlet weak var answerTwoLable: UITextField!
    @IBOutlet weak var answerThreeLable: UITextField!
    @IBOutlet weak var answerFourLable: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func addQuestion(_ sender: UIButton) {
        let question = createQuestion()
        QuestionDB().addQuestion(question)
    }
    
    private func createQuestion() -> Question {
        var answers: [Answer] = []
        let questionText = questionLable.text ?? ""
        let correctAnswer = correctAnswerLable.text ?? ""
        let answerTwo = answerTwoLable.text ?? ""
        let answerThree = answerThreeLable.text ?? ""
        let answerFour = answerFourLable.text ?? ""
        answers.append(Answer(answer: correctAnswer))
        answers.append(Answer(answer: answerTwo))
        answers.append(Answer(answer: answerThree))
        answers.append(Answer(answer: answerFour))
        answers.shuffle()
        let question = Question(question: questionText, answers: answers, correctAnswer: correctAnswer)
        return question
    }
    
    //MARK: - Keyboard
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
}
