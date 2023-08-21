//
//  DataPoint.swift
//  RadarChart
//
//  Created by Marcelo De Araújo on 21/08/23.
//

import SwiftUI

struct DataPoint: Identifiable {
    
    var id = UUID()
    var entrys: [RayEntry]
    var color: Color
    
    init (
        intelligence:Double,
        funny: Double,
        empathy:Double,
        veracity: Double,
        selflessness:Double,
        authenticity:Double,
        boldness: Double,
        color:Color
    ){
        self.entrys = [
            RayEntry(rayCase: .Intelligence, value: intelligence),
            RayEntry(rayCase: .Authenticity, value: authenticity),
            RayEntry(rayCase: .Empathy, value: empathy),
            RayEntry(rayCase: .Veracity, value: veracity) ,
            RayEntry(rayCase: .Funny, value: funny) ,
            RayEntry(rayCase: .Selflessness, value: selflessness),
            RayEntry(rayCase: .Boldness, value: boldness),
        ]
        self.color = color
    }
}
