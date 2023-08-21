//
//  ContentView.swift
//  RadarChart
//
//  Created by Marcelo De Araújo on 21/08/23.
//

import SwiftUI

let dimensions = [

    Ray(maxValue: 10, rayCase: .Empathy),
    Ray(maxValue: 10, rayCase: .Funny),
    Ray(maxValue: 10, rayCase: .Intelligence),
    Ray(maxValue: 10, rayCase: .Veracity),
    Ray(maxValue: 10, rayCase: .Selflessness),
    Ray(maxValue: 10, rayCase: .Authenticity),
    Ray(maxValue: 10, rayCase: .Boldness),
]

let data = [

    DataPoint(
        intelligence: 10,
        funny: 3,
        empathy: 7,
        veracity: 4,
        selflessness: 1,
        authenticity: 7,
        boldness: 5,
        color: .red),

    DataPoint(
        intelligence: 5,
        funny: 2,
        empathy: 9,
        veracity: 6,
        selflessness: 3,
        authenticity: 4,
        boldness: 8,
        color: .blue),

    DataPoint(
        intelligence: 4,
        funny: 2,
        empathy: 1,
        veracity: 6,
        selflessness: 9,
        authenticity: 4,
        boldness: 10,
        color: .green)
]

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("RADAR")
                    .font(.system(size: 30, weight: .semibold))
                RadarChartView(
                    mainColor: .brown,
                    subtleColor: .pink,
                    width: 370,
                    quantityIncrementalDividers: 4,
                    dimensions: dimensions,
                    data: data
                )
                Spacer()
            }
            .foregroundColor(.white)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
