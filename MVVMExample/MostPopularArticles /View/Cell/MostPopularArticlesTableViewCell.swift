//
//  MostPopularArticlesTableViewCell.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit

class MostPopularArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var article_img: UIImageView!
    @IBOutlet weak var article_title: UILabel!
    
    static var mostPopularArticlesTableViewCell="MostPopularArticlesTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellConfigration(article:DataListCellViewModel) {
        article_title.text=article.titleText
        ImageDownloader.downloadImage(imageView: article_img, url: article.img_link, placeHolder: "")
        

    }
    
}

struct DataListCellViewModel {
    let titleText: String
    let img_link: String
}
