//
//  DispatchHandler.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 21.07.24.
//

import Foundation

public enum DispatchHandler {
    static func toMain(_ work: @escaping () -> Void) {
        if Thread.isMainThread { work() } else { DispatchQueue.main.async(execute: work) }
    }
}
