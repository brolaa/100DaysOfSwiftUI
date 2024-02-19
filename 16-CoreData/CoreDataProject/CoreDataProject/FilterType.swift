//
//  filterType.swift
//  CoreDataProject
//
//  Created by Bartosz Rola on 01/03/2023.
//

import Foundation

enum FilterType: String, CaseIterable {
    case lessThen = "<"
    case moreThen = ">"
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case endsWith = "ENDSWITH"
}
