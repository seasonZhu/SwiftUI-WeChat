//
//  SceneDelegate.swift
//  SwiftUI-WeChat
//
//  Created by Gesen on 2019/7/14.
//  Copyright © 2019 Gesen. All rights reserved.
//

import UIKit
import SwiftUI
import Extension

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        configureAppearance()
        configureWindow(windowScene: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

private extension SceneDelegate {
    
    func configureAppearance() {
        
        // 因无法控制列表分割线，所以先去掉，全部由自己控制
        UITableView.appearance().separatorStyle = .none
        
        // 统一导航栏样式
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = UIColor(named: "light_gray")
        
        // 返回按钮的文字偏移量
        UIBarButtonItem.appearance()
            .setBackButtonTitlePositionAdjustment(
                UIOffset(horizontal: -CGFloat(Int.max), vertical: 0),
                for: .default)
        
        // 返回按钮的文字设置
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: -CGFloat(Int.max)),
             NSAttributedString.Key.foregroundColor: UIColor.clear],
            for: .normal)
        
        // 返回按钮的颜色
        UIBarButtonItem.appearance().tintColor = UIColor.black
    }
    
    func configureWindow(windowScene: UIWindowScene) {
        let rootView = RootView()
        
        window = UIWindow(windowScene: windowScene)
        window!.rootViewController = HostingController(rootView: rootView)
        window!.makeKeyAndVisible()
    }
    
}
