//
//  PersonalViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import IHProgressHUD

struct ExpandableListItem: Codable {
       let title: String
       let text: String
}

class PersonalViewController: UIViewController {
    
    struct Segues {
        static let advices = "embedAdvices"
        static let messages = "embedMessages"
    }
    
    @IBOutlet weak var advicesContainer: UIView!
    @IBOutlet weak var messagesContainer: UIView!
    
    var advicesListController: ExpandableListViewController?
    var messagesListController: ExpandableListViewController?
    
    var advices = [ExpandableListItem]()
    var messages = [ExpandableListItem]()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM"
        dateFormatter.locale = Locale(identifier: "ro")
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        title = "Pentru tine"
        
        IHProgressHUD.show()
        
        let loadComplete = { (error : Error?) in
            DispatchQueue.main.async {
                IHProgressHUD.dismiss()
                if let error = error {
                    IHProgressHUD.showError(withStatus: ((error as NSError).userInfo["message"] as! String))
                }
            }
        }
        
        var errors = [Error]()
        loadAdvices { error in
            error.flatMap { errors.append($0) }
            self.loadMessages { error in
                error.flatMap { errors.append($0) }
                loadComplete(errors.first)
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            advicesContainer.isHidden = false
        case 1:
            advicesContainer.isHidden = true
        default:
            break
        }
        messagesContainer.isHidden = !advicesContainer.isHidden
    }
    
    //MARK: - Private
    
    private func loadMessages(completion: @escaping (_ error: Error?) ->() ) {
        Session.shared.dataBase.collection("messages").getDocuments { (snapshot, error) in
            if let error = error {
                completion(error)
                return
            } else {
                guard let snapshot = snapshot else {
                    let customError = NSError(domain: "no.results", code: 0, userInfo: ["message" : "No results found"])
                    completion(customError)
                    return
                }
                
                self.messages = []
                for document in snapshot.documents {
                    do {
                       if let message = try document.data(as: Message.self) {
                        let item = ExpandableListItem(title: message.from,
                                                      text: message.body)
                        self.messages.append(item)
                       }
                   } catch {}
                }
                self.messagesListController?.items = self.messages
                completion(nil)
            }
        }
    }
    
    private func loadAdvices(completion: @escaping (_ error: Error?) ->() ) {
        Session.shared.dataBase.collection("daily-advices").getDocuments { (snapshot, error) in
            if let error = error {
                completion(error)
                return
            } else {
                guard let snapshot = snapshot else {
                    let customError = NSError(domain: "no.results", code: 0, userInfo: ["message" : "No results found"])
                    completion(customError)
                    return
                }
                
                self.advices = []
                for document in snapshot.documents {
                    do {
                       if let dailyAdvice = try document.data(as: DailyAdvice.self) {
                        
                        let title = self.dateFormatter.string(from: dailyAdvice.publishDate)
                        let item = ExpandableListItem(title: title.capitalizingFirstLetter(),
                                                      text: dailyAdvice.body)
                        self.advices.append(item)
                       }
                   } catch {}
                }
                self.advicesListController?.items = self.advices
                completion(nil)
            }
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ExpandableListViewController
        switch segue.identifier {
        case Segues.advices:
            advicesListController = destination
        case Segues.messages:
            messagesListController = destination
        default:
            break
        }
    }

}
