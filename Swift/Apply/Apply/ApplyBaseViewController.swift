//
//  ApplyBaseViewController.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit




class ApplyBaseViewController: UIViewController {
    
    var headViewStyle: ApplyHeadViewStyle = .none(topImage: "") {
        didSet {
            tableView.tableHeaderView = ApplyHeadViewFactory.applyHeadView(tableView: tableView, style: headViewStyle)
        }
    }
    
    var cellItems: [ApplyTableViewCellType] = [ApplyTableViewCellType]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // 内容数组
    var cellContentDict: [IndexPath: String] = [IndexPath: String]()
    
    
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = COLOR_efefef
        ApplyTableViewCellFactory.registerApplyTableViewCell(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) { 
            self.navigationController?.navigationBar.subviews.first?.alpha = 0.0
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.subviews.first?.alpha = 1.0
        }
    }
    

    func setupUI() {
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["tableView": tableView]))
    }
}

extension ApplyBaseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch cellItems[indexPath.row] {
        case .common:
            return 50
        case let .image(.images(images: images)):
            return calculateCellHeight(title: nil, images: images)
        case let .image(.titleImages(title: title, images: images)):
            return calculateCellHeight(title: title, images: images)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else {
            return 0.1
        }
        switch headViewStyle {
        case .custom:
            return 5
        default:
            return 0.1
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}


extension UIAppearanceContainer {
    fileprivate func calculateCellHeight(title: String?, images: [String]) -> CGFloat {
        var height: CGFloat = 0.0
        let width = UIScreen.main.bounds.width - 50.f
        for image in images {
            let img = UIImage(named: image)
            if let size = img?.size {
                let h = size.height / size.width * width
                height += h
            }else {
                print("image size 有问题,或没有image")
            }
        }
        let oneImageHeightWithMargin = images.count.f * 22.f + height
        
        guard let tit = title else {
            return oneImageHeightWithMargin + 3
        }
        
        let t = tit as NSString
        let contentSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let h = t.textSizeWith(contentSize: contentSize, font: FONT_28PX).height
        let result = h + 11 + 13 - 22 + oneImageHeightWithMargin
        return result
    }
}


// MARK: - UITableViewDataSource
extension ApplyBaseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ApplyTableViewCellFactory.dequeueReusableCell(withTableView: tableView, type: cellItems[indexPath.row])!
        cell.currentIndexPath = indexPath
        cell.delegate = self
        cell.textFieldText = cellContentDict[indexPath]
        return cell
    }
}


// MARK: - ApplyHeadViewDelegate
extension ApplyBaseViewController: ApplyHeadViewDelegate {
    func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        print(index)
    }
}


// MARK: - ApplyTableViewCellDelegate
extension ApplyBaseViewController: ApplyTableViewCellDelegate {

    func commonCell(_ commonCell: CommonTableViewCell, textFieldDidEndEditing textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        cellContentDict[indexPath] = textField.text
        print("textFieldDidEndEditing\(textField)")
    }
    
    func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        print("第  \(indexPath) 的 arrowCellClick \(textField)")
    }
    
    func commonCell(_ commonCell: CommonTableViewCell, verificationButtonClick verificationButton: UIButton) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        print("第 \(indexPath) 的 verificationButtonClick\(verificationButton)")
    }
}


// MARK: - UIScrollViewDelegate
extension ApplyBaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let minOffsetY: CGFloat = 0.0
        let maxOffsetY: CGFloat = 100.0
        if offsetY > maxOffsetY {
            return
        }
        let navBagImageView = navigationController?.navigationBar.subviews.first
        navBagImageView?.alpha = (offsetY - minOffsetY) / (maxOffsetY - minOffsetY)
    }
}
