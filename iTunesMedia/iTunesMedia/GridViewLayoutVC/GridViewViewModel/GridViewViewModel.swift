//
//  GridViewViewModel.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/19/24.
//

import Foundation

class GridViewViewModel{
    
    func seperateKeyAndValues(_ groupedItems: [String: [resultsDataModel]]) -> ([String], [[resultsDataModel]]){
           var  keyStrings =  Array(groupedItems.keys.sorted())
           var values = keyStrings.map { groupedItems[$0] ?? [] }
        return (keyStrings, values)
    }
}
