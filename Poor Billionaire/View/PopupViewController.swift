//
//  PopupViewController.swift
//  Poor Billionaire
//
//  Created by Ulvi Bashirov on 10/23/20.
//

import UIKit

protocol NextQuestionDelegate {
    func next()
}
class PopupViewController: UIViewController {

    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var nextBtn: UIButton! {
        didSet {
            nextBtn.layer.cornerRadius = 25
        }
    }
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var popupView: UIView! {
        didSet {
            popupView.layer.cornerRadius = 25
        }
    }
    
    var point: Int?
    var result: Bool?
    var delegate: NextQuestionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.next()
    }
    
    func setUp() {
        infoImage.image = UIImage(named: "\(result ?? false ? "correct" : "wrong")")
        pointLabel.text = "\(result ?? false ? "+" : "-") \(String(point ?? 0))"
        
        
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        delegate?.next()
        dismiss(animated: true)
    }
    
}
