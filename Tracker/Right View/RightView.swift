//
//  RightView.swift
//  Tracker
//
//  Created by Lex Nasser on 11/7/18.
//  Copyright © 2018 Lex Nasser. All rights reserved.
//

import UIKit
import Charts

class RightView : ChartViewController {
    
    @IBOutlet weak var chartView : HorizontalBarChartView!
    
    var dataEntry : [ BarChartDataEntry ] = [ ]

    
    @IBAction func refreshChart(_ sender: UIButton) {
        loadCountsFromUserDefaults ( )

        var nonZeroCountsDict : [ String : Int] = [ : ]

        for ( key, value ) in counts {

            if value > 0 {

                nonZeroCountsDict [ key ] = value

            }

        }

        let sortedByValueDictionary = nonZeroCountsDict.sorted { $0.1 < $1.1 }

        var xLabs : [ String ] = [ ]
        var yVals : [ Int ] = [ ]
        for (key, value) in sortedByValueDictionary {
            for i in 0 ..< thoughtTrapArray.count  {
                //let index : Int = thoughtTrapArray.index(of: key)!
                if thoughtTrapArray[i].key == Int(key) {
                    xLabs.append(thoughtTrapArray[i].name)
                }
            }
            yVals.append(value)
        }

        let xData = xLabs
        let yData = yVals

        self.setChart(dataPoints: xData, values: yData)
    }

    override func viewDidLoad () {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Horizontal Bar Char"
        
        self.setup(barLineChartView: chartView)

        chartView.delegate = self

        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true

        chartView.maxVisibleCount = 60
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.granularity = 10

        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0

        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = true
        rightAxis.axisMinimum = 0

        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        //        chartView.legend = l

        chartView.fitBars = true

        chartView.animate(yAxisDuration: 2.5)

        loadCountsFromUserDefaults()

        var nonZeroCountsDict: [String:Int] = [:]

        for (key, value) in counts {
            if value > 0 {
                nonZeroCountsDict[key] = value
            }
        }
        let sortedByValueDictionary = nonZeroCountsDict.sorted { $0.1 < $1.1 }

        // get names from thoughtTrapArray
        var xLabs: [String] = []
        var yVals: [Int] = []
        for (key, value) in sortedByValueDictionary {
            for i in 0 ..< thoughtTrapArray.count  {
            //let index : Int = thoughtTrapArray.index(of: key)!
                if thoughtTrapArray[i].key == Int(key) {
                    xLabs.append(thoughtTrapArray[i].name)
                }
            }
            yVals.append(value)
        }

        let xData = xLabs
        let yData = yVals

        self.setChart(dataPoints: xData, values: yData)
    }

    func loadCountsFromUserDefaults() {
        if let dict = UserDefaults.standard.object(forKey: "counts") as? [String: Int] {
            counts = dict
        }
    }


    func setChart(dataPoints: [String], values: [Int])
    {
        chartView.noDataText = "You need to provide data for the chart."
        
        for i in 0..<values.count
        {
            let dataPoint = BarChartDataEntry(x: Double(i), yValues: [Double(values[i])])
            dataEntry.append(dataPoint)
        }

        //let chartDataSet:BarChartDataSet!

        let chartDataSet = BarChartDataSet(values: dataEntry, label: "Count")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        chartView.xAxis.granularityEnabled = true
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelCount = 30
        chartView.xAxis.granularity = 1
        chartView.leftAxis.enabled = true
        //chartView.leftAxis.labelPosition = .outsideChart
        //chartView.leftAxis.decimals = 0
        //let minn = Double(values.min()!) - 0.1
        //chartView.leftAxis.axisMinimum = Double(values.min()! - 0.1)
        //chartView.leftAxis.granularityEnabled = true
        chartView.leftAxis.granularity = 1.0
        //chartView.leftAxis.labelCount = 5
        //chartView.leftAxis.axisMaximum = Double(values.max()! + 0.05)
        chartView.data?.setDrawValues(false)
        chartView.pinchZoomEnabled = true
        chartView.scaleYEnabled = true
        chartView.scaleXEnabled = true
        chartView.highlighter = nil
        chartView.doubleTapToZoomEnabled = true
        chartView.chartDescription?.text = ""
        chartView.rightAxis.enabled = false
        

        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutQuart)
        chartDataSet.colors = [UIColor(red: 16/255, green: 71/255, blue: 86/255, alpha: 1)]

        chartView.data = chartData
        
    }
}
