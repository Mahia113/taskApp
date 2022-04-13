//
//  ChartsViewController.swift
//  My tasks  project
//
//  Created by Anzen on 13/04/22.
//

import Foundation
import UIKit
import Charts

class ChartsViewController: UIViewController, ChartsViewControllerDelegate {
    
    var questionModel: [QuestionModel] = []
    private var chartsPresenter = ChartsPresenter()
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var pirChartView2: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartsPresenter.setViewDelegate(chartsViewControllerDelegate: self)
        chartsPresenter.getChartData()
    }
    
    func chartData(charts: [QuestionModel]) {
        
        
        // I need more time to fix this code and add funtionality to create a dinamyc table with charts.
        
        var dataPoints1: [String] = []
        var values1: [Int] = []
        
        for value in charts.first!.chartData.enumerated()  {
            dataPoints1.append(value.element.text)
            values1.append(value.element.percetnage)
        }
        
        var dataPoints2: [String] = []
        var values2: [Int] = []
        
        for value in charts[1].chartData.enumerated()  {
            dataPoints2.append(value.element.text)
            values2.append(value.element.percetnage)
        }
        
        DispatchQueue.main.async {
            self.customizeChart1(dataPoints: dataPoints1, values: values1.map{ Double($0) }, chart: charts.first!)
            self.customizeChart2(dataPoints: dataPoints2, values: values2.map{ Double($0) }, chart: charts[1])
        }
        
    }
    
    func errorGettingCharts(error: String) {
        print("error: \(error)")
    }
    
    func customizeChart1(dataPoints: [String], values: [Double], chart: QuestionModel) {
      // TO-DO: customize the chart here
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
          dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label:  chart.text)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
        
    }
    
    func customizeChart2(dataPoints: [String], values: [Double], chart: QuestionModel) {
      // TO-DO: customize the chart here
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
          dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label:  chart.text)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart’s data
        pirChartView2.data = pieChartData
        
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }
}
