//
//  ProfileView.swift
//  SwiftUI-WeChat
//
//  Created by Gesen on 2019/11/29.
//  Copyright © 2019 Gesen. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        Text("待开发")
            .navigationBarTitle("哈哈")
            .navigationBarItems(leading:
                Button(action: {
                    print("点击了返回按钮")
                    // 如果不用系统的 我根本就不知道该怎么返回好不好!!!
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("back")
                    }
                }
            )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct CustomBar: View {
    var body: some View {
        Text("Hello world")
            .foregroundColor(.secondary)
            .font(.system(.largeTitle))
    }
}
