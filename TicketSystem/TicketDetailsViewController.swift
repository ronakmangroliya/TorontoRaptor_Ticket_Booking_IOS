//
//  TicketDetailsViewController.swift
//  TicketSystem
//
//  Created by Ravi Gelani on 2023-10-18.
//

import UIKit

class TicketDetailsViewController: UIViewController {

    
    @IBOutlet weak var tvQuantity: UILabel!
    @IBOutlet weak var tvPrice: UILabel!
    @IBOutlet weak var tvPurchaseDate: UILabel!
    @IBOutlet weak var tvTicketType: UILabel!
    
    var quantity = ""
    var ticketType = ""
    var purchaseDate = ""
    var  price = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvQuantity.text = quantity
        tvPrice.text = price
        tvPurchaseDate.text = purchaseDate
        tvTicketType.text = ticketType
    }
}
