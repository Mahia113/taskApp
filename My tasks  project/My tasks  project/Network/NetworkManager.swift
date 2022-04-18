//
//  NetworkManager.swift
//  My tasks  project
//
//  Created by Mahia113
//


import Foundation
import Combine

public struct NetworkManager {
    
    private let client: ModuleOrchestrator
    private let URL = "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld"
    private let networkHandler: NetworkHandler = NetworkHandler()
    
    public init(client: ModuleOrchestrator){
        self.client = client
    }
    
    func getChartData() -> Future <RootChartsModel, Error> {
        return Future() { promise in
            
            networkHandler.performAPIRequestByURL(url: URL) {
                switch $0 {
                    case .success(let data):
                        if let rootChartData: RootChartsModel = self.networkHandler.decodeJSONData(data: data){
                            let rootData = rootChartData
                            
                            promise(.success(rootData))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                }
            }
            
        }
    }
    
}
