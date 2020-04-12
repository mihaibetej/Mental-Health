//
//  FeedViewController.swift
//  Mental Health
//
//  Created by Mihai Betej on 27/03/2020.
//  Copyright © 2020 Mihai Betej. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift

struct NewsItem: Decodable {
    var body: String?
    var image: String?
    var title: String?
}

class FeedViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let detailSegueName = "showFeedDetail"
    var selectedDetails: NewsItem?
    var newsItems = [NewsItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let refreshControl = UIRefreshControl()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueName,
            let destination = segue.destination as? FeedDetailViewController {
            // pass the data in selectedDetails then erase the information in it
            destination.feedDetail = selectedDetails
            selectedDetails = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            self.tableView.insertSubview(refreshControl, at: 0)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = UIColor(named: "MHDarkBlue")
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(named: "MHDarkBlue") ?? .clear]
        refreshControl.attributedTitle = NSAttributedString(string: "Actualizare", attributes: attributes)
        
        loadData()
    }
    
    @objc func refreshData() {
        loadData()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedTableViewCell else {
            return FeedTableViewCell()
        }
        
        let item = newsItems[indexPath.row]
        cell.configure(title: item.title ?? "", imageURL: URL(string: item.image ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDetails = newsItems[indexPath.row]
        performSegue(withIdentifier: detailSegueName, sender: self)
    }
}

// MARK: - (Private API)

private extension FeedViewController {
    
    func loadData() {
        Session.shared.dataBase
            .collection("news")
            .order(by: "date")
            .getDocuments { (snapshot, error) in
            defer {
                self.refreshControl.endRefreshing()
            }

            if let error = error {
                print("failed to fetch news: \(error)")
            } else {
                guard let snapshot = snapshot else {
                    print("failed to fetch news, no snapshot returned")
                    return
                }

                var items = [NewsItem]()
                // 'document' is a dictionary
                for document in snapshot.documents {
                    print("news item \(document.documentID): \(document.data())")
                    // NewsItem is Decodable
                    do {
                        if let newsItem = try document.data(as: NewsItem.self) {
                            items.append(newsItem)
                        }
                    } catch {
                        print("failed to parse newsItem with error: \(error)")
                    }
                }

                self.newsItems = items.reversed()
            }
        }
    }
    
}
