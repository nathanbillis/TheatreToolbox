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
	
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var amplitudeSlider: UISlider!
    @IBOutlet weak var reverbStepper: UIStepper!
    @IBOutlet weak var reverbName: UILabel!
    @IBOutlet weak var wetDryMixer: UISlider!
    @IBOutlet weak var wetDryMixLabel: UILabel!
    
    
    override func viewDidLoad(){
		super.viewDidLoad()
	}
    
    
}
