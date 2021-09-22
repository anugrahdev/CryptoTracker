//
//  CryptoTableViewCell.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 21/09/21.
//

import UIKit
import SkeletonView

class CryptoTableViewCell: BaseTableViewCell {
    
    private let nameLabel: UILabel = {
       var label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .systemGreen
        label.text = "DogeCoin"
        label.isSkeletonable = true
        return label
    }()
    
    private let symbolLabel : UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "Symbol"
        label.isSkeletonable = true
        return label
    }()
    
    private let priceLabel : UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemGreen
        label.text = "5.0"
        label.isSkeletonable = true
        return label
    }()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        return formatter
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        contentView.isSkeletonable = true
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(symbolLabel)
        self.contentView.addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: CryptoModel)  {
        let price = self.numberFormatter.string(from: NSNumber(floatLiteral: model.priceUsd ?? 0))

        self.nameLabel.text = model.name ?? ""
        self.symbolLabel.text = model.assetID ?? ""
        self.priceLabel.text = price
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 5, y: 0, width: width() / 2, height: height() / 2)
        
        symbolLabel.frame = CGRect(x: 5, y: height() / 2, width: width()/2, height: height()/2)
        
        priceLabel.frame = CGRect(x: width()/2, y: 0, width: width()/2 - 5, height: height())
        
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CryptoTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        // view controller using programmatic UI
        CryptoTableViewCell().showPreview()
            .previewLayout(.sizeThatFits)
            .frame(width: 500, height: 200, alignment: .center)
    }
}
#endif
