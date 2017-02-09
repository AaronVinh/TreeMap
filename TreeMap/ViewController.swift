//
//  ViewController.swift
//  TreeMap
//
//  Created by Aaron Vinh on 2/7/17.
//  Copyright © 2017 Aaron Vinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var treeMap = TreeMap()
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        var coords = treeMap.treemapCoords(data: [5,10,20,10,15,25,22],width: Double(screenSize.width),height: Double(screenSize.height),xOffset: 0,yOffset: 0)
        
        drawTreeMap(coordinates: coords)
        print("SOLUTION \(coords)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    func drawTreeMap(coordinates: [[Double]]){
        for coords in coordinates{
            let x1 = coords[0]
            let y1 = coords[1]
            let x2 = coords[2]
            let y2 = coords[3]
            
            let width = x2 - x1
            let height = y2 - y1
            
            let myView = UIView(frame: CGRect(x: x1, y: y1, width: width, height: height))
            myView.layer.borderWidth = 1
            myView.layer.borderColor = UIColor.black.cgColor
            self.view.addSubview(myView)
        }
    }
    
}

