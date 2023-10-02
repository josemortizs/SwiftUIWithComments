//
//  CollapsableHeaderInfo.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 2/10/23.
//

import SwiftUI

struct CornerRadiusInfo {
    /// Corners where to apply the radius: .bottomRight, .allCorners...
    var corners: UIRectCorner = []
    /// Amount of radius to apply to the corner
    var radius: CGFloat = 0
}

struct CollapsableHeaderInfo {
    /// Safe area in top edges
    var safeAreaTop: CGFloat
    /// Maximum height of fully expanded header
    var heightHeaderExpanded: CGFloat
    /// Height of small header
    var heightSmallHeader: CGFloat
    /// Background color for the expanded header view
    var backgroundHaeaderExpanded: Color
    /// Spacing to be applied to vertical stacks
    var spacing: CGFloat
    /// Corner info
    var cornerRadius: CornerRadiusInfo
    /// Vertical scroll necessary until the effect starts
    var scrollNecessaryUntilTheEffectStart: CGFloat
}
