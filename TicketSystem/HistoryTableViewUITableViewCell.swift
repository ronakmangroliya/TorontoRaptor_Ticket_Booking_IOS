//
//  HistoryTableViewUITableViewCell.swift
//  TicketSystem
//
//  Created by Ravi Gelani on 2023-10-18.
//

import UIKit

class HistoryTableViewUITableViewCell: UITableViewCell {

    @IBOutlet weak var ticketNameLable: UILabel!
    
    @IBOutlet weak var ticketQuantityLable: UILabel!
    
    @IBOutlet weak var ticketPrice: UILabel!
    
    @IBOutlet weak var ticketPurchaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
