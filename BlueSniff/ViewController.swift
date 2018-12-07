//
//  ViewController.swift
//  BlueSniff
//
//  Created by Nick Walter on 8/6/15.
//  Copyright © 2015 Nick Walter. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var centralManager : CBCentralManager?
    var peripherals = [CBPeripheral]()
    var RSSIs = [NSNumber]()
    var timer : NSTimer?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peripherals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("blueCell") as! BlueToothTableViewCell
        let peripheral = self.peripherals[indexPath.row]
        let RSSI = self.RSSIs[indexPath.row]
        if peripheral.name == nil {
            cell.nameLabel.text = peripheral.identifier.UUIDString
        } else {
            cell.nameLabel.text = peripheral.name
        }
        cell.rssiLabel.text = "RSSI: \(RSSI)"
        return cell
    }
    
    
    @IBAction func refreshTapped(sender: AnyObject) {
        self.peripherals = []
        self.RSSIs = []
        self.tableView.reloadData()
        startScan()
    }
    
    func startScan() {
        self.timer?.invalidate()
        self.centralManager?.scanForPeripheralsWithServices(nil, options: nil)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "stopScan", userInfo: nil, repeats: false)
    }
    
    func stopScan() {
        self.centralManager?.stopScan()
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
//        print("*******************")
//        print("Name: \(peripheral.name)")
//        print("UUID: \(peripheral.identifier.UUIDString)")
//        print("Ad Data: \(advertisementData)")
//        print("RSSI: \(RSSI)")
//        print("*******************")
        self.peripherals.append(peripheral)
        self.RSSIs.append(RSSI)
        self.tableView.reloadData()
    }
    
    
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOn {
            startScan()
        } else {
            let alertVC = UIAlertController(title: "Bluetooth Not Working", message: "Make sure that your bluetooth is on and ready to rock and roll baby!", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            alertVC.addAction(action)
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
}

