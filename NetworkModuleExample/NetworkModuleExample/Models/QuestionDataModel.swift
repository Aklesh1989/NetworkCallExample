//
//  QuestionDataModel.swift
//  NetworkModuleExample
//
//  Created by Aklesh on 07/11/21.
//

import Foundation

class QuestionDataModel: ObservableObject {
     private(set) var question: Question
     var isLoading = false
    
    private var questionRequest: APIRequest<QuestionsResource>?
    
    init(question: Question) {
        self.question = question
    }
    
    func loadQuestion(completion: @escaping (Error?) -> Void) {
        guard !isLoading else { return }
        isLoading = true
        let resource = QuestionsResource(id: question.id)
        let request = APIRequest(resource: resource)
        self.questionRequest = request
        request.execute { [weak self] questions, error  in
            if let recievedError = error {
                completion(recievedError)
            } else {
                guard let question = questions?.first else {
                    completion(nil)
                    return
                }
                self?.question = question
                completion(nil)
            }
            
        }
    }
}




class QuestionsDataModel: ObservableObject {
     private(set) var questions: [Question] = []
     private(set) var isLoading = false
    
    private var request: APIRequest<QuestionsResource>?
    
    func fetchTopQuestions(completion: @escaping (Error?) -> Void) {
        guard !isLoading else { return }
        isLoading = true
        let resource = QuestionsResource()
        let request = APIRequest(resource: resource)
        self.request = request
        request.execute { [weak self] questions,error  in
            if let recievedError = error {
                completion(recievedError)
            } else {
                self?.questions = questions ?? []
                self?.isLoading = false
                completion(nil)
            }
            
            
        }
    }
}

