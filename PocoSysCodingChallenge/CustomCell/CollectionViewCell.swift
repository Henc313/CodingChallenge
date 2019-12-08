//
//  CollectionViewCell.swift
//  PocoSysCodingChallenge
//
//  Created by ♏︎ on 12/7/19.
//  Copyright © 2019 Henry Kivimaa. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
   
   let imageView: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode        = .scaleAspectFill
      imageView.layer.cornerRadius = 12
      imageView.clipsToBounds      = true
      imageView.setGradient(firstColor: UIColor(white: 0, alpha: 0.0), secondColor: UIColor(white: 0, alpha: 0.9))
      return imageView
   }()
   
   let titleLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .white
      label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
      label.setGradient(firstColor: .black, secondColor: .black)
      return label
   }()
   
   let descriptionLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.numberOfLines = 2
      label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
      label.textColor = .white
      return label
   }()
   
   let gradientView: UIView = {
      let gradientView = UIView()
      gradientView.translatesAutoresizingMaskIntoConstraints = false
      gradientView.backgroundColor = UIColor(white: 0.0, alpha: 0.35)
      return gradientView
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      contentView.addSubview(imageView)
      contentView.addSubview(descriptionLabel)
      imageView.fillSuperView()
      imageView.addSubview(gradientView)
      gradientView.addSubview(titleLabel)
      gradientView.addSubview(descriptionLabel)
      
      constrainViews()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   func constrainViews() {
      gradientView.anchor(
         top: nil,
         leading: leadingAnchor,
         bottom: bottomAnchor,
         trailing: trailingAnchor,
         size: CGSize(width: 0, height: 80)
      )
      
      titleLabel.anchor(
         top: gradientView.topAnchor,
         leading: gradientView.leadingAnchor,
         bottom: nil,
         trailing: gradientView.trailingAnchor,
         padding: UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
      )
      
      descriptionLabel.anchor(
         top: titleLabel.bottomAnchor,
         leading: gradientView.leadingAnchor,
         bottom: gradientView.bottomAnchor,
         trailing: gradientView.trailingAnchor,
         padding: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
      )
   }
   
}
