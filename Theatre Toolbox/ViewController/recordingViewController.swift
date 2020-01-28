//
//  recordingViewController.swift
//  Theatre Toolbox
//
//  Created by Nathan Billis on 28/01/2020.
//  Copyright © 2020 Nathan Billis. All rights reserved.
//

import Foundation
import UIKit
import AudioKitUI
import AudioKit

class RecordingViewController: UIViewController{
	
	@IBOutlet var plot: AKNodeOutputPlot?
	@IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var reverbStepper: UIStepper!
    @IBOutlet weak var reverbName: UILabel!
    @IBOutlet weak var wetDryMixer: UISlider!
    @IBOutlet weak var wetDryMixLabel: UILabel!
    
	
	var mixer: AKMixer!
	var tape: AKAudioFile!
	var recorder: AKNodeRecorder!
	var booster: AKBooster!
	var player: AKPlayer!
	var mainMix: AKMixer!
    var reverb: AKReverb!

	let mic = AKMicrophone()

    
    override func viewDidLoad(){
		super.viewDidLoad()
		
		setupRecording()
       	wetDryMixLabel.text = String(Double(wetDryMixer.value))
		setReverb()
		
		AudioKit.output = reverb
		try!AudioKit.start()

	}
    
    
	
	func setupRecording(){
		// setup recording features
		
		// limit stereo field effect & setup routing
		let mono2stereo = AKStereoFieldLimiter(mic, amount: 1)
		mixer = AKMixer(mono2stereo)
		booster = AKBooster(mixer)
		
		// set level of mic monitor
		booster.gain = 0.0
		recorder = try?AKNodeRecorder(node: mixer)
		
		if let file = recorder.audioFile{
			player = AKPlayer(audioFile: file)
		}
		player.isLooping = true
		
		mainMix = AKMixer(booster,player)
        reverb = AKReverb(mainMix)
	}
	
	
    func setReverb(){
		// set the reverb from the stepper value
		reverb.dryWetMix = Double(wetDryMixer.value)
        switch Int(reverbStepper.value){
        case 1:
            reverb.loadFactoryPreset(.cathedral)
            reverbName.text = "Cathedral"
        case 2:
            reverb.loadFactoryPreset(.largeHall)
            reverbName.text = "Large Hall"
        case 3:
            reverb.loadFactoryPreset(.largeHall2)
            reverbName.text = "Large Hall 2"
        case 4:
            reverb.loadFactoryPreset(.largeRoom)
            reverbName.text = "Large Room"
        case 5:
            reverb.loadFactoryPreset(.largeRoom2)
            reverbName.text = "Large Room 2"
        case 6:
            reverb.loadFactoryPreset(.mediumChamber)
            reverbName.text = "Medium Chamber"
        case 7:
            reverb.loadFactoryPreset(.mediumHall)
            reverbName.text = "Medium Hall"
        case 8:
            reverb.loadFactoryPreset(.mediumHall2)
            reverbName.text = "Medium Hall 2"
        case 9:
            reverb.loadFactoryPreset(.mediumHall3)
            reverbName.text = " Medium Hall 3"
        case 10:
            reverb.loadFactoryPreset(.mediumRoom)
            reverbName.text = "Medium Room"
        case 11:
            reverb.loadFactoryPreset(.plate)
            reverbName.text = "Plate"
        case 12:
            reverb.loadFactoryPreset(.smallRoom)
            reverbName.text = "Small Room"
        default:
            reverbName.text = "No Reverb Found!"
            break
        }
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
		// set the reverb
        setReverb()
    }
	
    @IBAction func reverbSliderChanged(_ sender: UISlider) {
		// update when reverb slider changes
        reverb.dryWetMix = Double(wetDryMixer.value)
        wetDryMixLabel.text = String(format: "%.2f", wetDryMixer.value)
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        if(!recorder.isRecording){
            try?recorder.record()
        }else{
            tape = recorder.audioFile!
            player.load(audioFile: tape)
            
            if let _ = player.audioFile?.duration {
                recorder.stop()
                tape.exportAsynchronously(name: "sessionFile.wav", baseDir: .documents, exportFormat: .wav, callback: callback)
        }
    }
}
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        player.play()
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        if(recorder.isRecording){
            tape = recorder.audioFile!
            player.load(audioFile: tape)
            
            if let _ = player.audioFile?.duration {
                recorder.stop()
                tape.exportAsynchronously(name: "sessionFile.wav", baseDir: .documents, exportFormat: .wav, callback: callback)
            }
        }
        player.stop()

        
    }
    @IBAction func resetButtonPressed(_ sender: Any) {
        player.stop()
		try!recorder.reset()
		player.load(audioFile: recorder.audioFile!)
    }
    

    
    func callback(processedFile: AKAudioFile?, error: NSError?) {
    print("Export completed!")
    
    // Check if processed file is valid (different from nil)
    if let converted = processedFile {
    print("Export succeeded, converted file: \(converted.fileNamePlusExtension)")
    // Print the exported file's duration
    print("Exported File Duration: \(converted.duration) seconds")
        }
        
    }
}
