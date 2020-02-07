//
//  HomeView.swift
//  SwiftUI-WeChat
//
//  Created by Gesen on 2019/7/20.
//  Copyright © 2019 Gesen. All rights reserved.
//

import SwiftUI

struct HomeView : View {
    @State var chats: [Chat] = mock(name: "chats")
    
    var body: some View {
        List {
            Group {
                SearchEntryView()
                ForEach(chats) { chat in
                    Cell(chat: chat)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .listRowInsets(.zero)
        }
        .onAppear {
            self.root.tabNavigationHidden = false
            self.root.tabNavigationTitle = "微信"
            self.root.tabNavigationBarTrailingItems = .init(AddIcon())
            self.root.tabNavigationBarLeadingItems = .init(EditButton())
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            chats.remove(at: index)
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        var removeChats: [Chat] = []
        
        for index in source {
            removeChats.append(chats[index])
            chats.remove(at: index)
        }
        
        chats.insert(contentsOf: removeChats, at: destination)
    }
    
    @EnvironmentObject var root: RootViewModel
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RootViewModel())
    }
}
#endif

private struct Cell: View {
    let chat: Chat
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(chat.icon)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(8)

                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .top) {
                        Text(chat.name)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                        Spacer()
                        Text(chat.time)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }

                    Text(chat.desc)
                        .lineLimit(1)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                }
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            
            Separator().padding(.leading, 76)
        }
        .navigationLink(destination: ChatView())
    }
}

struct AddIcon: View {
    var body: some View {
        NavigationLink(destination: SearchView()) {
            Image(systemName: "plus.circle")
            .onTapGesture {
                    print("点击了加号")
            }
        }.foregroundColor(.black)

    }
}
