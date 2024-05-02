//
//  ListTableViewCell.swift
//  TechiebutlerTest
//
//  Created by sandeep kaur on 02/05/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static var identifier:String {
        return "ListTableViewCell"
    }
//MARK: Outlets
    @IBOutlet weak var lblId:UILabel!
    @IBOutlet weak var lblDetail:UILabel!
    
    //MARK: Cell Life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    // MARK: Methods
    func configureCell(id:Int, title:String) {
        self.lblId.text = "\(id)"
        self.lblDetail.text = title
    }
}
