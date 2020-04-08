//
//  JournalViewController.swift
//  Mental Health
//
//  Created by Florin Voicu on 4/1/20.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import Firebase
import IHProgressHUD

class JournalViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    struct Segues {
        static let journal = "embedJournal"
    }
    
    @IBOutlet weak var journalContainer: UIView!
    @IBOutlet weak var graphContainer: UIView!
    
    var journalController: ExpandableListViewController?
    lazy var journalItems = loadJson(name: "Journal")
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM"
        dateFormatter.locale = Locale(identifier: "ro")
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Jurnalul eroului"
        
        let titleParagraphText = NSMutableAttributedString(string: "Adaugă și azi o nouă poveste în jurnalul eroului. Cărei intămplare îi ești azi recunoscător?")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        titleParagraphText.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value: paragraphStyle,
                                range:NSMakeRange(0, titleParagraphText.length))
        titleLabel.attributedText = titleParagraphText
        
        IHProgressHUD.show()
        loadJournalItems { error in
            DispatchQueue.main.async {
                IHProgressHUD.dismiss()
                if let error = error {
                    IHProgressHUD.showError(withStatus: ((error as NSError).userInfo["message"] as! String))
                }
            }
        }
    }
    
    
    //MARK: - Private
    
    
    private func loadJson(name: String) -> [ExpandableListItem] {
        let path = Bundle.main.path(forResource: name, ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        let items = try! decoder.decode([ExpandableListItem].self, from: data)
        return items
    }
    
    
    private func loadJournalItems(completion: @escaping (_ error: Error?) ->() ) {

            guard let userId = InternalUser.id else {
                let customError = NSError(domain: "read.error", code: 0, userInfo: ["message" : "Actiunea nu a putut fi executata"])
                completion(customError)
                return
            }
            
            Session.shared.dataBase
                .collection("users")
                .document(userId)
                .collection("journals")
                .getDocuments { (snapshot, error) in
                    if let error = error {
                        completion(error)
                        return
                    } else {
                        guard let snapshot = snapshot else {
                            let customError = NSError(domain: "no.results", code: 0, userInfo: ["message" : "No results found"])
                            completion(customError)
                            return
                        }
                        
                        var rawItems = [Journal]()
                        for document in snapshot.documents {
                            do {
                                if let journal = try document.data(as: Journal.self) {
                                    rawItems.append(journal)
                                }
                            } catch {}
                        }
                        rawItems = rawItems.sorted(by: { $0.date > $1.date} )
                        self.journalItems = rawItems.map { rawItem in
                            let title = self.dateFormatter.string(from: rawItem.date)
                            let item = ExpandableListItem(title: title, text: rawItem.body)
                            return item
                        }
                        self.journalController?.items =  self.journalItems
                        completion(nil)
                    }
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ExpandableListViewController
        switch segue.identifier {
        case Segues.journal:
            journalController = destination
            destination?.config = .init(allowsAdding: true)
        default:
            break
        }
    }
    
}
