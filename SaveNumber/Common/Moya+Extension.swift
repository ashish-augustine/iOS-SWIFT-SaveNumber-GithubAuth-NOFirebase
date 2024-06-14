//
//  Moya+Extension.swift
//  SaveNumber
//
//  Created by Benjamin Wong on 2024/5/14.
//

import Foundation
import Moya

extension TargetType {
    var asMultiTarget: MultiTarget {
        return MultiTarget(self)
    }
}
