

import Foundation
import os

// MARK: - Logger Manager
protocol LoggerManager {
    func log(type: LoggerType, category: LoggerCategory, message: String)
}

extension LoggerManager {
    func log(type: LoggerType, category: LoggerCategory, message: String) {
        
        guard let bundleIndentifier = Bundle.main.bundleIdentifier else { return }
        
        let categoryType = category.rawValue
        let logMessage = "\(categoryType): \(message)"
        let logger = Logger(subsystem: bundleIndentifier, category: categoryType)
        
        switch type {
        case .info:
            logger.info("\(logMessage)")
        case .debug:
            logger.debug("\(logMessage)")
        case .error:
            logger.error("\(logMessage)")
        case .fault:
            logger.fault("\(logMessage)")
        case .critical:
            logger.critical("\(logMessage)")
        case .notice:
            logger.notice("\(logMessage)")
        case .trace:
            logger.trace("\(logMessage)")
        }
    }
}

// MARK: - Logger Type
enum LoggerType {
    case info, debug, error, fault, critical, notice, trace
}

// MARK: - Logger Category
enum LoggerCategory: String {
    case network
}
