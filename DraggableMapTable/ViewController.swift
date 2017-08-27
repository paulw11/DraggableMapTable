//
//  ViewController.swift
//  DraggableMapTable
//
//  Created by Paul Wilkinson on 27/8/17.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabtop: UIImageView!
    @IBOutlet weak var dividerCenter: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

extension ViewController {
    @IBAction func dividerDragger(recognizer: UIPanGestureRecognizer) {
        
        
        
        let translation = recognizer.translation(in: self.view)
        var newOffset = self.dividerCenter.constant + translation.y
        if newOffset > self.view.frame.size.height - self.tabtop.frame.size.height {
            newOffset = self.view.frame.size.height - self.tabtop.frame.size.height
        } else if newOffset < self.tabtop.frame.size.height  {
            newOffset = self.tabtop.frame.size.height
        }
        
        let velocity = recognizer.velocity(in: self.view)
        
        print("velocity=\(velocity.y)")
        
        if (velocity.y > 500) {
            newOffset = self.view.frame.size.height - 30
        } else if (velocity.y < -500) {
            newOffset = self.tabtop.frame.size.height
        }
        
        if self.mapView.isHidden {
            if newOffset > self.tabtop.frame.size.height {
                self.mapView.isHidden = false
            }
        } else {
            if newOffset == self.tabtop.frame.size.height {
                self.mapView.isHidden = true
            }
        }
        
        self.dividerCenter.constant = newOffset
        
        self.view.layoutIfNeeded()
        
        recognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
        
    }
}

