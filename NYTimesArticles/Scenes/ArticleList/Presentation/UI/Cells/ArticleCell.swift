//
//  ArticleCell.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import UIKit
import AlamofireImage

class ArticleCell: UITableViewCell {
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func apply(model: ArticleCellDisplayItem) {
        
        self.titleLabel.text = model.title
        self.authorLabel.text = model.author
        self.dateLabel.text = model.publishDate
        if let thumbnail = model.thumbnail, let url = URL(string: thumbnail) {
            self.thumbnailImageView.af.setImage(withURL: url)
        }
    }
}
