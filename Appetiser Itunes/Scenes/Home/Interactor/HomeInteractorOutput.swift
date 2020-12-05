//
//  HomeHomeInteractorOutput.swift
//  Appetiser Itunes
//
//  Created by Vince Santos on 12/5/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import Foundation

protocol HomeInteractorOutput: class {
    func setItunesList(list: [ItunesListModel], didUpdateIndex: Int)
}
