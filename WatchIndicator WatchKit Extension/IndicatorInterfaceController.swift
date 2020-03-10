//
//  IndicatorInterfaceController.swift
//  WatchIndicator WatchKit Extension
//
//  Created by Mangs Subra on 10/03/20.
//  Copyright © 2020 Mangs Subra. All rights reserved.
//

import WatchKit
import Foundation


class IndicatorInterfaceController: WKInterfaceController {

    @IBOutlet weak var image: WKInterfaceImage!
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let type = context as? indicatorType{
            label.setText(type.description)
            image.setImageNamed(type.debugDescription)
            image.startAnimatingWithImages(in: type.range, duration: 1.0, repeatCount: 0)
        }
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        image.stopAnimating()
    }

}
