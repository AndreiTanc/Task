//
//  PostCellView.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import SwiftUI

struct PostCellView: View {
    @State var post: Post
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text("Post title:")
                .fontWeight(.bold)
            Text(post.title ?? "")
                .multilineTextAlignment(.leading)
            
            if let userName = post.userName {
                Text("User name: ")
                    .fontWeight(.bold)
                Text(userName)
            }
        }
    }
}

struct PostCellView_Previews: PreviewProvider {
    static var previews: some View {
        PostCellView(post: .init())
    }
}
