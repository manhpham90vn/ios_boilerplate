//
//  AppMonitor.swift
//  AlamofireFeatureTest
//
//  Created by Manh Pham on 6/19/22.
//

import Foundation
import Alamofire
import Configs
import Logs

final class AppMonitor: EventMonitor {
    
    let queue = DispatchQueue(label: "com.manhpham.networklogger")
    
    func requestDidResume(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestDidResume \(Date()) \(request.id)")
        }
    }
    
    func requestDidFinish(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestDidFinish \(Date()) \(request.id)")
        }
    }
    
    func requestDidCancel(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestDidCancel \(Date()) \(request.id)")
        }
    }
    
    func requestDidSuspend(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestDidSuspend \(Date()) \(request.id)")
        }
    }
    
    func requestIsRetrying(_ request: Request) {
        if Configs.shared.loggingAPIEnabled {
            LogInfo("requestIsRetrying \(Date()) \(request.id)")
        }
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        if Configs.shared.loggingAPIEnabled {
            if let value = response.value {
                LogInfo("didParseResponse \(Date()) \(request.id) \(response.metrics?.taskInterval.duration ?? 0) \(value)")
            }
        }
    }
}
