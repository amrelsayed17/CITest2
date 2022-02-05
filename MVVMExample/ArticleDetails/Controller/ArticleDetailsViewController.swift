//
//  ArticleDetailsViewController.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit
import RxSwift

class ArticleDetailsViewController: UIViewController {

    
    @IBOutlet weak var article_img: UIImageView!
    @IBOutlet weak var article_desc: UITextView!
    
    var viewModel:DataListCellViewModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        ImageDownloader.downloadImage(imageView: self.article_img, url:viewModel?.img_link ?? "" , placeHolder: "")
    
    self.article_desc.text=viewModel?.titleText ?? ""

    }
    
}
