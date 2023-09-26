//
//  CollapsableHeaderView.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 25/9/23.
//
// origin: https://youtu.be/hmifqxD7seI?si=QAx_8QOlGBiNU70j&t=123
// origin: https://youtu.be/hmifqxD7seI?si=68FKU81ExVMxhQuL&t=194


import SwiftUI

struct CollapsableHeaderInfo {
    /// Safe area in top edges
    var safeAreaTop: CGFloat
    /// Maximum height of fully expanded header
    var heightHeaderExpanded: CGFloat
    /// Background color for the expanded header view
    var backgroundHaeaderExpanded: Color
    /// Spacing to be applied to vertical stacks
    var spacing: CGFloat
}

struct CollapsableHeaderView<Header: View>: View {
    
    var info: CollapsableHeaderInfo
    
    @ViewBuilder private var header: () -> Header
    
    init(
        info: CollapsableHeaderInfo,
        @ViewBuilder header: @escaping () -> Header
    ) {
        self.info = info
        self.header = header
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: info.spacing) {
                GeometryReader { proxy in
                    header()
                        .foregroundColor(info.backgroundHaeaderExpanded)
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
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct CollapsableHeaderExampleView: View {
    
    let spacingVStackHeader: CGFloat = 15
    
    var body: some View {
        GeometryReader { proxy in
            
            let heightHeaderExpanded = UIScreen.main.bounds.height / 2.5
            let info = CollapsableHeaderInfo(
                safeAreaTop: proxy.safeAreaInsets.top,
                heightHeaderExpanded: heightHeaderExpanded,
                backgroundHaeaderExpanded: .yellow,
                spacing: spacingVStackHeader)
            
            CollapsableHeaderView(info: info) {
                headerExpandedView
            }
        }
    }
    
    var headerExpandedView: some View {
        VStack(alignment: .leading, spacing: spacingVStackHeader) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(20)
            
            Text("Swift")
                .font(.largeTitle.bold())
            
            Text("Swift es un lenguaje de programación multiparadigma creado por Apple enfocado en el desarrollo de aplicaciones para iOS y macOS. Fue presentado en la WWDC 2014")
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.8))
        }
    }
}

struct CollapsableHeaderExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CollapsableHeaderExampleView()
    }
}
