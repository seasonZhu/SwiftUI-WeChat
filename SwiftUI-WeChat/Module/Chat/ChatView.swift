//
//  ChatView.swift
//  SwiftUI-WeChat
//
//  Created by Gesen on 2019/8/11.
//  Copyright © 2019 Gesen. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("待开发")
                .padding()
            TextView(text: $text)
                .foregroundColor(.black)
                .font(.system(size: 28))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding()
        }.navigationBarTitle("聊天", displayMode: .inline)
        
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
#endif
