//
//  Ray.swift
//  RadarChart
//
//  Created by Marcelo De Araújo on 21/08/23.
//

import SwiftUI

struct Ray: Identifiable {
    var id = UUID()
    var name: String
    var maxValue: Double
    var rayCase: RayCase

    init( maxValue: Double, rayCase: RayCase) {
        self.rayCase = rayCase
        self.name = rayCase.rawValue
        self.maxValue = maxValue
    }
}


func deg2rad(_ number: CGFloat) -> CGFloat {
    return number * .pi / 180
}

func radAngleFromFraction(numerator: Int, denominator: Int) -> CGFloat {
    return deg2rad(360 * (CGFloat(numerator) / CGFloat(denominator)))
}

func degAngleFromFraction(numerator: Int, denominator: Int) -> CGFloat {
    return 360 * (CGFloat(numerator) / CGFloat(denominator))
}
