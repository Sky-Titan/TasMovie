//
//  CGFloat+.swift
//  TasUtility
//
//  Created by 박준현 on 2021/12/05.
//

import UIKit

public typealias Degrees = CGFloat
public typealias Radians = CGFloat

extension Degrees {
    public func toRadians() -> Radians {
        return self * (.pi / 180)
    }
}
extension Radians {
    public func toDegress() -> Degrees {
        return self * (180 / .pi)
    }
}
