//
//  NetworkModel.swift
//  baemin_fresh_tableview_practice
//
//  Created by woowabrothers on 2017. 7. 19..
//  Copyright © 2017년 woowabrothers_dain. All rights reserved.
//

import Foundation
import Alamofire

class NetworkModel{
    var jsonArray = Array<Dictionary<String,Any>>()
    var postDic = Dictionary<AnyHashable, Any>()
    let NC = NotificationCenter.default
    
    func getjson(url: String, index: Int){
        Alamofire.request(url).responseJSON {responseObject in
            do {
                let data = responseObject.data
                let jsonWithArrayRoot = try JSONSerialization.jsonObject(with: data!, options: [])
                self.jsonArray = jsonWithArrayRoot as! [[String:Any]]
                self.postDic["json"] = self.jsonArray
                self.postDic["index"] = index
                self.NC.post(name: Notification.Name(rawValue: "json"), object: nil, userInfo: self.postDic)
            } catch {
                print("json error")
            }
        }
    }
}
