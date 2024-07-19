//
//  SearchViewModel.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/17/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject{
    var cancellable = Set<AnyCancellable>()
    
    
    func getiTunesData(searchText: String,path: String, completion: @escaping (_ groupedResults :[String: [resultsDataModel]]? , NetworkError?) -> Void){
        
        if !(NetworkManager.shared.isConnect ?? false){
            completion(nil, NetworkError.noNetwork)
            return
        }
        SearchCommunicator.getiTunesData(searchText: searchText, path: path).sink { searchCompletion in
                switch searchCompletion{
                case .finished:
                    break
                    
                case .failure(let error):
                    completion(nil, error)
                    print("Error is \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] iTunesDataModel in
                completion(self?.seperateData(iTunesDataModel) ?? [:], nil)
            }
            .store(in: &cancellable)
        }
    
    
    
    func seperateData(_ iTunesDataModel: iTunesDataModel) -> [String: [resultsDataModel]] {
        
        var groupedResults = [String: [resultsDataModel]]()
        
        // Group the results by the 'kind' value
        for result in iTunesDataModel.results {
            if let kind = result.kind {
                if groupedResults[kind] == nil {
                    groupedResults[kind] = [result]
                } else {
                    groupedResults[kind]?.append(result)
                }
            }
        }
         return groupedResults
        
    }
    
    func filterPath(_ selectedItems: [Items]) -> String{
        var arrayPath = [String]()
        for selectedItem in selectedItems {
            arrayPath.append(selectedItem.title.lowercased())
        }
        let path = arrayPath.joined(separator: ",")
        return path
    }
    
}

