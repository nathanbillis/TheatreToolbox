//
//  movingAverage.swift
//  Theatre Toolbox
//
//  Created by Nathan Billis on 22/01/2020.
//  Copyright © 2020 Nathan Billis. All rights reserved.
//

import Foundation

class movingAverage {
  var samples: Array<Double>
  var sampleCount = 0
  var period = 5
  
  init(period: Int = 5) {
	  self.period = period
	  samples = Array<Double>()
  }

  var average: Double {
	  let sum: Double = samples.reduce(0, +)
	  
	  if period > samples.count {
		  return sum / Double(samples.count)
	  } else {
		  return sum / Double(period)
	  }
  }

  func addSample(value: Double) -> Double {
	  sampleCount = sampleCount + 1
	  let pos = Int(fmodf(Float(sampleCount + 1), Float(period)))
	  
	  if pos >= samples.count {
		  samples.append(value)
	  } else {
		  samples[pos] = value
	  }
	  
	  return average
  }
}
