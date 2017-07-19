//
//  ViewController.swift
//  baemin_fresh_tableview_practice
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers_dain. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage
import Alamofire


class ViewController: UIViewController {
    
    var jsonArray = Array<Dictionary<String,Any>>()
    var jsonArray2 = Array<Dictionary<String,Any>>()
    var jsonArray3 = Array<Dictionary<String,Any>>()
    var jsonArray4 = Array<Dictionary<String,Any>>()
    
    var jsonArraylist = [Array<Dictionary<String,Any>>(), Array<Dictionary<String,Any>>(), Array<Dictionary<String,Any>>(), Array<Dictionary<String,Any>>()]
    
    @IBOutlet weak var tableView: UITableView!
    
    let NC = NotificationCenter.default
    var infocount = 0
    let NM = NetworkModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        NC.addObserver(self, selector:#selector(gotinfo),name: Notification.Name(rawValue: "json"), object: nil)
        NM.getjson(url: "http://52.78.212.27:8080/woowa/main", index: 0)
        NM.getjson(url: "http://52.78.212.27:8080/woowa/side", index: 1)
        NM.getjson(url: "http://52.78.212.27:8080/woowa/course", index: 2)
        NM.getjson(url: "http://52.78.212.27:8080/woowa/soup", index: 3)
        
        
        
        
//        ///////main.json/////////////
//        let file = Bundle.main.url(forResource: "main", withExtension: "json")
//        do {
//            let data = try Data(contentsOf: file!)
//            let jsonWithArrayRoot = try JSONSerialization.jsonObject(with: data, options: [])
//            jsonArray = jsonWithArrayRoot as! [[String:Any]]
//            
//        }
//        catch {
//            print("///////////error////////////")
//        }
//        //////side.json///////////////
//        let file2 = Bundle.main.url(forResource: "side", withExtension: "json")
//        do {
//            let data2 = try Data(contentsOf: file2!)
//            let jsonWithArrayRoot2 = try JSONSerialization.jsonObject(with: data2, options: [])
//            jsonArray2 = jsonWithArrayRoot2 as! [[String:Any]]
//            
//        }
//        catch {
//        }
//        //////soup.json////////////////
//        let file3 = Bundle.main.url(forResource: "soup", withExtension: "json")
//        do {
//            let data3 = try Data(contentsOf: file3!)
//            let jsonWithArrayRoot3 = try JSONSerialization.jsonObject(with: data3, options: [])
//            jsonArray3 = jsonWithArrayRoot3 as! [[String:Any]]
//            
//        }
//        catch {
//        }
//        //////course.json//////////////
//        let file4 = Bundle.main.url(forResource: "course", withExtension: "json")
//        do {
//            let data4 = try Data(contentsOf: file4!)
//            let jsonWithArrayRoot4 = try JSONSerialization.jsonObject(with: data4, options: [])
//            jsonArray4 = jsonWithArrayRoot4 as! [[String:Any]]
//            
//        }
//        catch {
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func gotinfo(_ notification: Notification){
        let index = notification.userInfo?["index"] as! Int
        if let array = notification.userInfo?["json"]{
            jsonArraylist[index] = array as! [[String:Any]]
            print(infocount)
            //print(jsonArraylist[index])
            self.infocount += 1

            if infocount == 4{
                print("reloading...")
                self.tableView.reloadData()
            }
        }
    }
    
    
    
}
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return jsonArraylist.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArraylist[section].count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "main"
        case 1:
            return "side"
        case 2:
            return "soup"
        default:
            return "course"
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CustomTableViewCell
        var dic : Dictionary<String, Any>
        
        dic = jsonArraylist[indexPath.section][indexPath.row]
        
        
//        URLSession(configuration: URLSessionConfiguration.default).downloadTask(with: URL(string:"http://52.78.212.27:8080/woowa/main")!) {
//            (data, response, error) in
//            if let data = data, error == nil {
//                print("success")
//                print(data)
//            }
//            }.resume()

        
        
        cell.imageview.image = nil
        
//        let utilityQueue = DispatchQueue.global(qos: .utility)
//        let url = dic["image"] as? String
//        
//        Alamofire.download(url!)
//            .downloadProgress(queue: utilityQueue) { progress in
//                print("Download Progress: \(progress.fractionCompleted)")
//            }
//            .responseData { response in
//                print("Response is \(response)")
//                if let data = response.result.value {
//                    cell.imageview.image = UIImage(data: data)
//                }
//        }
        
        let url = dic["image"] as? String
        Alamofire.request(url!, method: .get).responseImage { response in
            cell.imageview.image = response.result.value
            //print(response.result.value)
        }
        
        
        
        cell.title.text = dic["title"] as? String
        cell.title.font = UIFont(name:"HelveticaNeue-Bold", size: 19)
        
        cell.descript.text = dic["description"] as? String
        cell.descript.textColor = UIColor.darkGray
        cell.descript.font = cell.descript.font.withSize(13)
        cell.n_price.text = dic["n_price"] as? String ?? nil
        cell.s_price.text = dic["s_price"] as? String ?? nil
        
        cell.s_price.font = cell.s_price.font.withSize(15)
        cell.n_price.font = cell.n_price.font.withSize(15)
        cell.n_price.textColor = UIColor.lightGray
        cell.n_price.frame.origin.x = 133
        cell.s_price.frame.origin.x = 185
        
        if cell.s_price.text == nil{
            cell.n_price.font = cell.n_price.font.withSize(23)
            cell.n_price.textColor = UIColor.orange
            cell.n_price.frame.origin.x = 133
        }
        else if cell .n_price.text == nil{
            cell.s_price.font = cell.s_price.font.withSize(23)
            cell.s_price.textColor = UIColor.orange
            cell.s_price.frame.origin.x = 133
        }
        else {
            cell.n_price.textColor = UIColor.lightGray
            cell.n_price.frame.origin.x = 133
            cell.s_price.frame.origin.x = 185
            cell.s_price.textColor = UIColor.orange
            cell.s_price.font = cell.s_price.font.withSize(23)
        }
        
        
        
        cell.badge1.text = ""
        cell.badge2.text = ""
        cell.badge3.text = ""
        if let badgelist = dic["badge"] as! [String]?{
            let count = badgelist.count
            if count > 0{
                cell.badge1.text = badgelist[0]
            }
            if count > 1{
                cell.badge2.text = badgelist[1]
            }
            if count > 2{
                cell.badge3.text = badgelist[2]
            }
        }
        for badge in [cell.badge1, cell.badge2, cell.badge3] {
            badge?.backgroundColor = UIColor.white
            badge?.font = badge?.font.withSize(13)
            badge?.textColor = UIColor.white
            if badge?.text == "론칭특가" || badge?.text == "이벤트특가"{
                badge?.backgroundColor = UIColor.purple
            }
            else if badge?.text == "사은품증정" {
                badge?.backgroundColor = UIColor.yellow
            }
        }
        return cell
    }
    
}


