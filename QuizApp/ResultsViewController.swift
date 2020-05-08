//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Philip on 5/8/20.
//  Copyright © 2020 NewWesternDev. All rights reserved.
//

import UIKit

struct PresentableAnswer {
    let question: String
    let answer: String
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
}

class WrongAnswerCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
}

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
        tableView.register(UINib(nibName: "CorrectAnswerCell", bundle: nil), forCellReuseIdentifier: "CorrectAnswerCell")
        tableView.register(UINib(nibName: "WrongAnswerCell", bundle: nil), forCellReuseIdentifier: "WrongAnswerCell")
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
        if answer.isCorrect {
            return correctAnswerCell(for: answer)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "WrongAnswerCell") as! WrongAnswerCell
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        return cell
    }
    
}

fileprivate extension ResultsViewController {
    
    func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectAnswerCell") as! CorrectAnswerCell
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
}
