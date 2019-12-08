//
//  Object.swift
//  PocoSysChallenge
//
//  Created by ♏︎ on 12/7/19.
//  Copyright © 2019 Henry Kivimaa. All rights reserved.
//

import Foundation

struct ObjectJSON: Codable {
   struct Result: Codable {
      let item_id: String
      let image: String?
      let title: String
      let price: Price
      let description: String
   }
   
   struct Price: Codable {
      let value: Float
      let currency: String
   }
   
   let result: [Result]
   let next: String?
   let previous: String?
   let total: Int
}
