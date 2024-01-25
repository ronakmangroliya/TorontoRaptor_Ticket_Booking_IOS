//
//  HistoryViewController.swift
//  TicketSystem
//
//  Created by Ravi Gelani on 2023-10-18.
//

import UIKit


class HistoryViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var historyTableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HistoryTableViewUITableViewCell", bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: "HistoryTableViewCell")
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appDelegate.ticketEngine.ticketHistoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewUITableViewCell
        
        let item = appDelegate.ticketEngine.ticketHistoryArray[indexPath.row]
                   let name = item.ticketType
                   let price = item.totalPrice
                   let quanitity = item.Quantity
                   let date = item.ticketPurchaseDate
        cell.ticketNameLable.text = name
        cell.ticketQuantityLable.text = "Quantity: \(quanitity)"
        cell.ticketPrice.text = "Total Price $: \(price)"
        cell.ticketPurchaseDate.text = "Purchased On :  \(date)"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ViewToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! TicketDetailsViewController
        let selectedRow = historyTableView.indexPathForSelectedRow!.row
        
        let item = appDelegate.ticketEngine.ticketHistoryArray[selectedRow]
                   let name = item.ticketType
                   let price = item.totalPrice
                   let quanitity = item.Quantity
                   let date = item.ticketPurchaseDate
        
        detailsVC.ticketType = name
        detailsVC.price = "Total Price $: \(price)"
        detailsVC.quantity = "Quantity: \(quanitity)"
        detailsVC.purchaseDate = "Purchase Date: \(date)"
    }
}
