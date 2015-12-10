//
//  scale.swift
//  AudioKit For iOS
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright © 2015 AudioKit. All rights reserved.
//

import Foundation

extension AKP {

    /** scale: Linear tranformation from one range to another, based on minimum and maximum values. - This module scales from -1 to 1 to a range defined by a minimum and maximum
 point in the input and output domain.
     - returns: AKParameter
     - Parameter input: Input signal.
     - Parameter minimum: Minimum value to scale to. (Default: 0.0, Minimum: -1000000.0, Maximum: 1000000.0)
     - Parameter maximum: Maximum value to scale to. (Default: 1.0, Minimum: -1000000.0, Maximum: 1000000.0)
     */
    public static func scale(
        input: AKParameter,
        minimum: AKParameter = 0.0.ak,
        maximum: AKParameter = 1.0.ak
        ) -> AKParameter {
            return AKParameter("\(input)\(minimum)\(maximum)biscale")
    }
}