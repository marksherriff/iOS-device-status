//
//  ViewController.swift
//  Device Status
//
//  Created by sherriff on 2/16/17.
//  Copyright © 2017 Mark Sherriff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var batteryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self,selector: #selector(self.batteryChanged),name: Notification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.batteryChanged),name: Notification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        self.batteryChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let device = UIDevice.current
        print("Device Info:")
        print("Name: \(device.name)")
        print("Model: \(device.model)")
        print("System Name: \(device.systemName)")
        print("System Version: \(device.systemVersion)")
        print("Identifier: \(device.identifierForVendor!)")

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
    func batteryChanged() {
        let device = UIDevice.current
        var batteryState: String
        switch(device.batteryState){
        case .charging:
            batteryState = "+"
        case .full:
            batteryState = "!"
        case .unplugged:
            batteryState  = "-"
        case .unknown:
            batteryState  = "?"
        }
        let batteryLevelPercent = device.batteryLevel * 100
        let batteryLevel = String(format: "%.0f%%", batteryLevelPercent)
        let batteryStatus = "\(batteryLevel) (\(batteryState))"
        batteryLabel.text = batteryStatus
    }


}

