//
//  TicketEngine.swift
//  TicketSystem
//
//  Created by Ravi Gelani on 2023-10-17.
//

import Foundation


class TicketEngine {
    
    var ticketTypeDataArray = [TicketsType]()
    var ticketHistoryArray = [TicketDetails]()
    
    
    func loadTicketData(){
        let ticketBalconyLevel = TicketsType()
        ticketBalconyLevel.ticketName = "Balcony Level Ticket"
        ticketBalconyLevel.ticketPrice = 5000
        ticketBalconyLevel.ticketQuantity = 20
        
        let ticketLowerLevel = TicketsType()
        ticketLowerLevel.ticketName = "Lower Level Ticket"
        ticketLowerLevel.ticketPrice = 3000
        ticketLowerLevel.ticketQuantity = 30
        
        let ticketCourtside = TicketsType()
        ticketCourtside.ticketName = "Courtside"
        ticketCourtside.ticketPrice = 2000
        ticketCourtside.ticketQuantity = 15
        
        ticketTypeDataArray.append(ticketBalconyLevel)
        ticketTypeDataArray.append(ticketLowerLevel)
        ticketTypeDataArray.append(ticketCourtside)
    }
    
    
    func priceCalculation(price:Int, quantity:Int = 0) -> Int {
        return price * quantity
    }
    
    func getCurrentTimeStamp() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestampString = dateFormatter.string(from: currentDate)
        return timestampString
    }
    
    
}
