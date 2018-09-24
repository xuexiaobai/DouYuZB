//
//  NetworkHelper.swift
//  DouYuZB
//
//  Created by 薛同飞 on 2018/9/24.
//  Copyright © 2018年 RunStyle. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkHelper {
    class func requestData(type : MethodType, urlString : String, params : [String : NSString]? = nil, finishCallback : @escaping (_ result : AnyObject) -> ()) {
        //1.获取请求类型
        let method = type == MethodType.GET ? HTTPMethod.get : HTTPMethod.post
        //2.发起网络请求
        Alamofire.request(urlString, method: method, parameters: params).responseJSON { (response) in
            //3.得到返回结果
            guard let result = response.result.value else {
                print(response.error as AnyObject)
                return
            }
            //4.回调网络结果
            finishCallback(result as AnyObject)
        }
    }
}





















