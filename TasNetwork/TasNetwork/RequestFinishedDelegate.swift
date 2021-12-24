//
//  RequestFinishedDelegate.swift
//  TasNetwork
//
//  Created by 박준현 on 2021/12/24.
//

import Foundation

public protocol RequestFinishedDelegate: AnyObject {
    func requestSucceed()
    func requestFailed()
}
