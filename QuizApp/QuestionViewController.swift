//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Philip on 5/4/20.
//  Copyright © 2020 NewWesternDev. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var question = { String() }()
    private lazy var options = { [String]() }()
    private var selection: (([String]) -> Void)? = nil
    private let reusableIdentifier = "Cell"
    
    // MARK: Init
    
    convenience init(question: String, options: [String],
                     selection: @escaping ([String]) -> Void) {
        self.init()
        
        self.question = question
        self.options = options
        self.selection = selection
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = question
    }
    
}

// MARK: UITableViewDataSource Extension

extension QuestionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
}

// MARK: UITableViewDelegate Extension

extension QuestionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(selectedOptions(in: tableView))
        }
    }
    
    private func selectedOptions(in tableView: UITableView) -> [String] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else { return [] }
        
        return indexPaths.map { options[$0.row] }
    }
    
}

// MARK: Helpers

fileprivate extension QuestionViewController {
    
    func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reusableIdentifier)
    }
    
}
