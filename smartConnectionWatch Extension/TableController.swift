 //
//  TableController.swift
//  smartConnection
//
//  Created by Shailin Biharie on 17-01-16.
//  Copyright © 2016 Shailin Biharie. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class TableController: WKInterfaceController, WCSessionDelegate{
    
    var session: WCSession!
    @IBOutlet var humRow: WKInterfaceLabel!
    @IBOutlet var tempRow: WKInterfaceLabel!
    @IBOutlet var motRow: WKInterfaceLabel!
    @IBOutlet var timeRow: WKInterfaceLabel!
    
    func updateLabel(){
        
//        let sharedDefault = NSUserDefaults(suiteName: "group.smartConnection")
//        
//        let sharedRow = sharedDefault?.stringForKey("shared")
//        print(sharedRow)
//        textRow.setText(String(sharedRow))
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        updateLabel()
        if(WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
        super.willActivate()
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]){
        let hum : AnyObject = applicationContext["hum"]! as AnyObject
        let temp : AnyObject = applicationContext["temp"]! as AnyObject
        let mot : AnyObject = applicationContext["mot"]! as AnyObject
        let time : AnyObject = applicationContext["time"]! as AnyObject
        humRow.setText("Humidity = " + (hum as! String))
        tempRow.setText("Temparature = " + (temp as! String))
        motRow.setText("Motion = " + (mot as! String))
        timeRow.setText("Time = " + (time as! String))
    }
    
//    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
//        self.textRow.setText(message["a"]! as? String)
//        print(message)
//    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
