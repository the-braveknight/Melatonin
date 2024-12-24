//
//  PostRow.swift
//  Example
//
//  Created by Zaid Rahhawi on 22/06/2024.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    @State var isExpanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            Text(post.body)
        } label: {
            Text(post.title)
                .font(.headline)
        }
    }
}
