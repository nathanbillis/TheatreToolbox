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
		 AKSettings.audioInputEnabled = true
		 
		 // Shared by SPL + RTA
		 let mic = AKMicrophone()
		 let booster = AKBooster(mic)
		 let tracker = AKFrequencyTracker(booster)
		 let silence = AKBooster(tracker, gain: 0)
		
		 // Tap for RTA
//		 let tap = AKFFTTap(booster)
		 let mixer = AKMixer(silence)
		let amplitudeTap = AKMicrophoneTracker()
//		 var timer: Timer!
//		 let FFTSize = 512
//		 var sampleRate:double_t = 44100
//		 var fttdata = 0.0

		 
		 AudioKit.output = mixer
		 amplitudeTap.start()
		 try!AudioKit.start()


		Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in

				
				let amplitude = 20*log10(amplitudeTap.amplitude) + 70
				

			self.volumeLevel.text = String(amplitude)
			
			print(average)


		})
	
		
		


    

}
}
