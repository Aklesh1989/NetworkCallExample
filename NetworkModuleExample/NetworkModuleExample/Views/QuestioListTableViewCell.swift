//
//  QuestioListTableViewCell.swift
//  NetworkModuleExample
//
//  Created by Aklesh on 15/11/21.
//

import UIKit



class QuestioListTableViewCell: UITableViewCell {
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionTags: UILabel!
    @IBOutlet weak var questionDate: UILabel!
    
    var question:Question! {
        didSet {
            setupDataToDispaly()
        }
    }
    
    private var tags: String {
        if question.tags.count > 0 {
            return question.tags[0] + question.tags.dropFirst().reduce("") { $0 + ", " + $1 }
        } else {
            return "No tags available for now."
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupDataToDispaly() {
        questionTitle.text = question.title
        questionTags.text = question.tagString
        questionDate.text = question.date.formatted
    }

}
