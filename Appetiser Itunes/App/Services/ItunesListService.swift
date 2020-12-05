//
//  ItunesListService.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/20.
//

import Foundation
import SwiftyJSON
import CoreData

//
// Service class that will be processing all the Fetching of Data to Retreiving and storing it to local storage.
//
class ItunesListService: NSObject {
    var delegate: ItunesListServiceDelegate?
    
    override init() {
        super.init()
    }
    
    // MARK: Fetch API
    func getItunesList(completion: @escaping (_ fetchedList: [ItunesListModel]) -> ()) {
        if InternetConnectionService.shared.isConnected {
            let url = URL(string: Constants.url)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if let validError = error {
                    print(validError)
                } else {
                    do {
                        let dataJson = try? JSON(data: data!)
                        let listDataJson = dataJson?["results"]
                        let itunesListData = try? listDataJson?.rawData()
                        let itunesList = try! JSONDecoder().decode([ItunesListModel].self, from: itunesListData!)
                        let test = itunesList.contains { $0.previewUrl == nil }
                        print("has a null field --- \(test)")
                        DispatchQueue.main.async { [self] in
                            saveToLocal(apiList: itunesList) { (didSave) in
                                if didSave {
                                    loadFromLocal(isCheckingFromSave: false) { (localList) in
                                        completion(localList)
                                    }
                                }
                            }
                        }
                    }
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                self.loadFromLocal(isCheckingFromSave: false) { (localList) in
                    completion(localList)
                }
            }
        }
        
    }
    
    // MARK: Core Data
    func saveToLocal(apiList: [ItunesListModel], completion: @escaping(_ didSave: Bool) -> Void) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "ItunesList",
                                       in: managedContext)!
        
        
        
        for item in apiList {
            loadFromLocal(isCheckingFromSave: true) { (localList) in
                if localList.isEmpty {
                    print("start")
                    let localItunesList = NSManagedObject(entity: entity,
                                                          insertInto: managedContext)
                    localItunesList.setValue(item.previewUrl, forKeyPath: "previewUrl")
                    localItunesList.setValue(item.artworkUrl100, forKeyPath: "artworkUrl100")
                    localItunesList.setValue(item.primaryGenreName, forKeyPath: "primaryGenreName")
                    localItunesList.setValue(item.trackName, forKeyPath: "trackName")
                    localItunesList.setValue(item.trackPrice, forKeyPath: "trackPrice")
                    localItunesList.setValue(item.longDescription, forKeyPath: "longDescription")
                } else {
                    if !localList.contains(where: {$0.previewUrl == item.previewUrl}) {
                        print("does not contain")
                        let localItunesList = NSManagedObject(entity: entity,
                                                              insertInto: managedContext)
                        localItunesList.setValue(item.previewUrl, forKeyPath: "previewUrl")
                        localItunesList.setValue(item.artworkUrl100, forKeyPath: "artworkUrl100")
                        localItunesList.setValue(item.primaryGenreName, forKeyPath: "primaryGenreName")
                        localItunesList.setValue(item.trackName, forKeyPath: "trackName")
                        localItunesList.setValue(item.trackPrice, forKeyPath: "trackPrice")
                        localItunesList.setValue(item.longDescription, forKeyPath: "longDescription")
                    }
                }
            }
        }
        
        do {
            try managedContext.save()
            print("end")
            completion(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    func loadFromLocal(isCheckingFromSave: Bool, completion: @escaping(_ fetchedData: [ItunesListModel]) -> Void) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ItunesList")
        
        do {
            let localItunesList = try managedContext.fetch(fetchRequest) as! [ItunesList]
            var localizedData = [ItunesListModel]()
            for item in localItunesList {
                if !isCheckingFromSave {
                    updateImagesDataToLocal(previewUrl: item.previewUrl!)
                }
                localizedData.append(ItunesListModel(previewUrl: item.previewUrl, trackName: item.trackName, artworkUrl100: item.artworkUrl100, imageData: item.trackImage, trackPrice: item.trackPrice, primaryGenreName: item.primaryGenreName, longDescription: item.longDescription))
            }
            
            completion(localizedData)
            print(localizedData.count)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateImagesDataToLocal(previewUrl: String) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ItunesList")
        fetchRequest.predicate = NSPredicate(format: "previewUrl = %@", previewUrl)
        
        do {
            let localItunesList = try managedContext.fetch(fetchRequest) as! [ItunesList]
            if localItunesList.count != 0 {
                if localItunesList[0].trackImage == nil {
                    let imageUrlString = localItunesList.first?.artworkUrl100?.replacingOccurrences(of: "100", with: "500")
                    let imageUrl = URL(string: imageUrlString!)
                    URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
                        if let validError = error {
                            print(validError)
                        } else {
                            localItunesList[0].setValue(data, forKey: "trackImage")
                            
                            do {
                                try managedContext.save()
                                self.delegate?.DidSaveImageToLocal(previewUrl: previewUrl)
                                print("saved image to local image data")
                            } catch let error as NSError {
                                print("error saving \(error)")
                            }
                        }
                    }.resume()
                }

            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

protocol ItunesListServiceDelegate {
    func DidSaveImageToLocal(previewUrl: String)
}

// MARK: Data Models
struct ItunesListModel: Decodable {
    var previewUrl: String?
    var trackName: String?
    var artworkUrl100: String?
    var imageData: Data?
    var trackPrice: Double?
    var primaryGenreName: String?
    var longDescription: String?
}
