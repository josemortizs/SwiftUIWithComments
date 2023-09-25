//
//  CollapsableHeaderView.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 25/9/23.
//

import SwiftUI

struct CollapsableHeaderInfo {
    /// Maximum height of fully expanded header
    var heightHeaderExpanded: CGFloat
    /// Background color for the expanded header view
    var backgroundHaeaderExpanded: Color
    /// Spacing to be applied to vertical stacks
    var spacing: CGFloat
}

struct CollapsableHeaderView: View {
    
    var info: CollapsableHeaderInfo
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: info.spacing) {
                GeometryReader { proxy in
                    VStack(alignment: .leading, spacing: info.spacing) {
                        
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottom
                    )
                    .background(info.backgroundHaeaderExpanded)
                }
                .frame(height: info.heightHeaderExpanded)
            }
        }
    }
}

struct CollapsableHeaderView_Previews: PreviewProvider {
    
    static var heightHeaderExpanded = UIScreen.main.bounds.height / 2.5
    static var info = CollapsableHeaderInfo(
        heightHeaderExpanded: heightHeaderExpanded,
        backgroundHaeaderExpanded: .yellow,
        spacing: 15
    )
    
    static var previews: some View {
        CollapsableHeaderView(info: info)
    }
}
