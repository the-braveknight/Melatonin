//
//  PostRow.swift
//  Example
//
//  Created by Zaid Rahhawi on 22/06/2024.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    var body: some View {
        Text(post.title)
            .font(.headline)
    }
}
