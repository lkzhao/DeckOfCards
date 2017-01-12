//
//  DeckViewController.swift
//  DeckOfCardsExamples
//
//  Created by YiLun Zhao on 2017-01-11.
//  Copyright © 2017 Luke Zhao. All rights reserved.
//

import UIKit

class DeckLayout:UICollectionViewLayout{
  var contentSize:CGSize = .zero
  override var collectionViewContentSize: CGSize{
    return contentSize
  }
  
  var attributes:[[UICollectionViewLayoutAttributes]] = []
  override func prepare() {
    guard let collectionView = collectionView else { return }
    
    let size = collectionView.bounds.size
    
    attributes.removeAll()
    
    var y:CGFloat = 24
    for i in 0..<collectionView.numberOfSections{
      var sectionAttributes:[UICollectionViewLayoutAttributes] = []
      for j in 0..<collectionView.numberOfItems(inSection: i){
        let indexPath = IndexPath(item: j, section: i)
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attribute.frame = CGRect(x: 0, y: y, width: size.width, height: size.height)
        var t = CATransform3DIdentity
        t.m34 = -1 / 500
        t = CATransform3DTranslate(t, 0, -size.height/2, 0)
        t = CATransform3DRotate(t, -0.5, 1, 0, 0)
        t = CATransform3DTranslate(t, 0, size.height/2, 0)
        attribute.transform3D = t
        sectionAttributes.append(attribute)
        
        y += 300
      }
      attributes.append(sectionAttributes)
    }
    
    contentSize = CGSize(width: size.width, height: y)
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return attributes[indexPath.section][indexPath.item]
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var rtn:[UICollectionViewLayoutAttributes] = []
    
    for section in attributes{
      for attribute in section{
        if rect.intersects(attribute.frame){
          rtn.append(attribute)
        }
      }
    }

    return rtn
  }
}
public class DeckViewController:UIViewController {
  public var collectionView:UICollectionView!

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
    super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    initialize()
    collectionView.register(CardCell.self, forCellWithReuseIdentifier: "item")
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  func initialize(){
    view.backgroundColor = .white
    let layout = DeckLayout()
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.dataSource = self
    view.addSubview(collectionView)
  }
}

public class CardCell:UICollectionViewCell{
  let overlayLayer = CAGradientLayer()
  let nameLabel = UILabel()
  let nameBackground = CALayer()
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  func initialize(){
    overlayLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
    layer.addSublayer(overlayLayer)
    
    nameBackground.backgroundColor = UIColor.white.withAlphaComponent(0.3).cgColor
    layer.addSublayer(nameBackground)
    
    nameLabel.text = "Deck of Cards"
    nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
    addSubview(nameLabel)
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    overlayLayer.frame = bounds
    nameBackground.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 24)
    nameLabel.sizeToFit()
    nameLabel.center = nameBackground.position
  }
}

extension DeckViewController:UICollectionViewDataSource{
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath)
    cell.backgroundColor = .white
    return cell
  }
}
