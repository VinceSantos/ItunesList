//
//  ItunesList+CoreDataProperties.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/20.
//
//

import Foundation
import CoreData


extension ItunesList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItunesList> {
        return NSFetchRequest<ItunesList>(entityName: "ItunesList")
    }

    @NSManaged public var artworkUrl100: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var primaryGenreName: String?
    @NSManaged public var trackImage: Data?
    @NSManaged public var trackName: String?
    @NSManaged public var trackPrice: Double
    @NSManaged public var longDescription: String?

}

extension ItunesList : Identifiable {

}
