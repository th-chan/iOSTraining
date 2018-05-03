//
//  BookListAPI.swift
//  SearchBookApp
//
//  Created by Chan, Tsz Hin on 16/4/2018.
//  Copyright © 2018 temp. All rights reserved.
//

import Moya
import Foundation

enum BookListService {
    case searchBook(bookName: String)
}

extension BookListService: TargetType {
    public var baseURL: URL { return
        URL(string:"https://www.googleapis.com/")! }

    var path: String {
        switch self {
        case .searchBook(_):
            return "/books/v1/volumes"
        }
    }
    
    var method: Moya.Method {
        return Method.get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .searchBook(let bookName):
            return Task.requestParameters(parameters: [
                "q" : bookName
                , "key" : "AIzaSyDEexwCFapNU8UAUtpc9OqhaykNsIG-BSU"
                , "fields" : "items(volumeInfo(authors,averageRating,categories,description,imageLinks/thumbnail,language,pageCount,publishedDate,publisher,ratingsCount,subtitle,title))"
                ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
