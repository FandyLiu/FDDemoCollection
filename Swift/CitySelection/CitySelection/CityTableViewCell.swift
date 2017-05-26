//
//  CityCollectionCell.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/22.
//  Copyright © 2017年 fandy. All rights reserved.
//  

import UIKit



class FDCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    init(_ colMargin: CGFloat, rowMargin: CGFloat, cols: Int, width: CGFloat, heigth: CGFloat) {
        super.init()
        minimumLineSpacing = rowMargin
        minimumInteritemSpacing = colMargin
        itemSize = CGSize(width: width, height: heigth)
        sectionInset = UIEdgeInsets(top: rowMargin, left: colMargin, bottom: rowMargin, right: colMargin)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CityTableViewCellDelegate: NSObjectProtocol {
    func cityTableViewCell(_ cityTableViewCell: CityTableViewCell, didSelectItemWith text: String)
}


class CityTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CityTableViewCellIdentifier"
    
    private static let colMargin: CGFloat = 15
    private static let rowMargin: CGFloat = 10
    private static let cols: Int = 3
    private static let width = (UIScreen.main.bounds.width - (colMargin * CGFloat(cols + 1))) / CGFloat(cols)
    private static let height = width * 0.3
    
    weak open var delegate: CityTableViewCellDelegate?
    
    var cityArray = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    /// 计算collectionCell 高度
    static func getCellHeight(_ cityArray: [String]) -> CGFloat {
        let count = cityArray.count
        let row = ceil(CGFloat(count) / CGFloat(cols))
        return (row + 1) * rowMargin + row * height
    }
    
    
    /// collectionView
    lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = FDCollectionViewFlowLayout(colMargin, rowMargin: rowMargin, cols: cols, width: width, heigth: height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: CityCollectionViewCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(collectionView)
        let bindings = ["collectionView": collectionView]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: bindings))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension CityTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.reuseIdentifier, for: indexPath) as! CityCollectionViewCell
        cell.text = cityArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cityTableViewCell(self, didSelectItemWith: cityArray[indexPath.item])
    }
}
