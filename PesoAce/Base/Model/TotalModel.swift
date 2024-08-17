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
    var spotless: thaModel?
    var fast_list: thaModel?
    var jokingly: jokinglyModel?
    var cleaner: [cleanerModel]?
    var al: alModel?
    var lum: [lumModel]?
    var burns: burnsmodel?
    var conscience: conscienceModel?
}

class conscienceModel: HandyJSON {
    required init() {}
    var safely: String?
}

class burnsmodel: HandyJSON {
    required init() {}
    var cleaner: [cleanerModel]?
}

class lumModel: HandyJSON {
    required init() {}
    var faisal: String?
    var landlord: String?
    var greasy: String?//key
    var pendu: String?//type
    var shalwar: String?//回血
    var injuries: String?
    var vacuumed: String?//回血key
    var significant: [significantModel]?
    var lum: [lumModel]?
}

class significantModel: HandyJSON {
    required init() {}
    var asthma: String?
    var vacuumed: String?
    var ponytail: String?
    var significant: [significantModel]?
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
    var escapes: String?
    var pic_url: String?
    var biryani: String?
    var wordlessly: String?
    var pooling: String?
    var oozed: String?
    var thwiiiiit: String?//跳转地址
    var plastics: String?
    var riches: String?
    var bubbling: String?
    var cleaner: [cleanerModel]?
    var pakols: [significantModel]?
    var millah: String?
    var improvement: [improvementModel]?
}

class jokinglyModel: HandyJSON {
    required init() {}
    var outgrown: String?
    var process: String?
}

class thaModel: HandyJSON {
    required init() {}
    var vacuumed: String?
    var improvement: [improvementModel]?
}

class improvementModel: HandyJSON {
    required init() {}
    var bellyaches: String? //产品ID
    var margalla: String?//pic url
    var minarets: String?//peourl
    var mysel: String?
    var paws: String?
    var wheeled: String?
    var productTags: String?
    var amountMax: String?
    var loanTermText: String?
    var loan_rate: String?
    var plans: String?
    var buttonStatus: String?
    var podge: String?//kahao
    var repeating: String?//bank name
    var signaling: String?//select
}
