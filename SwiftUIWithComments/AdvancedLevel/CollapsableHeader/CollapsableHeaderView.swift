//
//  CollapsableHeaderView.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 25/9/23.
//
// origin: https://youtu.be/hmifqxD7seI?si=xX4NTyKyl77hNn-o


import SwiftUI

struct CollapsableHeaderView<Header: View, SmallHeader: View, Content: View>: View {
    
    @State private var offset: CGFloat
    
    let coordinateSpaceName: String
    var info: CollapsableHeaderInfo
    
    @ViewBuilder private var header: () -> Header
    @ViewBuilder private var smallHeader: () -> SmallHeader
    @ViewBuilder private var content: () -> Content

    init(
        info: CollapsableHeaderInfo,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder smallHeader: @escaping () -> SmallHeader,
        @ViewBuilder content: @escaping () -> Content,
        offset: CGFloat = 0,
        coordinateSpaceName: String = "getoffset"
    ) {
        self.info = info
        self.header = header
        self.smallHeader = smallHeader
        self.content = content
        self._offset = State(wrappedValue: offset)
        self.coordinateSpaceName = coordinateSpaceName
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: info.spacing) {
                GeometryReader { proxy in
                    header()
                        .frame(maxWidth: .infinity)
                        .frame(
                            height: getHeaderHeight(),
                            alignment: .bottom
                        )
                        .opacity(getHeaderExpandedOpacity())
                        .background(
                            info.backgroundHaeaderExpanded
                            , in: CustomCorner(
                                corners: info.cornerRadius.corners,
                                radius: getCornerRadius()
                            )
                        )
                        .overlay(
                            smallHeader()
                                .padding(.horizontal)
                                .frame(height: info.heightSmallHeader)
                                .padding(.top, info.safeAreaTop)
                                .opacity(getHeaderSmallOpacity())
                            , alignment: .top
                        )
                }
                .frame(height: info.heightHeaderExpanded)
                .offset(y: -offset)
                .zIndex(1)
                
               content()
                    .zIndex(0)
                
            }
            .modifier(OffsetModifier(offset: $offset, named: coordinateSpaceName))
        }
        .coordinateSpace(name: coordinateSpaceName)
        .ignoresSafeArea(.all, edges: .top)
    }
}

extension CollapsableHeaderView {
    
    func getHeaderHeight() -> CGFloat {
        let headerHeight = info.heightHeaderExpanded + offset
        return headerHeight > (info.heightSmallHeader + info.safeAreaTop) ? headerHeight : (info.heightSmallHeader + info.safeAreaTop)
    }
    
    func getHeaderExpandedOpacity() -> CGFloat {
        let progress = -offset / info.scrollNecessaryUntilTheEffectStart
        let opacity = 1 - progress
        return offset < 0 ? opacity : 1
    }
    
    func getHeaderSmallOpacity() -> CGFloat {
        let opacity = -(offset + info.scrollNecessaryUntilTheEffectStart) / (info.heightHeaderExpanded - (info.heightSmallHeader + info.safeAreaTop))
        return opacity
    }
    
    func getCornerRadius() -> CGFloat {
        let progress = -offset / (info.heightHeaderExpanded - (info.heightSmallHeader + info.safeAreaTop))
        let value = 1 - progress
        let radius = value * info.cornerRadius.radius
        return offset < 0 ? radius : info.cornerRadius.radius
    }
}

/*
    Some notes:
 
        .offset(y: -offset)
        ---> fixed view at top, prevents the view from "taking off" from the top
 
         .frame(
             height: info.heightHeaderExpanded + offset,
             alignment: .bottom
         )
        ---> sticky effect, expands the height of the view if we try to "stretch" it downwards
        
*/
