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
            LogInfo("onNext \(element)", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }, onError: { error in
            LogError("onEror \(error.localizedDescription)", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }, onSubscribed: {
            LogInfo("onSubscribed", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }, onDispose: {
            LogInfo("onDispose", functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        })
    }
}
