//
//  ExampleAPI.swift
//  SwiftUI-WeChat
//
//  Created by dy on 2020/2/10.
//  Copyright © 2020 Gesen. All rights reserved.
//

import Foundation
import Moya

//MARK:- API
let ExampleProvider = MoyaProvider<ExampleAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])

enum ExampleAPI {
    case topic
}

extension ExampleAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://sun.topray-media.cn")!
    }
    
    var path: String {
        switch self {
        case .topic:
            return "/tz_inf/api/topics"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .topic:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var parmeters: [String:Any] = [:]
        switch self {
        case .topic:
            parmeters = [:]
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}

//MARK:- API对应的模型
struct ExampleModel: Codable {
    var list: [ListItem]?
    var code: Int?
}

struct ListItem: Codable {
    var topicOrder: Int?
    var id: Int?
    var topicDesc: String?
    var topicTittle: String?
    var upTime: String?
    var topicImageUrl: String?
    var topicStatus: Int?
}

//MARK:- API对应的ObservableObject模型
class Topic: ObservableObject, Codable {
    var list: [TopicItem]?
    var code: Int?
}

class TopicItem: ObservableObject, Codable {
    var topicOrder: Int?
    var id: Int?
    var topicDesc: String?
    var topicTittle: String?
    var upTime: String?
    var topicImageUrl: String?
    var topicStatus: Int?
}

//MARK:- 封装请求结果与其回调
enum ResponseResult<T: Codable, E: Error> {
    case success(T?)
    case failure(E)
}

typealias ResponseResultCallback<T: Codable, E: Error> = (ResponseResult<T, E>) -> Void

//MARK:- ViewModel
class ViewModel {
    
    static func getTopics(callback: @escaping ResponseResultCallback<[TopicItem], MoyaError>) {
        ExampleProvider.request(.topic) { (result) in
            switch result {
            case .success(let response):
                let list = try? response.map(Topic.self).list
                callback(.success(list))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
