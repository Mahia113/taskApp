//
//  NetworkManager.swift
//  My tasks  project
//
//  Created by Anzen on 13/04/22.
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
    
    func getChartData() -> Future <[QuestionModel], Error> {
        return Future() { promise in
            
            networkHandler.performAPIRequestByURL(url: URL) {
                switch $0 {
                    case .success(let data):
                        if let rootChartData: RootChartsModel = self.networkHandler.decodeJSONData(data: data){
                            let questions = rootChartData.questions
                            
                            promise(.success(questions))
                        }
                    case .failure(let error):
                        promise(.failure(error))
                }
            }
            
        }
    }
    
}
