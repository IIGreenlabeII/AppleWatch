//
//  InterfaceController.swift
//  smartConnectionWatch Extension
//
//  Created by Shailin Biharie on 16-12-15.
//  Copyright © 2015 Shailin Biharie. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var watchTimer: WKInterfaceTimer!
    
    var doneTimer: NSTimer?
    var duration: NSTimeInterval = 60.0 * 1.0 // aantal seconden(1 min)
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func startButtomPressed() {
        
        print("Start")
        watchTimer.setDate(NSDate(timeIntervalSinceNow: duration))
        watchTimer.start()
        
        doneTimer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("time:"), userInfo: nil, repeats: false)
    }
    
    func time(timer: NSTimer){
        print("Done")
        watchTimer.stop()
        
    }
}
