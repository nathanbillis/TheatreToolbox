//
//  NoiseGeneratorViewController.swift
//  Theatre Toolbox
//
//  Created by Nathan Billis on 15/01/2020.
//  Copyright © 2020 Nathan Billis. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class NoiseGeneratorViewController: UIViewController {
	// View Controller for the Noise Generator screen

    override func viewDidLoad() {
        super.viewDidLoad()
        initalise()
        // Do any additional setup after loading the view.
    }


	let noiseGenerator = NoiseGenerator()
	

	@IBOutlet var amplitudeSlider: UISlider!
	@IBOutlet var frequencySlider: UISlider!
    @IBOutlet weak var frequencyLabel: UILabel!
    
    
    //MARK: Functions
    
    func initalise(){
		// Initalise the view and stops the noise
        AudioKit.output = noiseGenerator.output()
		
		// stop all output noise
       noiseGenerator.stopNoise()
		
		// setup the amplitudes
		noiseGenerator.setAmplitude(amplitude: Double(amplitudeSlider.value))
		
		// setup frequency label
        frequencyLabel.text = String(Int(frequencySlider.value))

		// start AudioKit!
		try!AudioKit.start()
		
    }
    
    @IBAction func amplitudeSliderMoved(_ sender: UISlider) {
		// Updates amplitude when slider is moved
		noiseGenerator.setAmplitude(amplitude: Double(amplitudeSlider.value))
    }
    
    @IBAction func pinkNoiseButtonPressed(_ sender: UIButton) {
		// Toggles Pink Noise
		if (noiseGenerator.isPinkNoisePlaying()){
			noiseGenerator.stopNoise()
		} else {
			noiseGenerator.stopNoise()
			noiseGenerator.startPinkNoise()
		}
	}
    
    
	@IBAction func bandPassButtonPressed(_ sender: UIButton) {
        // Not really bandPass Noise but is working for now.
		if(noiseGenerator.isBandPassPlaying()){
			noiseGenerator.stopNoise()
		} else{
			noiseGenerator.stopNoise()
			noiseGenerator.startBandPassedNoise()
		}
	}
	
	
	@IBAction func sineWavePressed(_ sender: UIButton) {
		// Toggles Sine Wave
		if(noiseGenerator.isSineWavePlaying()){
			noiseGenerator.stopNoise()
		} else {
		noiseGenerator.stopNoise()
		noiseGenerator.startSineWave()
			
		}
    }
    
    @IBAction func whiteNoiseButtonPressed(_ sender: UIButton) {
		// Toggles White Noise
		if(noiseGenerator.isWhiteNoisePlaying()){
			noiseGenerator.stopNoise()
		} else{
		noiseGenerator.stopNoise()
		noiseGenerator.startWhiteNoise()
		}
	}
    
    @IBAction func frequencyChanged(_ sender: UISlider) {
		// Update the labels and frequencies when frequencies change
		noiseGenerator.setFrequency(frequency: Double(frequencySlider.value))
        frequencyLabel.text = String(Int(frequencySlider.value))
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
		// Turns off output and returns to menu scrteen
		
		if(noiseGenerator.isPlaying()){
			noiseGenerator.stopNoise()
		}
		
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
