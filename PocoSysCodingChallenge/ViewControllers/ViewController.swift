//
//  ViewController.swift
//  PocoSysCodingChallenge
//
//  Created by ♏︎ on 12/7/19.
//  Copyright © 2019 Henry Kivimaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   fileprivate let collectionView: UICollectionView = {
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      collectionView.backgroundColor = .clear
      collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MainCell")
      return collectionView
   }()
   
   //MARK:- Properties
   let loadIndicator = LoadingIndicator(frame: .zero)
   var objects: [ObjectJSON.Result] = []
   var images: [UIImage?] = []
   var meta: ObjectJSON?
   let url = URL(string: "https://tech-panel.herokuapp.com/code-challenge/mobile/catalog")!
   var fetchMore = true
   var indexPaths: [IndexPath] = []
   
   //MARK:- ViewLoad Methods
   override func viewDidLoad() {
      super.viewDidLoad()
      fetchData(from: url)
      constrainLoadIndicator()
      configureBackground()
      initialSetup()
      let loadingIndicator = UIActivityIndicatorView()
      loadingIndicator.startAnimating()
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
   }
   
   override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransition(to: size, with: coordinator)
      guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
         return
      }
      flowLayout.invalidateLayout()
   }
   
   //MARK:- Initial Setup Methods
   func initialSetup() {
      collectionView.delegate   = self
      collectionView.dataSource = self
      navigationItem.largeTitleDisplayMode = .automatic
      title = "Coding Challenge"
      view.addSubview(collectionView)
      collectionView.fillSuperView()
   }
   
   func configureBackground() {
      let backgroundImageView = UIImageView()
      view.addSubview(backgroundImageView)
      backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
      backgroundImageView.fillSuperView()
      backgroundImageView.contentMode = .scaleAspectFill
      backgroundImageView.image = #imageLiteral(resourceName: "LaunchScreen")
   }
   
   fileprivate func constrainLoadIndicator() {
      collectionView.addSubview(loadIndicator)
      NSLayoutConstraint.activate([
         loadIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
         loadIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
         loadIndicator.heightAnchor.constraint(equalToConstant: 100),
         loadIndicator.widthAnchor.constraint(equalToConstant: 100)
      ])
   }
   
   //MARK:- Networking Methods
   func fetchData(from url: URL) {
      let configuration = URLSessionConfiguration.default
      let session       = URLSession(configuration: configuration)
      loadIndicator.startAnimating()
      
      let task = session.dataTask(with: url) { (data, response, error) in
         guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200,
            let data = data else {
               return
         }
         do {
            let decoder  = JSONDecoder()
            let jsonData = try decoder.decode(ObjectJSON.self, from: data)
            self.meta    = ObjectJSON(result: jsonData.result, next: jsonData.next, previous: jsonData.previous, total: jsonData.total)
            self.indexPaths.removeAll()
            for object in jsonData.result {
               self.objects.append(object)
               self.indexPaths.append([0, self.objects.count - 1])
               if let imageURL = object.image {
                  let url = URL(string: imageURL)!
                  let imageData = try Data(contentsOf: url)
                  if let image = UIImage(data: imageData) {
                     self.images.append(image)
                  }
               }
            }
            let queue = OperationQueue.main
            queue.addOperation { [weak self] in
               self?.collectionView.insertItems(at: self?.indexPaths ?? [])
               self?.fetchMore.toggle()
               self?.loadIndicator.stopAnimating()
            }
         } catch {
            print("Error info: \(error)")
         }
      }
      task.resume()
   }
   
}

//MARK:- CollectionView Delegate & DataSource Methods
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.width / 1.7)
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      objects.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! CollectionViewCell
      if let image = images[indexPath.item] {
         cell.imageView.image = image
      }
      cell.titleLabel.text       = objects[indexPath.item].title
      cell.descriptionLabel.text = objects[indexPath.item].description
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      performSegue(withIdentifier: "detailVCSegue", sender: self)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let destVC = segue.destination as? DetailViewController {
         if let indexPath = collectionView.indexPathsForSelectedItems?.last {
            destVC.mainImage = images[indexPath.item]
            destVC.object    = objects[indexPath.item]
         }
      }
   }
   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let offsetY       = scrollView.contentOffset.y
      let contentHeight = scrollView.contentSize.height
      
      if offsetY > contentHeight - scrollView.frame.height * 4 && meta?.next != nil {
         if !fetchMore {
            self.fetchMore.toggle()
            guard let nextPage = meta?.next,
               let url = URL(string: nextPage) else { return }
            fetchData(from: url)
         }
      }
   }
   
   
}
