//
//  ResultsCell.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import UIKit

class ResultsCell: UITableViewCell {
    
    static let identifier = "ResultsCell"

    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var gameScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stack.setCorner(radius: 24)
    }
    
    func configure(result: Result) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:MM"
        gameDate.text = dateFormatter.string(from: result.date)
        gameScore.text = String(result.score)
        
        switch result.score {
        case 0...20:
            stack.backgroundColor = .systemRed
        case 80...100:
            stack.backgroundColor = .systemGreen
        default:
            stack.backgroundColor = .systemOrange
        }
    }
    
}
