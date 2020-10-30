//
//  AnswerCollectionViewCell.swift
//  Poor Billionaire
//
//  Created by Ulvi Bashirov on 10/22/20.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBg: UIView! {
        didSet {
            cellBg.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var answerLabel: UILabel!
    
    var labelStr: String? = ""
    var bgColor: UIColor? = UIColor(red: 112 / 255, green: 11 / 255, blue: 113 / 255, alpha: 1)
    
    func setUp() {
        answerLabel.text = labelStr
        cellBg.backgroundColor = bgColor
    }
    
    override func prepareForReuse() {
        cellBg.backgroundColor = UIColor(red: 112 / 255, green: 11 / 255, blue: 113 / 255, alpha: 1)
    }
}
