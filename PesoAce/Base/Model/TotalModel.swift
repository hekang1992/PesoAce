//
//  TotalModel.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import Foundation
import HandyJSON


class BaseModel: HandyJSON {
    required init() {}
    var greasy: Int?
    var formica: String?
    var wallpaper: [String: Any]?
}
