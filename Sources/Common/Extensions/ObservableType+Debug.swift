//
//  ObservableType+Debug.swift
//  MyApp
//
//  Created by Manh Pham on 7/8/21.
//

import Foundation

extension ObservableType {
    func debugToFile(fileName: StaticString = #file, lineNumber: Int = #line, functionName: StaticString = #function) -> Observable<Element> {
        return self.do(onNext: { element in
            if Configs.shared.loggingToFileEnabled {
                LogInfo("onNext \(element)", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
            }
        }, onError: { error in
            if Configs.shared.loggingToFileEnabled {
                LogError("onError \(error.localizedDescription)", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
            }
        }, onSubscribed: {
            if Configs.shared.loggingToFileEnabled {
                LogInfo("onSubscribed", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
            }
        }, onDispose: {
            if Configs.shared.loggingToFileEnabled {
                LogInfo("onDispose", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
            }
        })
    }
}
