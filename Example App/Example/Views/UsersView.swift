//
//  UsersView.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/7/24.
//

import SwiftUI

struct UserRow: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.circle")
                .font(.title)
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                
                Text(user.email)
                    .font(.subheadline)
            }
        }
    }
}

struct UsersView: View {    
    var body: some View {
        GoRESTPaginatedView { page, query in
            UsersEndpoint(page: page, recordsPerPage: 20, name: query)
        } row: { user in
            UserRow(user: user)
        }
        .navigationTitle("Users")
    }
}

#Preview {
    NavigationStack {
        UsersView()
    }
}
