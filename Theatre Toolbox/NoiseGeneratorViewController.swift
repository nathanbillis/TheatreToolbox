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
	// let filteredBPNoise = AKCombFilterReverb(bandPassNoise, reverbDuration: 1, loopDuration: 1)
	
	

	@IBOutlet var amplitudeSlider: UISlider!
	@IBOutlet var frequencySlider: UISlider!
	
    
    //MARK: Functions
    
    func initalise(){
        AudioKit.output = AKMixer(pinkNoise, sineWave, whiteNoise)
        
        pinkNoise.stop()
        whiteNoise.stop()
		bandPassNoise.stop()
        
        sineWave.amplitude = Double(amplitudeSlider.value)
        pinkNoise.amplitude = Double(amplitudeSlider.value)
        whiteNoise.amplitude = Double(amplitudeSlider.value)

        try!AudioKit.start()
        
    }
    
    @IBAction func amplitudeSliderMoved(_ sender: UISlider) {
        sineWave.amplitude = Double(amplitudeSlider.value)
        pinkNoise.amplitude = Double(amplitudeSlider.value)
        whiteNoise.amplitude = Double(amplitudeSlider.value)
    }
    
    @IBAction func pinkNoiseButtonPressed(_ sender: UIButton) {
        if(pinkNoise.isPlaying){
            pinkNoise.stop()
        }
        else{
			if(whiteNoise.isPlaying || sineWave.isPlaying || bandPassNoise.isPlaying){
                whiteNoise.stop()
                sineWave.stop()
				bandPassNoise.stop()
            }
            pinkNoise.start()}
            }
    
	@IBAction func bandPassButtonPressed(_ sender: UIButton) {
		if (bandPassNoise.isPlaying){
			bandPassNoise.stop()
		}
			else{
				if(whiteNoise.isPlaying || sineWave.isPlaying || pinkNoise.isPlaying){
					whiteNoise.stop()
					sineWave.stop()
					pinkNoise.stop()
				}
			
			bandPassNoise.start()
		}
		
	}
	
	
	@IBAction func sineWavePressed(_ sender: UIButton) {
        if(sineWave.isPlaying){
            sineWave.stop()
        }
        else {
			if(whiteNoise.isPlaying || pinkNoise.isPlaying || bandPassNoise.isPlaying){
                whiteNoise.stop()
                pinkNoise.stop()
				bandPassNoise.stop()
            }
        sineWave.frequency = 440
        sineWave.start()
        }
        
    }
    
    @IBAction func whiteNoiseButtonPressed(_ sender: UIButton) {
        
        if(whiteNoise.isPlaying){
            whiteNoise.stop()
        }
        else{
			if(pinkNoise.isPlaying || sineWave.isPlaying || bandPassNoise.isPlaying){
                pinkNoise.stop()
                sineWave.stop()
				bandPassNoise.stop()
            }
            whiteNoise.start()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        try!AudioKit.stop()
    }
    
    
    
}
