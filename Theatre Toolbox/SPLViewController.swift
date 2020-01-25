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
		AKMicrophone()
		trackVolume()
		try!AudioKit.start()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var volumeLevel: UILabel!
    @IBOutlet weak var maxDbLabel: UILabel!
    
    var maxDb = 0
    
    
	func trackVolume() {

		 let mixer = AKMixer()
		 let amplitudeTap = AKMicrophoneTracker()
        
        maxDbLabel.text = String(maxDb)
        

		 
		 AudioKit.output = mixer
		 amplitudeTap.start()
		 try!AudioKit.start()


		Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { (timer) in

			// Estimated dB
            let amplitude = 20*log10(amplitudeTap.amplitude) + 80
            

			self.volumeLevel.text = String(Int(amplitude))
            
            if(Int(amplitude) > self.maxDb)
            {
                self.maxDb = Int(amplitude)
                self.maxDbLabel.text = String(self.maxDb)
            }
			
		})
	
}
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
		do {
			AudioKit.disconnectAllInputs()
			try AudioKit.stop()
			try AudioKit.shutdown()
		} catch {
			print("AudioKit did not stop")
		}
		AudioKit.output = nil
    }
}
