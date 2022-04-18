//
//  ChartsPresenter.swift
//  My tasks  project
//
//  Created by Mahia113
//

import Foundation
import Combine


protocol ChartsViewControllerDelegate:NSObjectProtocol {
    func chartData(charts: RootChartsModel)
    func errorGettingCharts(error: String)
}

class ChartsPresenter {
    
    weak private var chartsViewControllerDelegate: ChartsViewControllerDelegate?
    
    private let moduleOrchestator = ModuleOrchestrator()
    private var cancellable: AnyCancellable?
    
    func setViewDelegate(chartsViewControllerDelegate: ChartsViewControllerDelegate?){
        self.chartsViewControllerDelegate = chartsViewControllerDelegate
    }
    
    func getChartData() {
        cancellable = moduleOrchestator.NetworkManager().getChartData().sink(receiveCompletion: { completion in
            
            switch completion {
            case .failure(let error):
                //self.homeViewControllerDelegate?.errorFetchingWeatherData(error: error)
                print("failure: \(error)")
                self.chartsViewControllerDelegate?.errorGettingCharts(error: "Something wrong downloading charts. Try again. \(error)")
            case .finished:
                print("Success")
                break
            }
            
        }, receiveValue: { rooChartData in
            self.chartsViewControllerDelegate?.chartData(charts: rooChartData)
        })
    }
    
}
