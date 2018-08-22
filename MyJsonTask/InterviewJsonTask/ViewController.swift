//
//  ViewController.swift
//  InterviewJsonTask
//
//  Created by Nagarjuna on 8/22/18.
//  Copyright © 2018 Sangeeta. All rights reserved.
//

import UIKit
var tableArray = [String]()
class ViewController: UIViewController {
    var urlReq:URLRequest!
    var urlSession:URLSession!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func loadAction(_ sender: UIButton)
    {
        urlReq = URLRequest(url: URL(string: "https://itunes.apple.com/us/rss/topalbums/limit=10/json")!)
        
        urlReq.httpMethod = "GET"
        urlSession = URLSession.shared
        let task = urlSession.dataTask(with: urlReq){ (data,response,error) in
            do
            {
                var dict:[String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
               // print(dict)
                var feed:[String:Any] = dict["feed"] as! [String : Any]
               // print("feed entry \(feed["entry"]!)")
                
                var arr:[[String:Any]] = feed["entry"]! as! [[String : Any]]
                

                var title:[String:Any]
                
                for i in 0..<arr.count

                {
                   
                    title = arr[i]["title"]! as! [String : Any]
                    //print(title)
                    let name = title["label"]
                  //  print(name!)
                    tableArray.append(name as! String)
                    
                    
                    let dictAsString = (title.compactMap({ (key, value) -> String in /* Converting the Dictionary to             String Code*/
                        return "\(key) \(value)"
                    }) as Array).joined(separator: ";")
                    
                    print(dictAsString)
                    
                  }
                
                DispatchQueue.main.async
                    {
                        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TableID") as! FetchTableVC
                        self.present(nextVC, animated: true, completion: nil)
                    
                }
                
                
                
            
                
                
                
                
                
                
            }catch{
                print(error)
            }
            
        }
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

