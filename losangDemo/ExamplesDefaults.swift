//
//  ExamplesDefaults.swift
//  Charts
//
//  Created by solsixsquare
//  Copyright (c) All rights reserved.
//

import UIKit
import SwiftCharts

struct ExamplesDefaults {
    
    static var chartSettings: ChartSettings {
        if Env.iPad {
            return iPadChartSettings
        } else {
            return iPhoneChartSettings
        }
    }

    static var chartSettingsWithPanZoom: ChartSettings {
        if Env.iPad {
            return iPadChartSettingsWithPanZoom
        } else {
            return iPhoneChartSettingsWithPanZoom
        }
    }
    
    fileprivate static var iPadChartSettings: ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 20
        chartSettings.top = 20
        chartSettings.trailing = 20
        chartSettings.bottom = 20
        chartSettings.labelsToAxisSpacingX = 10
        chartSettings.labelsToAxisSpacingY = 10
        chartSettings.axisTitleLabelsToLabelsSpacing = 5
        chartSettings.axisStrokeWidth = 1
        chartSettings.spacingBetweenAxesX = 15
        chartSettings.spacingBetweenAxesY = 15
        chartSettings.labelsSpacing = 0
        return chartSettings
    }
    
    fileprivate static var iPhoneChartSettings: ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        chartSettings.labelsSpacing = 0
        return chartSettings
    }

    fileprivate static var iPadChartSettingsWithPanZoom: ChartSettings {
        var chartSettings = iPadChartSettings
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        return chartSettings
    }

    fileprivate static var iPhoneChartSettingsWithPanZoom: ChartSettings {
        var chartSettings = iPhoneChartSettings
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        return chartSettings
    }
    
    static func chartFrame(_ containerBounds: CGRect) -> CGRect {
        let screenWidth : Int = UserDefaults.standard.value(forKey: "screenW") as! Int
      //  return CGRect(x: 0, y: 70, width: containerBounds.size.width, height: containerBounds.size.height - 70)
     //    return CGRect(x: 50, y: 100, width: 500, height: 350)
        print(screenWidth)
        if screenWidth >= 414 && screenWidth < 768
        {
        return CGRect(x: containerBounds.origin.x, y: (containerBounds.origin.y + (containerBounds.size.height)-5), width: containerBounds.size.width-20, height: containerBounds.size.height+100 )
        }
        else if screenWidth >= 768
        {
                    return CGRect(x: containerBounds.origin.x, y: (containerBounds.origin.y + (containerBounds.size.height)-80), width: containerBounds.size.width-10, height: containerBounds.size.height+100 )
       // return CGRect(x: containerBounds.origin.x, y: (containerBounds.origin.y + (containerBounds.size.height)-30), width: containerBounds.size.width, height: containerBounds.size.height )
        }
        else if screenWidth >= 375 && screenWidth < 414
        {
            return CGRect(x: containerBounds.origin.x - 5 , y: (containerBounds.origin.y + (containerBounds.size.height)-0), width: containerBounds.size.width-15, height: containerBounds.size.height+100 )
            
        }
        else
        {
            return CGRect(x: containerBounds.origin.x - 10, y: (containerBounds.origin.y + (containerBounds.size.height)-0), width: containerBounds.size.width-50, height: containerBounds.size.height+100 )
            
        }
    }
    
    static var labelSettings: ChartLabelSettings {
        return ChartLabelSettings(font: ExamplesDefaults.labelFont)
    }
    
    static var labelFont: UIFont {
        return ExamplesDefaults.fontWithSize(Env.iPad ? 14 : 11)
    }
    
    static var labelFontSmall: UIFont {
        return ExamplesDefaults.fontWithSize(Env.iPad ? 12 : 10)
    }
    
    static func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static var guidelinesWidth: CGFloat {
        return Env.iPad ? 0.5 : 0.1
    }
    
    static var minBarSpacing: CGFloat {
        return Env.iPad ? 10 : 5
    }
    
}
