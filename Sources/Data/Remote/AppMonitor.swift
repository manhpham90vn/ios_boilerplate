//
//  AppMonitor.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire

final class AppMonitor: EventMonitor {
    
    let queue = DispatchQueue(label: "com.manhpham.networklogger")
    
    func requestDidResume(_ request: Request) {
    #if DEBUG
        print("requestDidResume \(Date()) \(request.id)")
    #endif
    }
    
    func requestDidFinish(_ request: Request) {
    #if DEBUG
        print("requestDidFinish \(Date()) \(request.id)")
    #endif
    }
    
    func requestDidCancel(_ request: Request) {
    #if DEBUG
        print("requestDidCancel \(Date()) \(request.id)")
    #endif
    }
    
    func requestDidSuspend(_ request: Request) {
    #if DEBUG
        print("requestDidSuspend \(Date()) \(request.id)")
    #endif
    }
    
    func requestIsRetrying(_ request: Request) {
    #if DEBUG
        print("requestIsRetrying \(Date()) \(request.id)")
    #endif
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    #if DEBUG
        if let value = response.value {
            print("didParseResponse \(Date()) \(request.id) \(response.metrics?.taskInterval.duration ?? 0) \(value)")
        }
    #endif
    }
}
