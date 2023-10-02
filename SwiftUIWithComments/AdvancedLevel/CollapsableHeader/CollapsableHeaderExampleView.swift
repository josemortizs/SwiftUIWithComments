//
//  CollapsableHeaderExampleView.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 2/10/23.
//

import SwiftUI

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
                ), scrollNecessaryUntilTheEffectStart: 70
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
