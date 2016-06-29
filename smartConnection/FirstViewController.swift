//
//  FirstViewController.swift
//  smartConnection
//
//  Created by Shailin Biharie on 16-12-15.
//  Copyright © 2015 Shailin Biharie. All rights reserved.
//

import UIKit
import Foundation
import WatchConnectivity

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WCSessionDelegate{
    
    var data = []
    var session: WCSession!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parseJSON("https://stud.hosted.hr.nl/0857185/Jaar%204/connection.php")
        if(WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
    }
    
    func parseJSON(whichData: String){
        let mySession = NSURLSession.sharedSession()
        let url: NSURL = NSURL(string: whichData)!
        let networkTask = mySession.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            do{
                let theJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                //print(theJSON)
                let results : NSDictionary = theJSON["data"] as! NSDictionary
    //let id = results["id"]
    let temp = results["temparature"]
    let hum = results["humidity"]
    let mot = results["motion"]
    let time = results["timestamp"]
    let data: [AnyObject] = ["LATEST UPDATE","humidity = " +  (temp! as! String),"temparature = " +  (hum! as! String),"motion = " +  (mot! as! String),"time = " +  (time! as! String)]
    
                //print(data)
                dispatch_async(dispatch_get_main_queue(), {
                self.data = data
                self.tableView!.reloadData()
                    
                        do {
                            try self.session?.updateApplicationContext(
                                ["temp" : temp!, "hum" : hum!, "mot" : mot!, "time" : time!])
                            //print(data)
                        } catch let error as NSError {
                            NSLog("Updating the context failed: " + error.localizedDescription)
                        }
                        
//                self.session.sendMessage(["a":"hello"], replyHandler: nil, errorHandler: nil)
//                    print(self.session.sendMessage)
                    
//                let sharedDefault = NSUserDefaults(suiteName: "group.smartConnection")
//                
//                sharedDefault?.setObject(data, forKey: "shared")
//                sharedDefault?.synchronize()
//                print(sharedDefault)
    })
        } catch let error as NSError {
            print(error)
        }
    })
    networkTask.resume()
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
{
    return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
    let allData = data[indexPath.row]
    print(allData)
    cell.textLabel!.text = allData as? String
    //cell.detailTextLabel!.text = allData["humidity"] as? String
    return cell
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
}


