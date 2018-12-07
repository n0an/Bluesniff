//
//  ViewController.swift
//  BlueTracker
//
//  Created by nag on 25/08/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var centralManager : CBCentralManager?
    var names : [String] = []
    var RSSIs :[NSNumber] = []
    var timer : Timer?
    var uuids: [String] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }

    @IBAction func actionRefreshTapped(_ sender: Any) {
        startScan()
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            self.startScan()
        })
    }
    
    func startScan() {
        names = []
        RSSIs = []
        uuids = []
        tableView.reloadData()
        centralManager?.stopScan()
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "blueCell", for: indexPath) as? BlueTableViewCell {
            cell.peripheralNameLabel.text = names[indexPath.row]
            cell.uuidLabel.text = uuids[indexPath.row]
            cell.rssiLabel.text = "RSSI: \(RSSIs[indexPath.row])"
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    
}

// MARK: - CBCentralManagerDelegate
extension ViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == .poweredOn {
            // Working
            startScan()
            startTimer()
        } else {
            // Not Working
            let alertVC = UIAlertController(title: "Bluetooth isn't working", message: "Make sure your bluetooth is on and ready to rock and roll!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                alertVC.dismiss(animated: true, completion: nil)
            })
            alertVC.addAction(okAction)
            present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        guard !uuids.contains(peripheral.identifier.uuidString)  else {
            return
        }
        
        if let name = peripheral.name {
            names.append(name)
            print("name = \(name)")
            print("uuid = \(peripheral.identifier.uuidString)")
        } else {
            names.append(peripheral.identifier.uuidString)
            print("uuid = \(peripheral.identifier.uuidString)")
        }
        uuids.append(peripheral.identifier.uuidString)
        RSSIs.append(RSSI)
        
        
        print("******************")
        tableView.reloadData()
    }
    
    
    
    
}












