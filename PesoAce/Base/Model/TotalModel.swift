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

class wallpaperModel: HandyJSON {
    required init() {}
    var lurch: String?
    var remem: String?
    var minarets: String?
    var tha: thaModel?
    var jokingly: jokinglyModel?
    var cleaner: [cleanerModel]?
}

class cleanerModel: HandyJSON {
    required init() {}
    var biryani: String?
    var wordlessly: String?
    var pooling: String?
    var oozed: String?
    var thwiiiiit: String?//跳转地址
}

class jokinglyModel: HandyJSON {
    required init() {}
    var outgrown: String?
}

class thaModel: HandyJSON {
    required init() {}
    var vacuumed: String?
    var improvement: [improvementModel]?
}

class improvementModel: HandyJSON {
    required init() {}
    var bellyaches: String? //产品ID
}
