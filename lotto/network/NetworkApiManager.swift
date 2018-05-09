//
//  NetworkApiManager.swift
//  lotto
//
//  Created by teruten on 2018. 5. 4..
//  Copyright © 2018년 Dev. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class NetworkApiManager {
    
    var url: String
    let method: HTTPMethod
    var parameters: Parameters
    
    private let server = "http://122.199.199.157:8080/intranet"
    private let server1 = "https://mb22.mailplug.co.kr/lw_api"
    private let listServer = "http://jh3.pantople.com:8081/here/"
    
    let naverOpenApiURL = "https://openapi.naver.com/"
    let naverOpenApiAccept = "*/*"
    let naverOpenApiClientID = "OzH2fEjvDcanOaAwe4Ky"
    let naverOpenApiClientSecret = "2Ij44MmNKR"
    static let naverOpenApiImageDisplayCount = 20
    static let naverOpenApiBlogDisplayCount = 100
    
    let naverImageHeaders: HTTPHeaders = [
        "Accept": "*/*",
        "X-Naver-Client-Id": "OzH2fEjvDcanOaAwe4Ky",
        "X-Naver-Client-Secret": "2Ij44MmNKR"
    ]
    
    init(isNaver: Bool, path: String, method: String, parameters: Parameters = [:]) {
        
        if isNaver{
            url = naverOpenApiURL + path
        }else{
            url = listServer + path
        }
        
        url = path
        
        var httpMethod : HTTPMethod = .get;
        
        if method == "post" {
            httpMethod = HTTPMethod.post;
        }
        
        self.method = httpMethod
        self.parameters = parameters
    }
    
    func requestLottoQrCode(parameter:Parameters, success: @escaping(_ data: String)-> Void, fail: @escaping (_ error: Error?)-> Void) {
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameter).response { response in
            
            
            print("statusCode : \(response.response?.statusCode)")
            print("result : \(String(data: response.data!, encoding: String.Encoding.utf8))")
            
//            if response.response.re {
//                //let result = JSON(response.result.value)
//
//                print("requestDetailItem start")
//                let responsData = response.result.value
//
//                //let cafeteriaResponse = Mapper<CafeteriaResponse>().map(JSONString: response.result.value!)
//
//                print("request result : \(responsData)")
//
//                if responsData == nil{
//                    fail(response.result.error)
//                }else{
//                    success(responsData!)
//                }
//            } else {
//                fail(response.result.error)
//            }
        }
    }
    
    func requestLottoQrCode1(success: @escaping(_ data: String)-> Void, fail: @escaping (_ error: Error?)-> Void) {
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters).responseString { response in
            
                        if response.result.isSuccess {
                            //let result = JSON(response.result.value)
            
                            print("requestDetailItem start")
                            let responsData = response.result.value
            
                            //let cafeteriaResponse = Mapper<CafeteriaResponse>().map(JSONString: response.result.value!)
            
                            //print("request result : \(responsData)")
                            print("")
                            print("")
                            if responsData == nil{
                                fail(response.result.error)
                            }else{
                                success(responsData!)
                            }
                        } else {
                            fail(response.result.error)
                        }
        }
    }
//
//    func requestNaverImages(parameter:Parameters, success: @escaping(_ data: NaverImages)-> Void, fail: @escaping (_ error: Error?)-> Void) {
//        Alamofire.request(url, method: HTTPMethod.get, parameters: parameter, headers: naverImageHeaders).responseString { response in
//            if response.result.isSuccess {
//                //let result = JSON(response.result.value)
//
//                print("requestNaverImages start")
//                let images = NaverImages(JSONString: response.result.value!)
//
//                print("request lastBuildDate : \(images?.lastBuildDate)")
//                print("request list count : \(images?.items?.count)")
//
//                if images?.items == nil{
//                    fail(response.result.error)
//                }else{
//                    success(images!)
//                }
//            } else {
//                fail(response.result.error)
//            }
//        }
//    }
//
//    func requestNaverBlogs(parameter:Parameters, success: @escaping(_ data: NaverBlogs)-> Void, fail: @escaping (_ error: Error?)-> Void) {
//        Alamofire.request(url, method: HTTPMethod.get, parameters: parameter, headers: naverImageHeaders).responseString { response in
//            if response.result.isSuccess {
//                //let result = JSON(response.result.value)
//
//                print("requestNaverBlogs start")
//                let blogs = NaverBlogs(JSONString: response.result.value!)
//
//                print("request lastBuildDate : \(blogs?.lastBuildDate)")
//                print("request list count : \(blogs?.items?.count)")
//
//                if blogs?.items == nil{
//                    fail(response.result.error)
//                }else{
//                    success(blogs!)
//                }
//            } else {
//                fail(response.result.error)
//            }
//        }
//    }
//
//    func requestList(parameter:Parameters, success: @escaping(_ data: ResponseList)-> Void, fail: @escaping (_ error: Error?)-> Void) {
//        Alamofire.request(url, method: HTTPMethod.get, parameters: parameter).responseString { response in
//            if response.result.isSuccess {
//                //let result = JSON(response.result.value)
//
//                let resList = ResponseList(JSONString: response.result.value!)
//
//                print("request list result : \(resList?.result)")
//                print("request list result : \(resList?.items?.count)")
//
//                if resList == nil{
//                    fail(response.result.error)
//                }else{
//                    success(resList!)
//                }
//            } else {
//                fail(response.result.error)
//            }
//        }
//    }
}
