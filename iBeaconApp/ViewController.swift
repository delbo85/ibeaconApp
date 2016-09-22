//
//  ViewController.swift
//  iBeaconApp
//
//  Created by Mikkel Delbo Larsen on 21/09/2016.
//  Copyright © 2016 Mikkel Delbo Larsen. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let locationManger = CLLocationManager()
    
    let uuid = NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString:"B9407F30-F5F8-466E-AFF9-25556B57FE6D") as! UUID, identifier: "Location100")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.image = UIImage(named: "sandwich")
        
        locationManger.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways){
            locationManger.requestAlwaysAuthorization()
        }
        locationManger.startRangingBeacons(in: region)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
       
        let knownBeacons = beacons.filter{$0.proximity != CLProximity.unknown}
        
        //if knownBeacons.count > 0 {
         //   updateDistance(beacons[0].proximity)
        //} else {
          //  updateDistance(.unknown)
       // }
        
        if (knownBeacons.count > 0 ){
            if (knownBeacons[0].major == 102){
                updateDistance(beacons[0].proximity)

            }
            //else if (knownBeacons[0].major == 100) {
              //  updateDistance1(beacons[0].proximity)
            //}
            
        }
        
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
            
            //Far: Greater than 10 meters away
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.imageView.image = UIImage(named: "sandwich")
                
            // Near: Within a couple of meters
            case .near:
                self.view.backgroundColor = UIColor.orange
                //self.notification()
                self.imageView.image = UIImage(named: "fritter")
                
            // Immediate: Within a few centimeters
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.imageView.image = UIImage(named: "burger")

            }
        }
    }
    
    func updateDistance1(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                
            //Far: Greater than 10 meters away
            case .far:
                self.view.backgroundColor = UIColor.black
                self.imageView.image = UIImage(named: "sandwich")
                
            // Near: Within a couple of meters
            case .near:
                self.view.backgroundColor = UIColor.clear
                //self.notification()
                self.imageView.image = UIImage(named: "fritter")
                
            // Immediate: Within a few centimeters
            case .immediate:
                self.view.backgroundColor = UIColor.brown
                self.imageView.image = UIImage(named: "burger")
                
            }
        }
    }

    
    func notification(){
        let content = UNMutableNotificationContent()
        content.title = "Offer for today"
        content.subtitle = "Slide to buy offer"
        content.body = "Blue Burger for 10 kr."
        content.badge = 1
        content.categoryIdentifier = "quizCategory"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let requestIdentifier = "offers"
        
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            // handle error
        })
    
        
    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        // some other way of handling notification
        completionHandler([.alert, .sound])
    }
    private func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        switch response.actionIdentifier {
        case "answerOne":
            imageView.image = UIImage(named: "burger")
            print("Burger")
        case "answerTwo":
            imageView.image = UIImage(named: "fritter")
        case "clue":
            let alert = UIAlertController(title: "Hint", message: "The answer is greater than 29", preferredStyle: .alert)
            let action = UIAlertAction(title: "Thanks!", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        default:
            break
        }
        completionHandler()
        
    }

    
}
extension ViewController: UNUserNotificationCenterDelegate {
   }
