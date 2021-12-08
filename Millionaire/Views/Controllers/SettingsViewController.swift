//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 03.12.21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var orderOfQuestionsControl: UISegmentedControl!
    
    private var selectedOrderOfQuestion: OrderOfQuestions {
        switch self.orderOfQuestionsControl.selectedSegmentIndex {
        case 0:
            return .straight
        case 1:
            return .random
        default:
            return .straight
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch Game.shared.orderOfQuestions {
        case .random:
            orderOfQuestionsControl.selectedSegmentIndex = 1
        default:
            orderOfQuestionsControl.selectedSegmentIndex = 0
        }
        
    }
    @IBAction func orderControlChanged(_ sender: UISegmentedControl) {
        Game.shared.orderOfQuestions = selectedOrderOfQuestion
    }
    
    @IBAction func umnwindAction(unwindSegue: UIStoryboardSegue) {
    }
    

}

