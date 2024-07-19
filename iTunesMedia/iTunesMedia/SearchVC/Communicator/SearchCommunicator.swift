//
//  SearchCommunicator.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/17/24.
//

import Foundation
import Combine


class SearchCommunicator{
    var cancellable = Set<AnyCancellable>()
    
    static  func getiTunesData(searchText: String, path: String) -> AnyPublisher<iTunesDataModel , NetworkError>{
        var orgPath = searchText
        if path != ""{
            orgPath = "\(searchText)" + "&entity=" + path
        }
        return Webservice.shared.getMethod(path: orgPath, isMock: false, type: iTunesDataModel.self, failureScenerio: false, mockPath: "")
    }
}
