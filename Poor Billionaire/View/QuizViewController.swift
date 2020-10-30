//
//  QuizViewController.swift
//  Poor Billionaire
//
//  Created by Ulvi Bashirov on 10/21/20.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet var background: UIView!
    @IBOutlet weak var totalPointLabel: UILabel!
    @IBOutlet weak var questionStepLabel: UILabel!
    @IBOutlet weak var infoLabelBGleft: UIView! {
        didSet {
            infoLabelBGleft.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var infoLabelBGright: UIView! {
        didSet {
            infoLabelBGright.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var questionBG: UIView! {
        didSet {
            questionBG.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var answersCollectionView: UICollectionView!
    @IBOutlet weak var questionLabel: UILabel!
    var activity: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var status: Bool = false
    var selectedIndexPath: IndexPath?
    var viewModel = QuestionsViewModel()
    var isSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        setUp()
    }
}

extension QuizViewController {
    
    func addGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.background.bounds
        
        let colorTop = UIColor.purple.cgColor
        let colorBottom = UIColor.black.cgColor
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        self.background.layer.addSublayer(gradientLayer)
        self.background.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func setUp() {
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
        activity.frame = view.bounds
        activity.center = view.center
        view.addSubview(activity)
        activity.color = UIColor.white
        
        activity.startAnimating()
        viewModel.getQuestion(diff: .easy) {
            self.setPage()
            self.updateLabel()
            self.activity.stopAnimating()
        }
        
    }
    
    func updateLabel() {
        totalPointLabel.text = String(viewModel.totalPoints)
        questionStepLabel.text = "\(String(viewModel.currentStep + 1)) / \(viewModel.questions.count)"
        levelLabel.text = String(viewModel.level)
    }
    
    func setPage() {
        questionLabel.text = viewModel.questions[viewModel.currentStep].question
        answersCollectionView.reloadData()
    }
    
    func showPopup(result: Bool, point: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "popupVC") as! PopupViewController
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        
        vc.result = result
        vc.point = point
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NextQuestionDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.questions.count != 0 {
            if let count = viewModel.questions[viewModel.currentStep].answers?.count {
                return count
            }
        }
        return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 60) / 2
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "answerCell", for: indexPath) as! AnswerCollectionViewCell
        
        if let selectedIndex = selectedIndexPath {
            //            Selected cell
            if status && selectedIndex.row == indexPath.row {
                let res = viewModel.getResult(indexPath: selectedIndex)
                if res {
                    cell.bgColor = UIColor.systemGreen
                } else {
                    cell.bgColor = UIColor.systemRed
                }
            } else {
                cell.bgColor = UIColor(red: 112 / 255, green: 11 / 255, blue: 113 / 255, alpha: 1)
            }
            
            
            
            
            if status && viewModel.questions[viewModel.currentStep].answers?[indexPath.row] == viewModel.questions[viewModel.currentStep].correctAnswer {
                // Correct cell
                
                if viewModel.questions[viewModel.currentStep].correctAnswer != viewModel.questions[viewModel.currentStep].answers?[selectedIndex.row] {
                    // Correct cell is not selected cell
                    cell.bgColor = UIColor.systemGreen
                }
            }
            
            
        }
        
        cell.labelStr = viewModel.questions[viewModel.currentStep].answers?[indexPath.row]
        cell.setUp()
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isSelected {
            isSelected = true
            selectedIndexPath = indexPath
            status = true
            collectionView.reloadData()
            if viewModel.currentStep == 10 {
                getQuestion(indexPath: indexPath)
            } else {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                    self.getQuestion(indexPath: indexPath)
                })
            }
        }
        
        
    }
    
    func getQuestion(indexPath: IndexPath) {
        self.activity.startAnimating()
        self.viewModel.tapOption(selectedIndexPath: indexPath) { (result, point) in
            //self.showPopup(result: result, point: point)
            self.status = false
            self.setPage()
            self.updateLabel()
            self.activity.stopAnimating()
            self.isSelected = false
        }
    }
    
    func next() {
        //status = false
        self.setPage()
        self.updateLabel()
        self.activity.stopAnimating()
        
    }
}
