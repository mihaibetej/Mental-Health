//
//  AddToExpandableListViewController.swift
//  Mental Health
//
//  Created by George Muntean on 01/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

protocol AddToExpandableListViewControllerDelegate {
    func didAdd(title: String, text: String)
}

class AddToExpandableListViewController: UIViewController {

    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var delegate: AddToExpandableListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textViewContainer.layer.borderColor = UIColor.mhBlue.cgColor
        textViewContainer.layer.borderWidth = 1
        textViewContainer.layer.cornerRadius = 8
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd, MMMM"
        dateFormatter.locale = Locale(identifier: "RO")
        dateFormatter.formattingContext = Formatter.Context.beginningOfSentence
        title = dateFormatter.string(from: Date())
    
    }
    
    //MARK: - Actions
    
    @IBAction func didTapSave(_ sender: UIButton) {
        if textView.text.isEmpty {
            let alert = UIAlertController(title: "Mental Health", message: "Va rugam intoduceti textul inainte de a salva.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "On", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        delegate?.didAdd(title: self.title ?? "", text: textView.text)
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddToExpandableListViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
