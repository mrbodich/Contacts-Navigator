//
//  ContentFetcher.swift
//  Contacts Navigator
//
//  Created by Bogdan Chornobryvets on 16.06.2021.
//

import Foundation

protocol ContentFetcher {
    func fetchContentList(_ completion: @escaping (_ content: [ContentModel]) -> ())
}
