//
//  Logger.swift
//  MyApp
//
//  Created by Manh Pham on 3/12/20.
//

import Foundation
import XCGLogger

private let log = XCGLogger.default // swiftlint:disable:this prefixed_toplevel_constant

func LoggerSetup() {
    
    #if DEBUG
    let logLevel = XCGLogger.Level.debug
    #else
    let logLevel = XCGLogger.Level.none
    #endif
    
    log.setup(level: logLevel,
              showLogIdentifier: false,
              showFunctionName: true,
              showThreadName: false,
              showLevel: true,
              showFileNames: true,
              showLineNumbers: true,
              showDate: true,
              writeToFile: nil,
              fileLevel: nil)
    
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: " 🗯🗯🗯", to: .verbose)
    emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: " 🔹🔹🔹", to: .debug)
    emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: " ℹ️ℹ️ℹ️", to: .info)
    emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: " ⚠️⚠️⚠️", to: .warning)
    emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", postfix: " ‼️‼️‼️", to: .error)
    log.formatters = [emojiLogFormatter]
    
}

func LogVerbose(_ closure: @autoclosure @escaping () -> Any?,
                functionName: StaticString = #function,
                fileName: StaticString = #file,
                lineNumber: Int = #line,
                userInfo: [String: Any] = [:]) {
    log.logln(.verbose,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}
func LogDebug(_ closure: @autoclosure @escaping () -> Any?,
              functionName: StaticString = #function,
              fileName: StaticString = #file,
              lineNumber: Int = #line,
              userInfo: [String: Any] = [:]) {
    log.logln(.debug,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}
func LogInfo(_ closure: @autoclosure @escaping () -> Any?,
             functionName: StaticString = #function,
             fileName: StaticString = #file,
             lineNumber: Int = #line,
             userInfo: [String: Any] = [:]) {
    log.logln(.info,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}
func LogWarn(_ closure: @autoclosure @escaping () -> Any?,
             functionName: StaticString = #function,
             fileName: StaticString = #file,
             lineNumber: Int = #line,
             userInfo: [String: Any] = [:]) {
    log.logln(.warning,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}
func LogError(_ closure: @autoclosure @escaping () -> Any?,
              functionName: StaticString = #function,
              fileName: StaticString = #file,
              lineNumber: Int = #line,
              userInfo: [String: Any] = [:]) {
    log.logln(.error,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber,
              userInfo: userInfo,
              closure: closure)
}
