//
//  XZTargetType.swift
//  MortgageCalculator-Swift
//
//  Created by gozap on 2017/9/18.
//  Copyright © 2017年 com.longdai. All rights reserved.
//

import UIKit
import Moya

protocol XZTargetType: TargetType {}

extension XZTargetType {
    var baseURL: URL {
        return URL(string: "http://xw.qq.com")!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .request
    }
    
    static var networkActivityPlugin: PluginType {
        return NetworkActivityPlugin(networkActivityClosure: {(change: NetworkActivityChangeType) in
            switch change {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
    }
    
    static func endpointClosure<T:TargetType>(_ target: T) -> Endpoint<T>{
        let defaultEndpoint = MoyaProvider<T>.defaultEndpointMapping(for: target)
        
        //API请求 默认携带的参数
//        var version = "0.0.0"
//        if let infoDict = Bundle.main.infoDictionary {
//            if let appVersion = infoDict["CFBundleShortVersionString"] as? String {
//                version = appVersion
//            }
//        }
//        var defaultParameters: [String : Any] = ["deviceId": UDID.udid,
//                                                 "source": APP_KEY_iPhone,
//                                                 "version":version]
//
//        if User.shared.isLogin {
//            defaultParameters["access_token"] = APP_KEY_iPhone + User.shared.accessToken
//        }
        
        return defaultEndpoint
    }
 
    static var provider: RxMoyaProvider<Self> {
        return RxMoyaProvider<Self>(endpointClosure: endpointClosure , plugins: [networkActivityPlugin])
    }
}
