//
//  MessageView.swift
//  WidgetDemo
//
//  Created by QianTuFD on 2017/6/26.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

struct MessageViewModel {
    var text: String
    var font: UIFont
    var textColor: UIColor
    var titleLabelLayout: Layoutable
}

class MessageView: UIView {
    
    let viewModel: MessageViewModel
    
    /// 顶部 label 表示已读还是未读
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        let viewModel: MessageViewModel = self.viewModel
        titleLabel.text = viewModel.text
        titleLabel.font = viewModel.font
        titleLabel.textColor = viewModel.textColor
        titleLabel.makeLayout(viewModel.titleLabelLayout)
        return titleLabel
    }()
    
    init(viewModel: MessageViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
