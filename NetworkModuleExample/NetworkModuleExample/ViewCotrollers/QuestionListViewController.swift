//
//  ViewController.swift
//  NetworkModuleExample
//
//  Created by Aklesh on 07/11/21.
//

import UIKit

class QuestionListViewController: ParentViewController {
    @IBOutlet weak var questionListTableView: UITableView!
    private var dataModel = QuestionsDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        removeBackBarButton()
        showSpinnerView()
        getQuestionList()
       
    }
    
    func prepareUI() {
        questionListTableView.rowHeight = UITableView.automaticDimension
        questionListTableView.estimatedRowHeight = 150
    }
    
    func getQuestionList() {
        if !isReachable {
            showAlertWithMessage(message: ErrorMessage.noIternet)
            return
        }
        dataModel.fetchTopQuestions { [weak self] error in
            self?.hideSpinnerView()
            if let errorObject = error {
                self?.showAlertWithMessage(message: errorObject.localizedDescription)
            } else {
                self?.questionListTableView.reloadData()
                
            }
        }
    }
    
    func showQuestionDetail(question:Question) {
        let questionDetailVC = QuestionDetailViewController.instance()
        questionDetailVC.question = question
        self.navigationController?.pushViewController(questionDetailVC, animated: true)
    }


}
 
extension QuestionListViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: QuestioListTableViewCell.nameOfClass) as! QuestioListTableViewCell
        let question = dataModel.questions[indexPath.row]
        cell.question = question
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = dataModel.questions[indexPath.row]
        self.showQuestionDetail(question: question)
    }
    
    
}





