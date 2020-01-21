//
//  SPLViewController.swift
//  Theatre Toolbox
//
//  Created by Nathan Billis on 17/01/2020.
//  Copyright © 2020 Nathan Billis. All rights reserved.
//

import UIKit
import AudioKitUI
import AudioKit

class SPLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		trackVolume()
		try!AudioKit.start()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var volumeLevel: UILabel!
    

	@objc func trackVolume() {
        let mic = AKMicrophone()
        let tracker = AKAmplitudeTracker(mic)
		let silence = AKBooster(tracker, gain: 0)
		AudioKit.output = silence
        
        tracker.start()
        
		AKPlaygroundLoop(every: 1){
			print(tracker.leftAmplitude)
//            volumeLevel.text = String(tracker.leftAmplitude * 100)
		}
		

        volumeLevel.text = String(tracker.leftAmplitude * 100)
    }
	

    

}
