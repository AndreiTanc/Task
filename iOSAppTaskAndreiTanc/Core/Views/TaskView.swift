//
//  TaskView.swift
//  iOSAppTaskAndreiTanc
//
//  Created by Andrei Tanc on 08.12.2022.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject private(set) var viewModel: TaskViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                PostCellView(post: post)
            }
        }.refreshable {
            viewModel.refreshLogic()
        }.alert("Network connection error", isPresented: $viewModel.shouldPresentAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Retry", role: .none) {
                viewModel.refreshLogic()
            }
        }.onAppear {
            viewModel.getPosts()
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(viewModel: .mock)
    }
}
