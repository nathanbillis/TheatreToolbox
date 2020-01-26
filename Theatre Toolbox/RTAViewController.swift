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
import SwiftCharts



class RTAViewController: UIViewController {
    
	var mic: AKMicrophone!
    
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height


    
	override func viewDidLoad() {
		super.viewDidLoad()
		mic = AKMicrophone()
		createRTA()
		try!AudioKit.start()
		
		// Do any additional setup after loading the view.
	}
	
	func createRTA(){
		mic.start()
		
		AKSettings.audioInputEnabled = true

		let frame = CGRect(x: 0, y: 200, width: screenWidth, height: screenHeight - 200)
		
		let plot = AKNodeFFTPlot(mic, frame: frame)
		let tracker = AKFrequencyTracker.init(mic)
		let silence = AKBooster(tracker,gain:0)
		let mixer = AKMixer(silence)
		AudioKit.output = mixer
		try!AudioKit.start()
		
		
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
	
	
	
    @IBAction func backButtonPressed(_ sender: UIButton) {
        do {
            // Stop all I/O and disconnect and shutdown AudioKit
            AudioKit.disconnectAllInputs()
            AudioKit.output = nil
//            self.frequencyTap.stop()
            try AudioKit.stop()
            try AudioKit.shutdown()
        } catch {
            print("AudioKit did not stop")
        }
        AudioKit.output = nil
    }
    
}
