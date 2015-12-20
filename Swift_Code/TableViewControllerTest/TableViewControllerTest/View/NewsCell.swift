//
//  NewsCell.swift
//  TableViewControllerTest
//
//  Created by NCS on 10/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var digestLabel: UILabel!
    @IBOutlet weak var ptimeLabel: UILabel!
    
    
    var newsModel : NewsModel {
        set{
            self.titleLabel.text = newValue.title
            self.digestLabel.text = newValue.digest
            self.ptimeLabel.text = newValue.ptime
            
        }
        get{
            return self.newsModel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.frame = self.bounds
        print(self.bounds)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
    }

    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
    }
    
}
