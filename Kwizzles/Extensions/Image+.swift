//
//  Image+.swift
//  Kwizzles
//
//  Created by Bill Polyzos on 9/11/22.
//

import SwiftUI
import Foundation


extension Image {
    init(_ asset: AssetsEnum) {
        self.init(asset.rawValue)
    }
}

extension UIImage {
    convenience init?(named asset: AssetsEnum) {
        self.init(named: asset.rawValue)
    }
    convenience init?(named asset: AssetsEnum, config: UIImage.SymbolConfiguration) {
        self.init(named: asset.rawValue, in: .main, with: config)
    }
}
