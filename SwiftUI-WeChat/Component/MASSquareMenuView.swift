//
//  MASSquareMenuView.swift
//  SwiftUI-WeChat
//
//  Created by dy on 2020/2/9.
//  Copyright © 2020 Gesen. All rights reserved.
//

import SwiftUI

struct MASSquareMenuCell<Content: View>: View {
    var itemName: String
    var itemImageName: String
    var content: () -> Content
    
    var body: some View {
        NavigationLink(destination: content()) {
            HStack {
                // 限定 `Image`
                HStack {
                    Image(systemName: itemImageName)
                        .imageScale(.medium)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20))
                }
                    .frame(width: 50)

                Text(itemName)

                Spacer()
            }
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .frame(width: 130)
        }
    }
}

struct MASSquareMenuView<Content: View>: View {
    
    @Binding var isShow: Bool
    var content: () -> Content
    
    
    var body: some View {
        GeometryReader { _ in
            // 顶部箭头
            Image(systemName: "triangle.fill")
                .padding(EdgeInsets(top: 5, leading: 25, bottom: 0, trailing: 0))
            
            VStack(alignment: .leading) {
                self.content()
            }
                .background(Color.black)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            
            Spacer()
        }
            .background(Color.white.opacity(0.01))
            .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
            .onTapGesture {
                self.isShow.toggle()
            }
    }
}

//struct MASSquareMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MASSquareMenuView(isShow: <#Binding<Bool>#>)
//    }
//}

struct ExampleMenuView: View {
    
    @Binding var isShow: Bool
    
    var body: some View {
        MASSquareMenuView(isShow: $isShow) {
            Group {
                ForEach(0..<4, id: \.self) { index in
                    MASSquareMenuCell(itemName: "笔记\(index)",
                    itemImageName: "square.and.pencil") {
                        SearchView()
                    }
                }
            }
        }
    }
}
