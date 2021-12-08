//
//  QuestionDB.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import Foundation

class QuestionDB {
    
    private var defaulQuestions: [Question]
    
    private let resultsCaretaker = AddQuestionMomento()

    private(set) var userQuestions: [Question] {
        didSet {
            resultsCaretaker.save(questions: self.userQuestions)
        }
    }
    
    init() {
        defaulQuestions = [Question(question: "Каким был первый полнометражный анимационный фильм?",
                                 answers: [Answer(answer: "Покахонтас"),
                                          Answer(answer: "Белоснежка и семь гномов"),
                                          Answer(answer: "Русалочка"),
                                          Answer(answer: "Золушка")],
                                 correctAnswer: "Белоснежка и семь гномов"),
                        Question(question: "Олимпийские игры проводятся каждые сколько лет?",
                                                 answers: [Answer(answer: "Шесть лет"),
                                                          Answer(answer: "Пять лет"),
                                                          Answer(answer: "Четыре года"),
                                                           Answer(answer: "Три года"),
                                                          Answer(answer: "Два года")],
                                                 correctAnswer: "Четыре года"),
                        Question(question: "Символом какого ресторана является клоун?",
                                                 answers: [Answer(answer: "Макдональдс"),
                                                          Answer(answer: "Бургер Кинг"),
                                                          Answer(answer: "KFC"),
                                                          Answer(answer: "Кофемания")],
                                                 correctAnswer: "Макдональдс"),
                        Question(question: "Как зовут домашнюю обезьянку Росса в сериале “Друзья”?",
                                                 answers: [Answer(answer: "Малыш"),
                                                          Answer(answer: "Лесси"),
                                                          Answer(answer: "Марли"),
                                                          Answer(answer: "Марсель")],
                                                 correctAnswer: "Марсель"),
                        Question(question: "Какой автор написал книги “Игра престолов”?",
                                                 answers: [Answer(answer: "К. С. Льюис"),
                                                          Answer(answer: "Джордж Р. Р. Мартин"),
                                                          Answer(answer: "Дж. Р. Р. Толкиен"),
                                                          Answer(answer: "Дж. К. Роулинг")],
                                                 correctAnswer: "Джордж Р. Р. Мартин"),
        ]
        userQuestions = resultsCaretaker.loadQuestion()
    }
    
    func getQuestions() -> [Question] {
        return userQuestions + defaulQuestions
    }
    
    func addQuestion(_ question: Question) {
        userQuestions.append(question)
    }
    
}
