//
//  RadarChartView.swift
//  RadarChart
//
//  Created by Marcelo De Araújo on 21/08/23.
//

import SwiftUI

struct RadarChartView: View {

    var mainColor: Color
    var subtleColor: Color
    var center: CGPoint
    var labelWidth: CGFloat = 70
    var width: CGFloat
    var quantityIncrementalDividers: Int
    var dimensions: [Ray]
    var data: [DataPoint ]

    init(
        mainColor: Color,
        subtleColor: Color,
        width: CGFloat,
        quantityIncrementalDividers: Int,
        dimensions: [Ray],
        data: [DataPoint]
    ){
        self.mainColor = mainColor
        self.subtleColor = subtleColor
        self.center = CGPoint(x: width/2, y: width/2)
        self.width = width
        self.quantityIncrementalDividers = quantityIncrementalDividers
        self.dimensions = dimensions
        self.data = data
    }

    @State var showLabels = false
    
    var body: some View {

        ZStack {
// Mark: - Main Spokes
            Path { path in
                for i in 0..<self.dimensions.count {
                    let angle = radAngleFromFraction(numerator: i, denominator: self.dimensions.count)
                    let x = (self.width - (50 + self.labelWidth)) / 2 * cos(angle)
                    let y = (self.width - (50 + self.labelWidth)) / 2 * sin(angle)
                    path.move(to: center)
                    path.addLine(to: CGPoint(x: center.x + x, y: center.y + y))
                }
            }
            .stroke(self.mainColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

// Mark: - Labels
            ForEach(0..<self.dimensions.count) { i in
                
                Text(self.dimensions[i].rayCase.rawValue)
                    .font(.system(size: 10))
                    .foregroundColor(self.subtleColor)
                    .frame(width:self.labelWidth, height: 10)
                    .rotationEffect(
                        .degrees(
                            (degAngleFromFraction(numerator: i, denominator: self.dimensions.count) > 90 &&
                             degAngleFromFraction(numerator: i, denominator: self.dimensions.count) < 270) ? 180 : 0
                        )
                    )
                    .background(Color.clear)
                    .offset(x: (self.width - (50)) / 2)
                    .rotationEffect(
                        .radians(
                            Double(radAngleFromFraction(numerator: i, denominator: self.dimensions.count))
                        )
                    )

            }

// Mark: - Border
            Path { path in

                path.move (to: center)
                for i in 0..<self.dimensions.count + 1 {
                    let angle = radAngleFromFraction(numerator: i, denominator: self.dimensions.count)
                    let x = (self.width - (50 + self.labelWidth))/2 * cos(angle)
                    let y = (self.width - (50 + self.labelWidth))/2 * sin(angle)
                    if i == 0 {
                        path.move(to: CGPoint(x: center.x + x, y: center.y + y))
                    } else {
                        path.addLine(to: CGPoint(x: center.x + x, y: center.y + y))
                    }
                }
            }
            .stroke(self.mainColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

// Mark: - Incremental Dividers
            ForEach(0..<self.quantityIncrementalDividers) { j in
                Path { path in
                    for i in 0..<self.dimensions.count + 1 {
                        let angle = radAngleFromFraction(numerator: i, denominator: self.dimensions.count)
                        let size = ((self.width - (50 + self.labelWidth))/2) * (CGFloat(j + 1) / CGFloat(self.quantityIncrementalDividers + 1))
                        let x = size * cos (angle)
                        let y = size * sin (angle)
                        print (size)
                        print ((self.width - (50 + self.labelWidth)))
                        print("\(x) -- \(y)")
                        if i == 0 {
                            path.move(to: CGPoint(x: self.center.x + x, y: self.center.y + y))
                        } else {
                            path.addLine(to: CGPoint(x: self.center.x + x, y: self.center.y + y))
                        }
                    }
                }
                .stroke(self.subtleColor, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
            }

// Mark: - Data Polygons
            ForEach(0..<self.data.count) { j -> AnyView in

                // Mark: - Path
                let path = Path { path in

                    for i in 0..<self.dimensions.count + 1 {
                        let thisDimension = self.dimensions[i == self.dimensions.count ? 0 : i]
                        let maxValue = thisDimension.maxValue
                        let dataPointVal: Double = {
                            for DataPointRay in self.data[j].entrys {
                                if thisDimension.rayCase == DataPointRay.rayCase {
                                    return DataPointRay.value
                                }
                            }
                            return 0
                        }()

                        let angle = radAngleFromFraction(
                            numerator: i == self.dimensions.count ? 0 : i,
                            denominator: self.dimensions.count
                        )
                        let size = ((self.width - (50 + self.labelWidth))/2) * (CGFloat(dataPointVal)/CGFloat(maxValue))
                        let x = size * cos (angle)
                        let y = size * sin(angle)
                        print (size)
                        print((self.width - (50 + self.labelWidth)))
                        print("\(x) -- \(y)")
                        if i == 0 {
                            path.move (to: CGPoint(x: self.center.x + x, y: self.center.y + y) )
                        } else {
                            path.addLine(to: CGPoint(x: self.center.x + x, y: self.center.y +
                                                     y))
                        }
                    }
                }

// Mark: - Stroke and Fill
                return AnyView(
                    ZStack {
                        path.stroke(self.data[j].color, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                        path.foregroundColor (self.data[j].color).opacity (0.2)
                    }
                )
            }
        }
        .frame(width: width, height: width)
    }
}
