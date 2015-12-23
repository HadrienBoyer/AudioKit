//
//  AKHighShelfFilter.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/** AudioKit version of Apple's HighShelfFilter Audio Unit */
public struct AKHighShelfFilter: AKNode {
    
    private let cd = AudioComponentDescription(
        componentType: kAudioUnitType_Effect,
        componentSubType: kAudioUnitSubType_HighShelfFilter,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)
    
    private var internalEffect = AVAudioUnitEffect()
    private var internalAU = AudioUnit()
    public var avAudioNode: AVAudioNode
    
    /** Cut Off Frequency (Hz) ranges from 10000 to 22050 (Default: 10000) */
    public var cutOffFrequency: Double = 10000 {
        didSet {
            if cutOffFrequency < 10000 {
                cutOffFrequency = 10000
            }
            if cutOffFrequency > 22050 {
                cutOffFrequency = 22050
            }
            AudioUnitSetParameter(
                internalAU,
                kHighShelfParam_CutOffFrequency,
                kAudioUnitScope_Global, 0,
                Float(cutOffFrequency), 0)
        }
    }
    
    /** Gain (dB) ranges from -40 to 40 (Default: 0) */
    public var gain: Double = 0 {
        didSet {
            if gain < -40 {
                gain = -40
            }
            if gain > 40 {
                gain = 40
            }
            AudioUnitSetParameter(
                internalAU,
                kHighShelfParam_Gain,
                kAudioUnitScope_Global, 0,
                Float(gain), 0)
        }
    }
    
    /** Initialize the high shelf filter node */
    public init(
        _ input: AKNode,
        cutOffFrequency: Double = 10000,
        gain: Double = 0) {
            
            self.cutOffFrequency = cutOffFrequency
            self.gain = gain
            
            internalEffect = AVAudioUnitEffect(audioComponentDescription: cd)
            self.avAudioNode = internalEffect
            AKManager.sharedInstance.engine.attachNode(self.avAudioNode)
            AKManager.sharedInstance.engine.connect(input.avAudioNode, to: self.avAudioNode, format: AKManager.format)
            internalAU = internalEffect.audioUnit
            
            AudioUnitSetParameter(internalAU, kHighShelfParam_CutOffFrequency, kAudioUnitScope_Global, 0, Float(cutOffFrequency), 0)
            AudioUnitSetParameter(internalAU, kHighShelfParam_Gain, kAudioUnitScope_Global, 0, Float(gain), 0)
    }
}
