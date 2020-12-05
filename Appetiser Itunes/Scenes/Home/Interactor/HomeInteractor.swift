//
//  HomeHomeInteractor.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//
import Foundation

class HomeInteractor: HomeInteractorInput, InternetConnectionServiceDelegate, ItunesListServiceDelegate {
    weak var output: HomeInteractorOutput!
    let itunesListService = ItunesListService()
    
    // Call the fetch from the Itunes List Service Class and pass it the interactor output.
    func getItunesList() {
        itunesListService.getItunesList { (localList) in
            self.output.setItunesList(list: localList, didUpdateIndex: -1)
        }
    }
    
    func DidSaveImageToLocal(previewUrl: String) {
        DispatchQueue.main.async {
            self.itunesListService.loadFromLocal(isCheckingFromSave: true) { (localList) in
                for (index, item) in localList.enumerated() {
                    if item.previewUrl == previewUrl {
                        self.output.setItunesList(list: localList, didUpdateIndex: index)
                    }
                }
            }
        }
    }
    
    func Connected() {
        print("connected")
    }
    
    func Disconnected() {
        print("disconnected")
    }
}
