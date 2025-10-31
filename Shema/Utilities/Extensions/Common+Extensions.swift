//
//  Common+Extensions.swift
//  Shema
//
//  Created by Benson Arafat on 08/10/2025.
//

import Foundation
import SwiftUI

extension Font {
    static func fontAntonRegular( size: CGFloat) -> Font {
        return .custom("Anton-Regular", size: size)
    }
    
    static func fontNotoSansRegular(size: CGFloat) -> Font {
        return .custom("NotoSansJP-Regular", size: size)
    }
    
    static func fontNotSansExtraLight(size: CGFloat) -> Font {
        return .custom("NotoSansJP-ExtraLight", size: size)
    }
    
    static func fontNotoSansThin(size: CGFloat) -> Font {
        return .custom("NotoSansJP-Thin", size: size);
    }
    
    static func fontNotoSansLight(size: CGFloat) -> Font {
        return .custom("NotoSansJP-Light", size: size)
    }
    
    static func fontNotoSansMedium(size: CGFloat) -> Font {
        return .custom("NotoSansJP-Medium", size: size);
    }
    
    static func fontNotoSansSemiBold(size: CGFloat) -> Font {
        return .custom("NotoSansJP-SemiBold", size: size);
    }
    
    static func fontNotoSansBold(size: CGFloat) -> Font {
        return .custom("NotoSansJP-Bold", size: size);
    }
    
    static func fontNotoSansExtraBold(size: CGFloat) -> Font {
        return .custom("NotoSansJP-ExtraBold", size: size);
    }
    
    static func fontNotoSansBlack(size: CGFloat) -> Font {
        return .custom("NotoSansJP-Black", size: size);
    }
}
