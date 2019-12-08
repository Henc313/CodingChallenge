//
//  DetailViewController.swift
//  PocoSysCodingChallenge
//
//  Created by ♏︎ on 12/8/19.
//  Copyright © 2019 Henry Kivimaa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
   //MARK:- Global Properties
   var object:      ObjectJSON.Result?
   var mainImage:   UIImage?
   var imageView:   UIImageView!
   var textView:    UITextView!
   var priceLabel:  UILabel!
   var bgImageView: UIImageView!
   
   
   //MARK:- IBOutlets
   @IBOutlet weak var scrollView: UIScrollView!
   @IBOutlet weak var contentView: UIView!
   
   
   //MARK:- ViewLoad Methods
   override func viewDidLoad() {
      super.viewDidLoad()
      
      imageView   = UIImageView()
      textView    = UITextView()
      priceLabel  = UILabel()
      bgImageView = UIImageView()
      
      addSubViews()
      constrainSubViews()
      configureSubViews()
   }
   
   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      scrollView.insetsLayoutMarginsFromSafeArea = false
      scrollView.automaticallyAdjustsScrollIndicatorInsets = false
   }
   
   //MARK:- Mehtods
   func addSubViews() {
      contentView.addSubview(imageView)
      contentView.addSubview(textView)
      contentView.addSubview(priceLabel)
      view.insertSubview(bgImageView, at: 0)
   }
   
   func constrainSubViews() {
      bgImageView.anchor(
         top:      view.topAnchor,
         leading:  view.leadingAnchor,
         bottom:   view.bottomAnchor,
         trailing: view.trailingAnchor
      )
      
      imageView.anchor(
         top:      contentView.safeAreaLayoutGuide.topAnchor,
         leading:  contentView.leadingAnchor,
         bottom:   nil,
         trailing: contentView.trailingAnchor,
         padding:  UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0),
         size:     CGSize(width: 0, height: mainImage?.size.height ?? 0)
      )
      
      textView.anchor(
         top:      imageView.bottomAnchor,
         leading:  view.safeAreaLayoutGuide.leadingAnchor,
         bottom:   nil,
         trailing: view.safeAreaLayoutGuide.trailingAnchor,
         padding:  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
         size:     CGSize(width: 0, height: 100)
      )
      
      priceLabel.anchor(
         top:      textView.bottomAnchor,
         leading:  nil,
         bottom:   contentView.bottomAnchor,
         trailing: textView.trailingAnchor,
         padding:  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
         size:     CGSize(width: 100, height: 40)
      )
   }
   
   func configureSubViews() {
      configurePriceLabel()
      configureTextView()
      configureBackgroundImage()
      configureMainImageView()
      scrollView.backgroundColor  = UIColor(white: 0.0, alpha: 0.6)
      contentView.backgroundColor = .clear
   }
   
   func configurePriceLabel() {
      priceLabel.textColor = .white
      if let price         = object?.price.value,
         let currency      = object?.price.currency {
         priceLabel.text   = "\(price) \(currency)"
      }
   }
   
   func configureTextView() {
      textView.backgroundColor = .clear
      textView.textColor       = .white
      textView.font            = UIFont(name: "HelveticaNeue", size: 16)
      textView.text            = object?.description
      textView.isUserInteractionEnabled = false
   }
   
   func configureBackgroundImage() {
      bgImageView.image       = UIImage(named: "LaunchScreen")
      bgImageView.contentMode = .scaleAspectFill
   }
   
   func configureMainImageView() {
      imageView.contentMode         = .scaleAspectFit
      imageView.image               = mainImage
      imageView.layer.shadowColor   = UIColor.black.cgColor
      imageView.layer.shadowRadius  = 20
      imageView.layer.shadowOffset  = CGSize(width: 3, height: 5)
      imageView.layer.shadowOpacity = 1.0
   }
}
