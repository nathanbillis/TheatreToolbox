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


/// View Controller for RTA
class RTAViewController: UIViewController {
	
	
	//MARK: Variables
	var mic: AKMicrophone!
	var plot: AKNodeFFTPlot!
	@IBOutlet weak var frequencyValue: UILabel!
	@IBOutlet weak var musicNoteValue: UILabel!
	@IBOutlet weak var amplitudeValue: UILabel!
	
	
	var screenWidth = UIScreen.main.bounds.width
	var screenHeight = UIScreen.main.bounds.height
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mic = AKMicrophone()
		createRTA()
		AudioKit.output = AKMixer()
		try!AudioKit.start()
		updateValues()
	}
	
	
	//MARK: Functions
	func createRTA(){
		/*
		Creates Fake RTA
		FEATURE add with proper values and logarithmic display
		*/
		mic.start()
		
		AKSettings.audioInputEnabled = true
		
		let frame = CGRect(x: 0, y: 200, width: screenWidth, height: screenHeight - 200)
		plot = AKNodeFFTPlot(mic, frame: frame)
		
		plot.shouldMirror = false
		plot.color = .white
		plot.backgroundColor = .init(displayP3Red: 127, green: 46, blue: 38, alpha: 0)
		plot.plotType = .buffer
		plot.shouldFill = true
		plot.shouldCenterYAxis = false
		plot.gain = 100
		
		plot.contentScaleFactor = 10
		plot.clipsToBounds = true
		plot.pointCount = 50
		self.view.addSubview(plot)
	}
	
	func updateValues(){
		// Updates the values of the trackers on screen
		let tracker = AKMicrophoneTracker()
		tracker.start()
		
		Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
			
			self.frequencyValue.text = String(Int(tracker.frequency))
			let amplitude = 20*log10(tracker.amplitude) + 80
			
			self.amplitudeValue.text = String(Int(amplitude))
		})
	}
	
	
	
	@IBAction func backButtonPressed(_ sender: UIButton) {
		do {
			// Stop all I/O and disconnect and shutdown AudioKit
			AudioKit.disconnectAllInputs()
			self.mic.stop()
			try AudioKit.stop()
			try AudioKit.shutdown()
		} catch {
			print("AudioKit did not stop")
		}
		AudioKit.output = nil
	}
	
}
