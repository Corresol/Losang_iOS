//
//  colors.swift
//  losangDemo
//
//  Created by SixSquarePC5 on 04/02/17.
//  Copyright © 2017 SixSquare Technologies. All rights reserved.
//

import Foundation
import UIKit
class colors {
    let colorTop = UIColor(red: 255.0/255.0, green: 181.0/255.0, blue: 192.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 239.0/255.0, green: 82.0/255.0, blue: 83.0/255.0, alpha: 1.0).cgColor
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
}
