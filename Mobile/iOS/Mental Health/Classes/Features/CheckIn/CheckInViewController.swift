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
    
    weak var delegate: CheckinViewControllerDelegate?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
