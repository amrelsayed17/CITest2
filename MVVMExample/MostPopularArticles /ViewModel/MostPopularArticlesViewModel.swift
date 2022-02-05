//
//  MostPopularArticlesViewModel.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

protocol ArticleViewModelDelegete {
    func getError(error:String)
    func getData()
    func startLoading()
    func endLoading()

}
class MostPopularArticlesViewModel: NSObject {

    var cell_data:[DataListCellViewModel]=Array()
    
    var getError:((_ error:String)->())?
    var getData:(()->())?
    var startLoading:(()->())?
    var endLoading:(()->())?
    
    let url:URL=URL(string:Constants.articles_api)!
    func getArticlesData(url:URL)
    {
       // delegete.startLoading()
        self.startLoading?()
        APIServices.instance.getData(url:url, method: .get, params: nil, encoding: JSONEncoding.default, headers: nil) { (articleModel:ArticleModel?,errorModel:ArticleModel? , error) in
            
            self.endLoading?()
            //delegete.endLoading()
            if error != nil {
                self.getError?("Connection Error")
               // delegete.getError(error: "Connection Error")
            }
            else if errorModel != nil{
                self.getError?(errorModel.debugDescription )
              //  delegete.getError(error: errorModel.debugDescription)
            }
            else
            {
                self.setupCellViewModel(data: articleModel?.results ?? Array())
                self.getData?()
               // delegete.getData()
            }
        }
    }
    
    
    func setupCellViewModel(data:[Result])
    {
       cell_data=Array()
        for item in data
        {
            if (item.media?.count ?? 0) > 0
            {
                cell_data.append(DataListCellViewModel(titleText: item.title ?? "", img_link: item.media?[0].mediaMetadata?[0].url ?? ""))
            }
            else
            {
                cell_data.append(DataListCellViewModel(titleText: item.title ?? "", img_link:""))
            }
        }
    }
    
    func getCellModel(index:Int) -> DataListCellViewModel
    {
        return cell_data[index]
    }
    
    var z=0
    func getTotal(x:Int,y:Int)
    {
        z=x+y
    }
    
}
