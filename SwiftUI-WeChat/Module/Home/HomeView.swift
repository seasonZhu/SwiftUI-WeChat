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
    
    @State var isPressAddButton = false
    
    @State var isShow = false
    
    @State var showRefreshView: Bool = false
    
    @State var pullStatus: CGFloat = 0
    
    var body: some View {
        NormalChatList(chats: $chats,
                       isPressAddButton: $isPressAddButton,
                       isShow: $isShow,
                       delete: delete(at:),
                       move: move(from:to:)
        )
        // 下面这个在真机上运行还是有问题
            
//        RefreshableChatList(chats: $chats,
//                            isPressAddButton: $isPressAddButton,
//                            showRefreshView: $showRefreshView,
//                            pullStatus: $pullStatus,
//                            delete: delete(at:),
//                            move: move(from:to:))
        .onAppear {
            self.rootSetting()
        }
    }
    
    private func rootSetting() {
        root.tabNavigationHidden = false
        root.tabNavigationTitle = "微信"
        root.tabNavigationBarTrailingItems = .init(AddIcon(isPressAddButton: $isPressAddButton))
        root.tabNavigationBarLeadingItems = .init(ShowButton(isShow: $isShow).foregroundColor(.black))
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

private struct NormalChatList: View {
    @Binding var chats: [Chat]
    
    @Binding var isPressAddButton: Bool
    
    @Binding var isShow: Bool
    
    let delete: (IndexSet) -> Void
    
    let move: (IndexSet, Int) -> Void
    
    var body: some View {
        List {
            Group {
                if self.isShow {
                    SearchEntryView()
                }

                ForEach(chats) { chat in
                    Cell(chat: chat)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .listRowInsets(.zero)
        }
    }
}

struct RefreshableChatList: View {
    @Binding var chats: [Chat]
    
    @Binding var isPressAddButton: Bool
    
    @Binding var showRefreshView: Bool
    
    @Binding var pullStatus: CGFloat
    
    let delete: (IndexSet) -> Void
    
    let move: (IndexSet, Int) -> Void
    
    var body: some View {
        RefreshableList(showRefreshView: $showRefreshView,
                        pullStatus: $pullStatus, action: {
            print(self.pullStatus)
        }, content: {
            Group {
                if self.isPressAddButton {
                    SearchEntryView()
                }

                ForEach(self.chats) { chat in
                    Cell(chat: chat)
                }
                .onDelete(perform: self.delete)
                .onMove(perform: self.move)
            }
            .listRowInsets(.zero)
        })
    }
}

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
    
    @Binding var isPressAddButton: Bool
    
    var body: some View {
        NavigationLink(destination: SearchView()) {
            Image(systemName: "plus.circle")
            .onTapGesture {
                self.isPressAddButton.toggle()
                print("点击了加号 \(self.isPressAddButton)")
            }
        }.foregroundColor(.black)

    }
}

struct ShowButton: View {
    @Binding var isShow: Bool
    
    var body: some View {
        Button(action: {
            self.isShow.toggle()
        }) {
            Image(systemName: self.isShow ? "magnifyingglass.circle.fill" : "magnifyingglass.circle")
        }
    }
}
