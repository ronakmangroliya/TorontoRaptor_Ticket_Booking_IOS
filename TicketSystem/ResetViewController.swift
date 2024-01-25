//
//  ResetViewController.swift
//  TicketSystem
//
//  Created by Ravi Gelani on 2023-10-18.
//

import UIKit

class ResetViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tvQuantity: UITextField!
    
    @IBOutlet weak var resetPickerView: UIPickerView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var ticketName = ""
    private var ticketPrice = 0
    private var ticketQuantity = 0
    
    @IBOutlet weak var tvTicketType: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetPickerView.delegate = self
        resetPickerView.dataSource = self
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        if(checkValidation()){
            
            for element in appDelegate.ticketEngine.ticketTypeDataArray{
                if(element.ticketName == ticketName){
                    let userAddedQuantity = Int(tvQuantity.text!)
                    element.ticketQuantity = element.ticketQuantity + userAddedQuantity!
                }
            }
            
            resetPickerView.reloadAllComponents()
            showAlert(title:"Success",message:"Ticket Data Updated")
            tvQuantity.text = "0"
            ticketName = ""
            ticketQuantity = 0
            ticketPrice = 0
        }
    }
    
    
    func checkValidation()->Bool{
        
        var isValid = true
        let userAddedQuantity = Int(tvQuantity.text!)
        
        if(ticketName.isEmpty){
            isValid = false
            showAlert(title:"Error",message:"Please Select type of Tickets")
        }
        else if(tvQuantity.text!.isEmpty){
            isValid = false
            showAlert(title:"Error",message:"Please enter valid input")
        }else if(userAddedQuantity! <= 0){
            isValid = false
            showAlert(title:"Error",message:"Please enter valid input")
        }
        return isValid
    }
    
    func showAlert(title : String , message : String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appDelegate.ticketEngine.ticketTypeDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let name = appDelegate.ticketEngine.ticketTypeDataArray[row].ticketName
        let price = appDelegate.ticketEngine.ticketTypeDataArray[row].ticketPrice
        let quanitity = appDelegate.ticketEngine.ticketTypeDataArray[row].ticketQuantity
        return  name + " (" + String(quanitity) + ")  $" + String(price)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ticketName = appDelegate.ticketEngine.ticketTypeDataArray[row].ticketName
        ticketPrice = appDelegate.ticketEngine.ticketTypeDataArray[row].ticketPrice
        ticketQuantity = appDelegate.ticketEngine.ticketTypeDataArray[row].ticketQuantity
        tvTicketType.text = ticketName
    }
}
