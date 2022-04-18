//
//  ChartsViewController.swift
//  My tasks  project
//
//  Created by Mahia113
//

import Foundation
import UIKit
import Charts

class ChartsViewController: UIViewController, ChartsViewControllerDelegate {
    
    var rootChartData: RootChartsModel?
    private var chartsPresenter = ChartsPresenter()
    private let reuseIdentifier = "ChartCell"

    @IBOutlet weak var collectionViewCharts: UICollectionView!

    private let sectionInsets = UIEdgeInsets(
      top: 10.0,
      left: 10.0,
      bottom: 10.0,
      right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartsPresenter.setViewDelegate(chartsViewControllerDelegate: self)
        chartsPresenter.getChartData()
    }
    
    func chartData(charts: RootChartsModel) {
        DispatchQueue.main.async {
            self.rootChartData = charts
            self.collectionViewCharts.reloadData()
        }
    }
    
    func errorGettingCharts(error: String) {
        print("error: \(error)")
    }
    
    func getPieChartData(charts: [QuestionModel], index: Int) -> PieChartData {
        
        var dataPoints: [String] = []
        var values: [Double] = []
        
        for value in charts[index].chartData.enumerated()  {
            dataPoints.append(value.element.text)
            values.append(Double(value.element.percetnage))
        }
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
          dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: charts[index].text)
        pieChartDataSet.colors = arrayUIColors(arrayOfHexColors: rootChartData!.colors)
                
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        return pieChartData
    }
    
}

extension ChartsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rootChartData?.questions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChartViewCell
        cell.PieChartView.data = getPieChartData(charts: rootChartData!.questions, index: indexPath.section)
        return cell
    }
    
}

extension ChartsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ChartsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let withForItem = (view.frame.width - (sectionInsets.left * 3))
        let heightForItem = (view.frame.height / 3.0) * 1.5
        
        return CGSize(width: withForItem, height: heightForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
    
}
