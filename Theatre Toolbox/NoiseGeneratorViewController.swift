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

    override func viewDidLoad() {
        super.viewDidLoad()
        initalise()
				
        // Do any additional setup after loading the view.
    }


	@IBOutlet var frequencyPicker: UIPickerView!
	let whiteNoise = AKWhiteNoise()
    let pinkNoise = AKPinkNoise()
    let sineWave = AKOscillator()
	
	// BandPass settings
    let bandPassNoise = AKWhiteNoise()
    lazy var filteredBPNoise = AKResonantFilter(bandPassNoise)
	

	@IBOutlet var amplitudeSlider: UISlider!
	@IBOutlet var frequencySlider: UISlider!
    @IBOutlet weak var frequencyLabel: UILabel!
    
    
    //MARK: Functions
    
    func initalise(){
        AudioKit.output = AKMixer(pinkNoise, sineWave, whiteNoise, filteredBPNoise)
        
        pinkNoise.stop()
        whiteNoise.stop()
		filteredBPNoise.stop()
        bandPassNoise.stop()
        
        sineWave.amplitude = Double(amplitudeSlider.value)
        pinkNoise.amplitude = Double(amplitudeSlider.value)
        whiteNoise.amplitude = Double(amplitudeSlider.value)
        bandPassNoise.amplitude = Double(amplitudeSlider.value)
        
        
        frequencyLabel.text = String(Int(frequencySlider.value))

		try!AudioKit.start()
		
    }
    
    @IBAction func amplitudeSliderMoved(_ sender: UISlider) {
        sineWave.amplitude = Double(amplitudeSlider.value)
        pinkNoise.amplitude = Double(amplitudeSlider.value)
        whiteNoise.amplitude = Double(amplitudeSlider.value)
        bandPassNoise.amplitude = Double(amplitudeSlider.value)
    }
    
    @IBAction func pinkNoiseButtonPressed(_ sender: UIButton) {
        if(pinkNoise.isPlaying){
            pinkNoise.stop()
        }
        else{
			if(whiteNoise.isPlaying || sineWave.isPlaying || filteredBPNoise.isPlaying){
                whiteNoise.stop()
                sineWave.stop()
                bandPassNoise.stop()
				filteredBPNoise.stop()
            }
            pinkNoise.start()}
            }
    
    
	@IBAction func bandPassButtonPressed(_ sender: UIButton) {
        // Not really bandPass Noise but is working for now.
        

		if (filteredBPNoise.isPlaying){
            bandPassNoise.stop()

			filteredBPNoise.stop()
		}
			else{
				if(whiteNoise.isPlaying || sineWave.isPlaying || pinkNoise.isPlaying){
					whiteNoise.stop()
					sineWave.stop()
					pinkNoise.stop()
				}
            
            filteredBPNoise.frequency = Double(frequencySlider.value)
            bandPassNoise.start()
			filteredBPNoise.start()
		}
		
	}
	
	
	@IBAction func sineWavePressed(_ sender: UIButton) {
        if(sineWave.isPlaying){
            sineWave.stop()
        }
        else {
			if(whiteNoise.isPlaying || pinkNoise.isPlaying || filteredBPNoise.isPlaying){
                whiteNoise.stop()
                pinkNoise.stop()
                bandPassNoise.stop()
				filteredBPNoise.stop()
            }
            sineWave.frequency = Double(frequencySlider.value)
        sineWave.start()
        }
        
    }
    
    @IBAction func whiteNoiseButtonPressed(_ sender: UIButton) {
        
        if(whiteNoise.isPlaying){
            whiteNoise.stop()
        }
        else{
			if(pinkNoise.isPlaying || sineWave.isPlaying || filteredBPNoise.isPlaying){
                pinkNoise.stop()
                sineWave.stop()
                bandPassNoise.stop()
				filteredBPNoise.stop()
            }
            whiteNoise.start()
        }
    }
    
    @IBAction func frequencyChanged(_ sender: UISlider) {
        sineWave.frequency = Double(frequencySlider.value)
        filteredBPNoise.frequency = Double(frequencySlider.value)
        frequencyLabel.text = String(Int(frequencySlider.value))
        
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
