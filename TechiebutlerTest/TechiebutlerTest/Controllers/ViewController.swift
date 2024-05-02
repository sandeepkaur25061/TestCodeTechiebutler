//
//  ViewController.swift
//  TechiebutlerTest
//
//  Created by sandeep kaur on 02/05/24.
//

import UIKit


class ViewController: UIViewController {
    
    //MARK: Oultets
    @IBOutlet weak var tblView:UITableView!
    var refreshControl = UIRefreshControl()
    
    //MARK: Variables
    var data:[DataModel] = []
    var isPaginationInProgress:Bool = false
    var paginationComplete:Bool = false
    var page:Int = 1
    var limit:Int = 20

    //MARK: Controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRefreshControl()
        self.refreshData()
    }
    
    
    //MARK: Methods
    func setupRefreshControl() {
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            tblView.refreshControl = refreshControl
    }
        
    @objc func refreshData() {
        self.page = 1
        self.data  = []
        self.hitApi()
    }
    func getNewBatchOfData(index:Int) {
        if self.getDataCount() == index + 10 {
            self.hitApi()
        }
    }
    //API call to get data
    func hitApi() {
        if isPaginationInProgress {
            return
        }
        isPaginationInProgress = true
        NetworkManager.shared.getApiCall(page: self.page, limit: self.limit) {
            (data:[DataModel], status:Int) in
            self.isPaginationInProgress = false
            if data.count < self.limit {
                self.paginationComplete = true
            }
            self.page += 1
            self.data.append(contentsOf: data)
            DispatchQueue.main.async {
            self.tblView.reloadData()
            //self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()
            }
            
        }
    }
    
    func getDataCount() -> Int {
        return self.data.count
    }
    
    @inline(__always)
    func getData(at index: Int) -> DataModel? {
        let startTime = DispatchTime.now() // Get start time
        guard index >= 0 && index < self.data.count else {
            
            let endTime = DispatchTime.now() // Get end time
                    let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
                    let timeInterval = Double(nanoTime) / 1_000_000_000 // Convert nanoseconds to seconds
                    print("Time taken: \(timeInterval) seconds")
            
            return nil
        }
        let result = self.data[index]
        let endTime = DispatchTime.now() // Get end time
           let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
           let timeInterval = Double(nanoTime) / 1_000_000_000 // Convert nanoseconds to seconds
           print("Time taken: \(timeInterval) seconds")
        return result
    }
}
    //MARK: Confirm TableView data source & Data source
extension ViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.getNewBatchOfData(index: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        if let data = getData(at:  indexPath.row) {
            cell.configureCell(id: data.id ?? 0, title: data.title ?? "")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = getData(at:  indexPath.row) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                vc.data = data
                self.navigationController?.present(vc, animated: true)
            }
        }
    }
    
   
}

