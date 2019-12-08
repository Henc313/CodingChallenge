//
//  LoadingIndicator.swift
//  PocoSysCodingChallenge
//
//  Created by ♏︎ on 12/8/19.
//  Copyright © 2019 Henry Kivimaa. All rights reserved.
//

import UIKit

class LoadingIndicator: UIActivityIndicatorView {

   override init(frame: CGRect) {
      super.init(frame: frame)
      self.translatesAutoresizingMaskIntoConstraints = false
      self.hidesWhenStopped = true
      self.style = .large
      self.color = .white
   }
   
   required init(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}
