//
//  QuestionDetailViewController.swift
//  NetworkModuleExample
//
//  Created by Aklesh on 16/11/21.
//

import UIKit

class QuestionDetailViewController: ParentViewController {
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionTags: UILabel!
    @IBOutlet weak var questionDate: UILabel!
    @IBOutlet weak var questionDescription: UILabel!
    var question:Question?
    private var dataModel: QuestionDataModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinnerView()
        getQuestionDetail()
    }
    
    class func instance() ->QuestionDetailViewController {
        let storyBoard = UIStoryboard(name: StoryBoards.Main, bundle: nil)
      let questionDetailVC =  storyBoard.instantiateViewController(withIdentifier: QuestionDetailViewController.nameOfClass) as! QuestionDetailViewController
      return questionDetailVC
    }
    
    func getQuestionDetail() {
        if !isReachable {
            showAlertWithMessage(message: ErrorMessage.noIternet)
        }
        if let questionObject = question {
            dataModel = QuestionDataModel(question: questionObject)
            dataModel.loadQuestion { [weak self] error in
                self?.hideSpinnerView()
                if let errorObject = error {
                    self?.showAlertWithMessage(message: errorObject.localizedDescription)
                } else {
                    self?.setupDataToDispaly()
                   
                }
                
            }
        }
    }
    
    func setupDataToDispaly() {
            questionTitle.text = dataModel.question.title
            questionTags.text = dataModel.question.tagString
            questionDate.text = dataModel.question.date.formatted
        questionDescription.attributedText = dataModel.question.body?.htmlToAttributedString
    }
    

}

