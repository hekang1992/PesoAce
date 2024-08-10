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
    var orbital: String?
    var asthma: String?
    var liq: String?
    var fracture: String?
    var tha: thaModel?
    var jokingly: jokinglyModel?
    var cleaner: [cleanerModel]?
    var al: alModel?
    var lum: [lumModel]?
}

class lumModel: HandyJSON {
    required init() {}
    var faisal: String?
    var landlord: String?
    var greasy: String?//key
    var pendu: String?//type
    var shalwar: String?//回血
    var vacuumed: String?//回血key
    var significant: [significantModel]?
}

class significantModel: HandyJSON {
    required init() {}
    var asthma: String?
    var vacuumed: String?
}

class alModel: HandyJSON {
    required init() {}
    var rail: String?
    var minarets: String?
}

class cleanerModel: HandyJSON {
    required init() {}
    var bellyaches: String?
    var asthma: String?
    var pic_url: String?
    var biryani: String?
    var wordlessly: String?
    var pooling: String?
    var oozed: String?
    var thwiiiiit: String?//跳转地址
    var cleaner: [cleanerModel]?
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
