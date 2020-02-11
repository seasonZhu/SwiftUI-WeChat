//
//  TextView.swift
//  SwiftUI-WeChat
//
//  Created by dy on 2020/2/9.
//  Copyright © 2020 Gesen. All rights reserved.
//


// import SwiftUI
// import UIKit
//
// struct TextView: UIViewRepresentable {
//    
//     @Binding var text: String
//
//     func makeCoordinator() -> Coordinator {
//         Coordinator(self)
//     }
//
//     func makeUIView(context: Context) -> UITextView {
//
//         let textView = UITextView()
//         textView.delegate = context.coordinator
//
//         textView.font = UIFont(name: "HelveticaNeue", size: 15)
//         textView.isScrollEnabled = true
//         textView.isEditable = true
//         textView.isUserInteractionEnabled = true
//         textView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)
//
//         return textView
//     }
//
//     func updateUIView(_ uiView: UITextView, context: Context) {
//         uiView.text = text
//     }
// }
//
//extension TextView {
//    class Coordinator : NSObject, UITextViewDelegate {
//
//        var parent: TextView
//
//        init(_ uiTextView: TextView) {
//            self.parent = uiTextView
//        }
//
//        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//            return true
//        }
//
//        func textViewDidChange(_ textView: UITextView) {
//            print("text now: \(String(describing: textView.text!))")
//            self.parent.text = textView.text
//        }
//    }
//}
