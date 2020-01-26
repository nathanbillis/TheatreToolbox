//
//  RTAViewController.swift
//  Theatre Toolbox
//
//  Created by Nathan Billis on 25/01/2020.
//  Copyright © 2020 Nathan Billis. All rights reserved.
//

import Foundation
import UIKit
import AudioKitUI
import AudioKit



class RTAViewController: UIViewController {
    
    
	
    @IBAction func backButtonPressed(_ sender: UIButton) {
        do {
            // Stop all I/O and disconnect and shutdown AudioKit
            AudioKit.disconnectAllInputs()
            AudioKit.output = nil
//            self.amplitudeTap.stop()
            try AudioKit.stop()
            try AudioKit.shutdown()
        } catch {
            print("AudioKit did not stop")
        }
        AudioKit.output = nil
    }
    }
}
