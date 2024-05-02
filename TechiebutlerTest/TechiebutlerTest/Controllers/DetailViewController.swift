//
//  DetailViewController.swift
//  TechiebutlerTest
//
//  Created by sandeep kaur on 02/05/24.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var lblId:UILabel!
    @IBOutlet weak var lblUserId:UILabel!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDetail:UILabel!
    @IBOutlet weak var stackViewBack:UIStackView!
    
    //MARK: Variable
    var data:DataModel?
    
    //MARK: Controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    override func viewDidLayoutSubviews() {
        self.stackViewBack.layer.cornerRadius = 10
    }
    
    //MARK: methods
    func setupData() {
        if let data = self.data {
            self.lblId.text = "\(data.id ?? 0)"
            self.lblUserId.text = "\(data.userId ?? 0)"
            self.lblTitle.text = "\(data.title ?? "")"
            self.lblDetail.text = "\(data.body ?? "")"
        }
    }
}
