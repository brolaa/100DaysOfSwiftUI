//
//  Order.swift
//  CupcakeCorner
//
//  Created by Bartosz Rola on 25/02/2023.
//

import Foundation

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case orderDetails
    }
    
    @Published var orderDetails = OrderDetails()
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(orderDetails, forKey: .orderDetails)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        orderDetails = try container.decode(OrderDetails.self, forKey: .orderDetails)
    }
}
