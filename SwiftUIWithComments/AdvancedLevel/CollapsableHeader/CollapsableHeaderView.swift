//
//  CollapsableHeaderView.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 25/9/23.
//
// origin: https://youtu.be/hmifqxD7seI?si=QAx_8QOlGBiNU70j&t=123
// origin: https://youtu.be/hmifqxD7seI?si=68FKU81ExVMxhQuL&t=194
// origin: https://youtu.be/hmifqxD7seI?si=kKe2uwSq8tSlU88X&t=481


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
}

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
                            height: info.heightHeaderExpanded + offset,
                            alignment: .bottom
                        )
                        .background(
                            info.backgroundHaeaderExpanded
                            , in: CustomCorner(
                                corners: info.cornerRadius.corners,
                                radius: info.cornerRadius.radius
                            )
                        )
                        .overlay(
                            smallHeader()
                                .padding(.horizontal)
                                .frame(height: info.heightSmallHeader + info.safeAreaTop)
                            , alignment: .top
                        )
                }
                .frame(height: info.heightHeaderExpanded)
                .offset(y: -offset)
                
               content()
                
            }
            .modifier(OffsetModifier(offset: $offset, named: coordinateSpaceName))
        }
        .coordinateSpace(name: coordinateSpaceName)
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct CollapsableHeaderExampleView: View {
    
    let spacingVStackHeader: CGFloat = 15
    
    var body: some View {
        GeometryReader { proxy in
            
            let heightHeaderExpanded = UIScreen.main.bounds.height / 2.8
            let info = CollapsableHeaderInfo(
                safeAreaTop: proxy.safeAreaInsets.top,
                heightHeaderExpanded: heightHeaderExpanded, 
                heightSmallHeader: 80,
                backgroundHaeaderExpanded: .yellow,
                spacing: spacingVStackHeader,
                cornerRadius: CornerRadiusInfo(
                    corners: [.bottomLeft, .bottomRight],
                    radius: 30
                )
            )
            
            CollapsableHeaderView(info: info) {
                headerExpandedView
            } smallHeader: {
                smallHeaderView
            } content: {
                contentView
            }

        }
    }
    
    var contentView: some View {
        VStack {
            ForEach(chaptersSwiftBook) { chapter in
                ChapterCardView(chapter: chapter)
            }
        }
        
    }
    
    var smallHeaderView: some View {
        HStack(alignment: .center) {
            Image("logo")
                .resizable()
                .frame(width: 36, height: 36)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
            
            Text("Swift, open source language")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
            
            Spacer()
        }
        .padding(.top)
    }
    
    var headerExpandedView: some View {
        VStack(alignment: .leading, spacing: spacingVStackHeader) {
            
            HStack(alignment: .center) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(20)
                Text("Swift")
                    .font(.largeTitle.bold())
                    .padding(.leading)
                Spacer()
            }

            Text("Swift es un lenguaje de programación multiparadigma creado por Apple enfocado en el desarrollo de aplicaciones para iOS y macOS. Fue presentado en la WWDC 2014")
                .fontWeight(.semibold)
                .foregroundColor(Color.white.opacity(0.8))
        }
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct CollapsableHeaderExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CollapsableHeaderExampleView()
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
