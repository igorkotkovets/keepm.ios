//
//  RxSwift+Extensions.swift
//  iOSApp
//
//  Created by Igor Kotkovets on 3/2/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift


public protocol OptionalType {
    associatedtype Wrapped

    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

// Unfortunately the extra type annotations are required, otherwise the compiler gives an incomprehensible error.
extension Observable where Element: OptionalType {
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}
