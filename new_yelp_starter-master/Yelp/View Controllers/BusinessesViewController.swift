//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var tableview: UITableView!

    var businesses: [Business]!
    var name = [String]()
    var searchBar = UISearchBar()
    var DataFilter = UserDefaults.standard
    let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableview
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableViewAutomaticDimension
        
        // search bar navigation
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        // set navigation
        let navigationBar = navigationController?.navigationBar
        navigationBar?.backgroundColor = UIColor.red

        Business.search(with: "") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses

                var i = 0
                for business in businesses {
                    self.name.insert(business.name!, at: i)
                    i += 1
                }
                self.tableview.reloadData()
                self.loadingView.stopAnimating()
            }
        }
        
        //
        waitting()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FilterViewController
        filtersViewController.delegate = self
    }
    
    func waitting()  {
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 130, width: 320, height: 100))
        loadingView.startAnimating()
        loadingView.center = tableFooterView.center
        tableFooterView.addSubview(loadingView)
        tableview.tableFooterView = tableFooterView
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filter = self.name.filter({ (text) -> Bool in
            let tmp : NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        waitting()
        Business.search(with: "") { (businesses: [Business]?, error: Error?) in
            if filter.count == 0 {
                 self.businesses = businesses
            } else {
                self.businesses.removeAll()
                var i = 0
                for business in businesses! {
                    for filtername in filter {
                        if business.name == filtername{
                            self.businesses.insert(business, at: i)
                            i+=1
                        }
                    }
                }
            }
            self.tableview.reloadData()
            self.loadingView.stopAnimating()
        }
    }
}
extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate, FilterViewControllerDelegate {
    func filterViewController(filterViewController: FilterViewController, didUpdateFilter filters: [String], Deal: Bool, Distance: String, sort: YelpSortMode) {
        waitting()
        Business.search(with: "", sort: sort, categories: filters, deals: Deal) { (businesses: [Business]!, error: Error!) in
            if Distance == "Auto" {
                self.businesses = businesses
            } else {
                self.businesses.removeAll()
                var i = 0
                for business in businesses! {
                    if business.distance == Distance {
                        self.businesses.insert(business, at: i)
                        i+=1
                    }
                }
            }
            self.tableview.reloadData()
            self.loadingView.stopAnimating()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses == nil {
            return 0
        } else {
            return businesses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "IDBusinessesCell") as! BusinessesCell
        cell.business = businesses[indexPath.row]
        return cell
    }

}
