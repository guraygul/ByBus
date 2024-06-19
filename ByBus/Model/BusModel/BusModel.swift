//
//  BusModel.swift
//  ByBus
//
//  Created by Güray Gül on 25.04.2024.
//

import Foundation

struct BusModel: Hashable {
    let busFirm: String
    let busFirmImage: String
    let busTime: String
    let busPrice: Int
    let estimatedTime: String
}

struct MockData {
    
    static let busses = [
        BusModel(busFirm: "Varan Turizm",
                 busFirmImage: "varanTurizmLogo",
                 busTime: "12:45",
                 busPrice: 500,
                 estimatedTime: "5s 25dk*"
                ),
        BusModel(busFirm: "Pamukkale Turizm",
                 busFirmImage: "pamukkaleTurizmLogo",
                 busTime: "15:15",
                 busPrice: 480,
                 estimatedTime: "6s 25dk*"
                ),
        BusModel(busFirm: "Kamil Koç",
                 busFirmImage: "kamilKocTurizmLogo",
                 busTime: "18:25",
                 busPrice: 450,
                 estimatedTime: "5s 45dk*"
                ),
        BusModel(busFirm: "Metro Turizm",
                 busFirmImage: "metroTurizmLogo",
                 busTime: "22:40",
                 busPrice: 420,
                 estimatedTime: "7s 45dk*"
                )
    ]
}
