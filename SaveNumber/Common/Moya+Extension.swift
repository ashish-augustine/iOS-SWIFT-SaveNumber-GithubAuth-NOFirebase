//
//  Moya+Extension.swift
//  SaveNumber
//
//  Created by Ashish Augustine on 2024/5/14.
//

import Foundation
import Moya

extension TargetType {
    var asMultiTarget: MultiTarget {
        return MultiTarget(self)
    }
}
