//
//  PLABaseConfig.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import Foundation
import UIKit
import Lottie
import BRPickerView

let regular_font = "MADETommySoft"
let black_font = "MADETommySoft-Black"

extension Double {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension Int {
    func px() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func minus() -> CGFloat{
        return 0 - self
    }
}

extension Data {
    static func compressImageQuality(image: UIImage, maxLength: Int) -> Data? {
        var compression: CGFloat = 0.75
        var data = image.jpegData(compressionQuality: compression)
        if let imageData = data, imageData.count < maxLength {
            return data
        }
        var max: CGFloat = 0.9
        var min: CGFloat = 0.0
        for _ in 0..<5 {
            compression = (max + min) / 2
            if let imageData = image.jpegData(compressionQuality: compression) {
                if imageData.count < Int(Double(maxLength) * 0.8) {
                    min = compression
                } else if imageData.count > maxLength {
                    max = compression
                } else {
                    break
                }
                data = imageData
            }
        }
        return data
    }
}

extension String {
    
    func convertBase64(_ dict: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            let base64EncodedString = jsonData.base64EncodedString()
            return base64EncodedString
        } catch {
            print("Error: \(error)")
            return nil
        }
    }

}

extension UILabel {
    static func createLabel(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.backgroundColor = UIColor.clear
        label.textColor = textColor
        label.font = font
        return label
    }
}

extension UIColor {
    convenience init(css: String) {
        var hexString: String = css.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            self.init(white: 0.0, alpha: 0.0)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class PlaHudView: UIView {
    
    lazy var hudView: LottieAnimationView = {
        let hudView = LottieAnimationView(name: "loading.json", bundle: Bundle.main)
        hudView.animationSpeed = 0.8
        hudView.loopMode = .loop
        hudView.play()
        hudView.layer.cornerRadius = 15.px()
        hudView.backgroundColor = .white.withAlphaComponent(0.85)
        return hudView
    }()
    
    lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(grayView)
        grayView.addSubview(hudView)
        hudView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 90.px(), height: 90.px()))
        }
        grayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class ViewHud {
    
    static let loadView = PlaHudView()
    
    static func hideLoadView() {
        DispatchQueue.main.async {
            loadView.removeFromSuperview()
        }
    }
    
    static func addLoadView() {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                DispatchQueue.main.async {
                    loadView.frame = keyWindow.bounds
                    keyWindow.addSubview(loadView)
                }
            }
        }
    }
    
}

class DeviceStatusHeightManager {
    
    static var statusBarHeight:CGFloat {
        var height: CGFloat = 20.0;
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window!!
            height = window.safeAreaInsets.top
        }
        return height
    }
    
    static var navigationBarHeight:CGFloat {
        var navBarHeight: CGFloat = 64.0;
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window!!
            let safeTop = window.safeAreaInsets.top
            navBarHeight = safeTop > 0 ? (safeTop + 44) : 44
        }
        return navBarHeight
    }
    
    static var safeAreaBottomHeight:CGFloat {
        var safeHeight: CGFloat = 0;
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window!!
            safeHeight = window.safeAreaInsets.bottom
        }
        return safeHeight
    }
    
    static var tabBarHeight: CGFloat {
        return 49 + safeAreaBottomHeight
    }
}


class enmuModel {
    static func enumOneArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
        return dataSourceArr.compactMap { item in
            guard let proviceDic = item as? significantModel else { return nil }
            let proviceModel = BRProvinceModel()
            proviceModel.name = proviceDic.asthma
            proviceModel.code = proviceDic.vacuumed
            proviceModel.index = dataSourceArr.firstIndex { $0 as AnyObject === proviceDic as AnyObject } ?? 0
            
            return proviceModel
        }
    }
}

class dateModel {
    static func geterjiArr(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var tempArr1 = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? significantModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.name = proviceDic.asthma
            proviceModel.code = proviceDic.vacuumed
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.significant ?? proviceDic.significant ?? []
            var tempArr2 = [BRCityModel]()
            for cityDic in cityList {
                let cityModel = BRCityModel()
                cityModel.code = cityDic.vacuumed
                cityModel.name = cityDic.asthma
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.significant ?? cityDic.significant ?? []
                var tempArr3 = [BRAreaModel]()
                for areaDic in areaList {
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.vacuumed
                    areaModel.name = areaDic.asthma
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    tempArr3.append(areaModel)
                }
                cityModel.arealist = tempArr3
                tempArr2.append(cityModel)
            }
            proviceModel.citylist = tempArr2
            tempArr1.append(proviceModel)
        }
        return tempArr1
    }
}

class CityXuanZe {
    static func cityModelArray(dataSourceArr: [Any]) -> [BRProvinceModel] {
        var tempArr1 = [BRProvinceModel]()
        for proviceDic in dataSourceArr {
            guard let proviceDic = proviceDic as? cleanerModel else {
                continue
            }
            let proviceModel = BRProvinceModel()
            proviceModel.code = proviceDic.bellyaches
            proviceModel.name = proviceDic.asthma
            proviceModel.index = dataSourceArr.firstIndex(where: { $0 as AnyObject === proviceDic as AnyObject }) ?? 0
            let cityList = proviceDic.cleaner ?? proviceDic.cleaner ?? []
            var tempArr2 = [BRCityModel]()
            for cityDic in cityList {
                let cityModel = BRCityModel()
                cityModel.code = cityDic.bellyaches
                cityModel.name = cityDic.asthma
                cityModel.index = cityList.firstIndex(where: { $0 as AnyObject === cityDic as AnyObject }) ?? 0
                let areaList = cityDic.cleaner ?? cityDic.cleaner ?? []
                var tempArr3 = [BRAreaModel]()
                for areaDic in areaList {
                    let areaModel = BRAreaModel()
                    areaModel.code = areaDic.bellyaches
                    areaModel.name = areaDic.asthma
                    areaModel.index = areaList.firstIndex(where: { $0 as AnyObject === areaDic as AnyObject }) ?? 0
                    tempArr3.append(areaModel)
                }
                cityModel.arealist = tempArr3
                tempArr2.append(cityModel)
            }
            proviceModel.citylist = tempArr2
            tempArr1.append(proviceModel)
        }
        return tempArr1
    }
}

class EXButton: UIButton {
    var hitTestEdgeInsets: UIEdgeInsets = .zero
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let extendedRect = self.bounds.inset(by: hitTestEdgeInsets)
        return extendedRect.contains(point) ? self : nil
    }
}
