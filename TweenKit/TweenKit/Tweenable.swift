//
//  Tweenable.swift
//  TweenKit
//
//  Created by Steve Barnegren on 17/03/2017.
//  Copyright © 2017 Steve Barnegren. All rights reserved.
//

import Foundation

public protocol Tweenable {
    func lerp(t: Double, end: Self) -> Self
}
