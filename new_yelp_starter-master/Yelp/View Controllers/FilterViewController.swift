//
//  FilterViewController.swift
//  Yelp
//
//  Created by FunTap on 6/19/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func filterViewController(filterViewController: FilterViewController, didUpdateFilter filters: [String], Deal: Bool, Distance: String, sort: YelpSortMode)
}

class FilterViewController: UIViewController, FilterCellDelegate, FilterDealCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var swichStates = [Int:Bool]()
    var delegate: FilterViewControllerDelegate?
    var Distance = ["Auto"]
    var sort = ["Best Match"]
    var test = false
    var testSee = false
    var cell: FilterDistanceCell! = nil
    var deal = false
    var filterDistance = "Auto"
    var see = "See All"
    let categoriesSee: [[String: String]] =
        [["name" : "Afghan", "code": "afghani"],
         ["name" : "African", "code": "african"]]
    var categories = [[String:String]]()
    var filterSort = YelpSortMode(rawValue: 0)
    let businessView = BusinessesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = categoriesSee
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let navigationBar = navigationController?.navigationBar
        navigationBar?.backgroundColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func SearchAction(_ sender: Any) {
        var filters = [String]()
        for(row,isSelected) in swichStates {
            if isSelected {
                filters.append(categories[row]["code"]!)
            }
        }
        if filterSort == YelpSortMode(rawValue: 1) && filterDistance == "Auto" {
            let button2Alert: UIAlertView = UIAlertView(title: "Error", message: "Please Choose Distance Value",delegate: self as? UIAlertViewDelegate, cancelButtonTitle: "OK")
            button2Alert.show()
        } else {
            delegate?.filterViewController(filterViewController: self, didUpdateFilter: filters, Deal: deal, Distance: filterDistance, sort: filterSort!)
            
            dismiss(animated: true, completion: nil)
        }
    }

}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return Distance.count
        case 2:
            return sort.count
        case 3:
            return categories.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IDFilterDealCell") as! FilterDealCell
            cell.lbDeal.text = "Offering a Deal"
            cell.delegate = self
            cell.DealSwitch.isOn = deal
            return cell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "IDFilterDistanceCell") as! FilterDistanceCell
            if Distance.count != 1 {
                cell.imgDistance.image = UIImage(named: "")
            } else {
                cell.imgDistance.image = UIImage(named: "down.png")
            }
            cell.lbDistance.text = Distance[indexPath.row]
            return cell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "IDFilterDistanceCell") as! FilterDistanceCell
            if sort.count != 1 {
                cell.imgDistance.image = UIImage(named: "")
            } else {
                cell.imgDistance.image = UIImage(named: "down.png")
            }
            cell.lbDistance.text = sort[indexPath.row]
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IDSetFilterCell") as! SetFilterCell
            cell.lbSee.text = see
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IDFilterCell") as! FilterCell
            cell.FilterLable.text = categories[indexPath.row]["name"]
            cell.delegate = self
            cell.filerSwitch.isOn = swichStates[indexPath.row] ?? false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            if indexPath.row == 0 {
                if test == false {
                    Distance = ["Auto", "0.01 mi", "0.02 mi", "0.03 mi", "0.05 mi"]
                    tableView.reloadData()
                    cell.imgDistance.image = UIImage(named: "")
                    test = true
                } else if test == true {
                    Distance = [Distance[indexPath.row]]
                    tableView.reloadData()
                    test = false
                }
            } else {
                filterDistance = Distance[indexPath.row]
                cell.lbDistance.text = filterDistance
                Distance = [Distance[indexPath.row]]
                tableView.reloadData()
                test = false
            }
        case 2:
            if indexPath.row == 0 {
                if test == false {
                    sort = ["Best Matched", "Distance", "Hightest Rated"]
                    tableView.reloadData()
                    cell.imgDistance.image = UIImage(named: "")
                    test = true
                } else if test == true {
                    sort = [sort[indexPath.row]]
                    tableView.reloadData()
                    test = false
                }
            } else {
                filterSort = YelpSortMode(rawValue: indexPath.row)
                cell.lbDistance.text = sort[indexPath.row]
                sort = [sort[indexPath.row]]
                tableView.reloadData()
                test = false
            }
        case 4:
            if testSee == false {
                categories = categoriesAll
                see = "Collapse"
                tableView.reloadData()
                testSee = true
            } else if testSee == true {
                categories = categoriesSee
                see = "See All"
                tableView.reloadData()
                testSee = false
            }
        default : break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Distance"
        case 2:
            return "Sort By"
        case 3:
            return "Categories"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 4:
            return 0
        default:
            return 50
        }
    }
    
    func filterCell(filterCell: FilterCell, didChangeValue value: Bool) {
        let indexpath = tableView.indexPath(for: filterCell)
        swichStates[(indexpath?.row)!] = value
        print("%i", indexpath!)
    }
    
    func filterDealCell(filterDealCell: FilterDealCell, didChangeValue value: Bool) {
        deal = value
        print(deal)
    }
}
