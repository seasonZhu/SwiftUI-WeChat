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
    
    @State var list: [TopicItem]?
    
    @State var isNetWorkSuccess = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("待开发")
                .padding()
            TextView(text: $text)
                .foregroundColor(.black)
                .font(.system(size: 28))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 44)
                .padding()
            
            if list != nil {
                List {
                    ForEach(list!, id: \.id) {
                        Text($0.topicTittle ?? "")
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("聊天", displayMode: .inline)
        .onAppear {
            //self.exampleApiRequest()
            self.viewModelRequest()
        }
        
    }
    
    func exampleApiRequest() {
        ExampleProvider.request(.topic) { (result) in
            switch result {
            case .success(let response):
                //let model = try? response.map(ExampleModel.self)
                //let listItems = try? response.map([ListItem].self, atKeyPath: ".list")
                self.list = try? response.map(Topic.self).list
                self.isNetWorkSuccess = true
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func viewModelRequest() {
        ViewModel.getTopics { (result) in
            switch result {
            case .success(let list):
                self.list = list
                self.isNetWorkSuccess = true
            case .error(let error):
                print(error)
            }
        }
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
#endif
