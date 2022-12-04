//
//  DataFetchPhase.swift
//  MovieCat
//
//  Created by kz on 04/12/2022.
//

import Foundation

enum DataFetchPhase<V> {
    
    case empty
    case success(V)
    case failure(Error)
    
    var value: V? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
}
