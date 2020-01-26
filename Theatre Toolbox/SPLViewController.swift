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
    
    //MARK: Variables
    override func viewDidLoad() {
        super.viewDidLoad()
		AKMicrophone()
        trackVolume(updateRate: 0.25)
		try!AudioKit.start()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet var volumeLevel: UILabel!
    @IBOutlet weak var maxDbLabel: UILabel!
    @IBOutlet weak var dBGraphAmount: UIProgressView!
    let amplitudeTap = AKMicrophoneTracker()
    let mixer = AKMixer()
    var maxDb = 0
    
    
    //MARK: Functions
    func trackVolume(updateRate: Double) {
        // Track the amplitude of the microphone and output

         self.maxDbLabel.text = String(self.maxDb)
		 AudioKit.output = mixer
		 self.amplitudeTap.start()
		 try!AudioKit.start()


		Timer.scheduledTimer(withTimeInterval: updateRate, repeats: true, block: { (timer) in

			// Estimated dB
            let amplitude = 20*log10(self.amplitudeTap.amplitude) + 80
            

			self.volumeLevel.text = String(Int(amplitude))
            
            let dbProgress = amplitude/180
            
			self.dbGraphRenderer(progress: Float(dbProgress))
            
            if(Int(amplitude) > self.maxDb)
            {
                self.maxDb = Int(amplitude)
                self.maxDbLabel.text = String(self.maxDb)
            }
			
		})
	
}
    
    
    func dbGraphRenderer(progress: Float){
		// Render the Graph different colours depending on the progress
        self.dBGraphAmount.progress = Float(progress)
        
        if(progress > 0.5){
            self.dBGraphAmount.progressTintColor = .red
        }else if (progress > 0.35){
            self.dBGraphAmount.progressTintColor = .yellow
        }
        else{
            self.dBGraphAmount.progressTintColor = .green
        }
        
    }
	
	
    @IBAction func backButtonPressed(_ sender: UIButton) {
		do {
            // Stop all I/O and disconnect and shutdown AudioKit
			AudioKit.disconnectAllInputs()
            AudioKit.output = nil
            self.amplitudeTap.stop()
			try AudioKit.stop()
			try AudioKit.shutdown()
		} catch {
			print("AudioKit did not stop")
		}
		AudioKit.output = nil
    }
}
