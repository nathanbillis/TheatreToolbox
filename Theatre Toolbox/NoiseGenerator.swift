//
//  NoiseGenerator.swift
//  Theatre Toolbox
//
//  Created by Nathan Billis on 24/01/2020.
//  Copyright © 2020 Nathan Billis. All rights reserved.
//

import Foundation
import AudioKit


class NoiseGenerator {
	
	
	// Initiaise Noise Generators
	 let whiteNoise = AKWhiteNoise()
	 let pinkNoise = AKPinkNoise()
	 let sineWave = AKOscillator()
	 let bandPassNoise = AKWhiteNoise()
	 lazy var filteredBPNoise = AKResonantFilter(bandPassNoise)
	
	var frequency = 440.00
	var amplitude = 0.5
	
	
	// Noise Generation
	func startWhiteNoise() {
		whiteNoise.amplitude = self.amplitude
		whiteNoise.start()
	}
	
	func startPinkNoise(){
		pinkNoise.amplitude = self.amplitude
		pinkNoise.start()
	}
	
	func startSineWave(){
		sineWave.amplitude = self.amplitude
		sineWave.frequency = self.frequency
		sineWave.start()
	}
	
	func startBandPassedNoise(){
		bandPassNoise.amplitude = self.amplitude
		filteredBPNoise.frequency = self.frequency
		bandPassNoise.start()
		filteredBPNoise.start()
	}
	
	func stopNoise(){
		whiteNoise.stop()
		pinkNoise.stop()
		sineWave.stop()
		filteredBPNoise.stop()
		bandPassNoise.stop()
	}
	
	
	// checks if the noise generator is playing any noise
	func isPlaying() -> Bool{
		if(whiteNoise.isPlaying || pinkNoise.isPlaying || sineWave.isPlaying || filteredBPNoise.isPlaying || bandPassNoise.isPlaying){
			return true
		}
		else{
			return false
		}
	}
	
	func isPinkNoisePlaying() -> Bool{
		if(pinkNoise.isPlaying){
			return true
		}
		else{
			return false
		}
	}
	
	func isWhiteNoisePlaying() -> Bool{
		if(whiteNoise.isPlaying){
			return true
		}
		else{
			return false
		}
	}
	
	func isSineWavePlaying() -> Bool{
		if(sineWave.isPlaying){
			return true
		}
		else{
			return false
		}
	}
	
	func isBandPassPlaying() -> Bool{
		if(filteredBPNoise.isPlaying || bandPassNoise.isPlaying){
			return true
		}
		else{
			return false
		}
	}
	
	
	// setters and getters for frequency and amplitude
	func setFrequency(frequency: Double){
		self.frequency = frequency
		
		sineWave.frequency = frequency
		filteredBPNoise.frequency = frequency
	}
	
	func getFrequency() -> Double{
		return self.frequency
	}
	
	
	func setAmplitude(amplitude: Double){
		self.amplitude = amplitude
		
		sineWave.amplitude = amplitude
		bandPassNoise.amplitude = amplitude
		whiteNoise.amplitude = amplitude
		pinkNoise.amplitude	= amplitude
	}
	
	func getAmplitude() -> Double{
		return self.amplitude
	}
	
	// handles the outputs
	func output() -> AKMixer{
		return AKMixer(pinkNoise,sineWave,whiteNoise,filteredBPNoise)
	}	
}
