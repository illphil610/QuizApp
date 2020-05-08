//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Philip on 5/8/20.
//  Copyright © 2020 NewWesternDev. All rights reserved.
//

import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell { }
class WrongAnswerCell: UITableViewCell { }

class ResultsViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private lazy var summary = { String() }()
    private lazy var answers = { [PresentableAnswer]() }()
    
    convenience init(with summary: String, answers: [PresentableAnswer]) {
        self.init()
        
        self.summary = summary
        self.answers = answers
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = summary
    }

}

extension ResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
    }
    
}
