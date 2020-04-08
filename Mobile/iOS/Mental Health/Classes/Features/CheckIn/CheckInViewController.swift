//
//  CheckinViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 07/04/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit

// MARK: - CheckInViewControllerDelegate

protocol CheckinViewControllerDelegate: class {
    func checkInResultsGood()
    func checkInResultsFurtherInvestigate()
    func checkInDismissed()
}

// MARK: - CheckinViewController

class CheckInViewController: UIViewController {

    // MARK: Variables
    
    @IBOutlet weak var checkInSlider: MHSlider!
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]!
    
    weak var delegate: CheckinViewControllerDelegate?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customize()
    }
    
    // MARK: Actions
    
    @IBAction func checkinAction(_ sender: Any) {
        if checkInSlider.value > 0.65 {
            delegate?.checkInResultsGood()
        } else {
            delegate?.checkInResultsFurtherInvestigate()
        }                
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        delegate?.checkInDismissed()
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - CheckinViewController

private extension CheckInViewController {
    
    func customize() {
        var scaleFactor: CGFloat = 1
        switch UIScreen.main.sizeType {
        case .iPhone5:
            scaleFactor = 0.6
        case .iPhone6:
            scaleFactor = 0.8
        default:
            return
        }
        
        for constraint in verticalConstraints {
            constraint.constant = round(constraint.constant * scaleFactor)
        }
        view.layoutIfNeeded()
    }
    
}
