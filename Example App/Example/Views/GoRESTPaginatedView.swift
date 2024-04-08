//
//  GoRESTPaginatedView.swift
//  NetworkingIdeas
//
//  Created by Zaid Rahhawi on 4/8/24.
//

import SwiftUI

struct GoRESTPaginatedView<Endpoint: GoRESTPaginatedEndpoint, Row: View>: View where Endpoint.Record: Identifiable {
    private let service = Service()
    
    let endpoint: (_ page: Int, _ query: String?) -> Endpoint
    @ViewBuilder var row: (Endpoint.Record) -> Row
    
    @State private var query: String = ""
    @State private var records: [Endpoint.Record] = []
    @State private var currentResponse: Endpoint.Response? = nil
    @State private var loadingState: LoadingState = .pending
    
    private enum LoadingState {
        case pending, loading, loaded
    }
    
    var body: some View {
        List {
            ForEach(records) { record in
                row(record)
                    .task {
                        if records.last?.id == record.id {
                            await loadNextPage()
                        }
                    }
            }
        }
        .searchable(text: $query)
        .onChange(of: query) {
            loadingState = .pending
        }
        .task(id: query) {
            await loadRecords()
        }
        .refreshable {
            await loadRecords()
        }
    }
    
    private func loadRecords() async {
        guard loadingState == .pending || loadingState == .loaded else {
            return
        }
        
        loadingState = .loading
        defer { loadingState = .loaded }
        
        let query = query.isEmpty ? nil : query
        let endpoint = endpoint(1, query)
        do {
            let response = try await service.load(endpoint)
            self.currentResponse = response
            self.records = response.records
        } catch {
            handle(error: error)
        }
    }
    
    private func loadNextPage() async {
        guard loadingState == .loaded else {
            return
        }
        
        guard let nextPage = currentResponse?.pagination.nextPage else {
            return
        }
        
        loadingState = .loading
        defer { loadingState = .loaded }
        
        let query = query.isEmpty ? nil : query
        let endpoint = endpoint(nextPage, query)
        do {
            let response = try await service.load(endpoint)
            self.currentResponse = response
            self.records.append(contentsOf: response.records)
        } catch {
            handle(error: error)
        }
    }
    
    private func handle(error: Error) {
        print(error)
    }
}
