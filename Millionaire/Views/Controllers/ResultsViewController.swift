//
//  ResultsViewController.swift
//  Millionaire
//
//  Created by Dmitry Zasenko on 30.11.21.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    
    private var results: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        takeResults()
        resultTableView.delegate = self
        resultTableView.dataSource = self

    }
    
    @IBAction func clearAllResults(_ sender: UIButton) {
        Game.shared.clearResult()
        resultTableView.reloadData()
    }
    
    private func takeResults() {
        if Game.shared.results.isEmpty {
            clearButton.isHidden = true
        } else {
            results = Game.shared.results
        }
    }
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsCell.identifier) as! ResultsCell
        cell.configure(result: result)
        return cell
    }
}
