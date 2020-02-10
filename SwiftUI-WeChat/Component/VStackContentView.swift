//
//  VStackContentView.swift
//  SwiftUIPractise
//
//  Created by dy on 2020/2/3.
//  Copyright © 2020 season. All rights reserved.
//

import SwiftUI

struct VStackContentView: View {
    @State var name = ""
    
    @State var password = ""
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .foregroundColor(.orange)
                .bold()
                .font(.system(.largeTitle))
                .fontWeight(.medium)
                .italic()
                .shadow(color: .black, radius: 1, x: 0, y: 2)
            
            TextField("输入姓名", text: self.$name, onEditingChanged: { (isChange) in
                print("text is Change \(isChange) \(self.name)")
            }) {
                print("name: \(self.name)")
            }
            .padding(10)
            .frame(height: 44)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            SecureField("输入密码", text: $password) {
            }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            Image("Group")
            .resizable()
                .frame(width:100, height: 100, alignment: .bottomLeading)
            
            Button(action: {
                print("Tap")
            }) {
                HStack {
                    Image("Group")
                    .resizable()
                        .frame(width:10, height: 10, alignment: .bottomLeading)
                    
                   Text("It's a button")
                }
            }
            
            ZStack {
                Text("made in China.")
                Divider() // Just add a line.
                Text("the People's Republic Of China.")
            }
        }
    }
}

struct VStackContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStackContentView()
    }
}
