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
	
	 let whiteNoise = AKWhiteNoise()
	 let pinkNoise = AKPinkNoise()
	 let sineWave = AKOscillator()
	
	func startWhiteNoise() {
		whiteNoise.start()
	}
	
	func startPinkNoise(){
		pinkNoise.start()
	}
	
	func startSineWave(){
		sineWave.start()
	}
	
	
}

