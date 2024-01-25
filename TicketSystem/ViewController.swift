//
//  ViewController.swift
//  TicketSystem
//
//  Created by Ravi Gelani on 2023-10-13.
//

import UIKit

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tvQuantity: UITextField!
    
    @IBOutlet weak var tvPrice: UITextField!
    
    @IBOutlet weak var tvTicketType: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var ticketName = ""
    private var ticketPrice = 0
    private var ticketQuantity = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.ticketEngine.loadTicketData()
        pickerView.delegate = self
        pickerView.dataSource = self
        tvQuantity.delegate = self
        tvPrice.isUserInteractionEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pickerView.reloadAllComponents()
    }
    
    @IBAction func btnQuantity(_ sender: Any) {
        let actionName = (sender as! UIButton).titleLabel?.text
        
        if(actionName == "Clear"){
            clearField()
        }else{
            if let quantity = Int(tvQuantity.text!), quantity == 0 {
                tvQuantity.text = actionName
            } else {
                tvQuantity.text = tvQuantity.text! + actionName!
            }
        }
    }
    
    @IBAction func btnBuyTicket(_ sender: Any) {
        if(checkValidation()){
            proceedWithByTicket()
        }
    }
    
    
    func showAlert(title : String , message : String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func proceedWithByTicket() {
        let userAddedQuantity = Int(tvQuantity.text!)
        let totalPrice = ticketPrice * userAddedQuantity!
        
        let ticketDetails = TicketDetails()
        ticketDetails.ticketType = ticketName
        ticketDetails.ticketBasePrice = ticketPrice
        ticketDetails.totalPrice = totalPrice
        ticketDetails.Quantity = userAddedQuantity!
        ticketDetails.ticketPurchaseDate = appDelegate.ticketEngine.getCurrentTimeStamp()
        appDelegate.ticketEngine.ticketHistoryArray.append(ticketDetails)
        
        for element in appDelegate.ticketEngine.ticketTypeDataArray{
            if(element.ticketName == ticketName){
                element.ticketQuantity = element.ticketQuantity - userAddedQuantity!
            }
        }
        pickerView.reloadAllComponents()
        clearField()
        showAlert(title:"Suceess",message:"Your ticket booked successfully")
    }
    
    func checkValidation()->Bool{
            
        var isValid = true
        if(tvQuantity.text!.isEmpty){
            isValid = false
            showAlert(title:"Error",message:"Please enter quantity")
        }else if(ticketName == ""){
            isValid = false
            showAlert(title:"Error",message:"Please select ticket type")
        } else if(ticketQuantity <= 0){
            isValid = false
            showAlert(title:"Error",message:"We don't have tickets for \(ticketName)")
        }else if (Int(tvQuantity.text!)! <= 0){
            isValid = false
            showAlert(title:"Error",message:"Please enter valid input")
        }else if (Int(tvQuantity.text!)! > ticketQuantity){
            isValid = false
            showAlert(title:"Error",message:"We don't have enough tickets \(ticketName)")
        }
        
        return isValid
    }
    
    func clearField() {
        tvQuantity.text = ""
        tvPrice.text = ""
        ticketName = ""
        ticketPrice = 0
        ticketQuantity = 0
        tvTicketType.text = ""
    }
}
    

extension ViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField)  {
        tvPrice.text = String(appDelegate.ticketEngine.priceCalculation(price : ticketPrice, quantity : Int(tvQuantity.text!) ?? 0))
    }
}
    
extension ViewController : UIPickerViewDelegate {
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
        
        let userEnterQuantity = Int(tvQuantity.text!)
        tvPrice.text = String(appDelegate.ticketEngine.priceCalculation(price : ticketPrice, quantity : userEnterQuantity ?? 0))
    }
}

extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return appDelegate.ticketEngine.ticketTypeDataArray.count
    }
}

