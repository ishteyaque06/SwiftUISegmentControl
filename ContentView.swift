//
//  ContentView.swift
//  SwiftUISegementControl
//
//  Created by Ishteyaque Ahmad on 18/09/2026.
//

import SwiftUI

// MARK: - Models & Data

enum Category: String, CaseIterable, Identifiable {
    case general = "General"
    case media = "Media"
    case settings = "Settings"
    
    var id: String { self.rawValue }
}

struct Item: Identifiable {
    let id: Int
    let title: String
}

// MARK: - Main View

struct ContentView: View {
    @State private var selectedCategory: Category = .general
    
    // Track the top visible item ID for each segment to persist scroll position
    @State private var scrollPositions: [Category: Int] = [
        .general: 0,
        .media: 0,
        .settings: 0
    ]
    
    // Sample datasets for each tab
    private let items: [Category: [Item]] = [
        .general: (0..<50).map { Item(id: $0, title: "General Item #\($0)") },
        .media: (0..<50).map { Item(id: $0, title: "Media Item #\($0)") },
        .settings: (0..<50).map { Item(id: $0, title: "Settings Option #\($0)") }
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Segmented Control Picker
                Picker("Category", selection: $selectedCategory) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                // List View with Scroll Position Preservation
                ScrollViewReader { proxy in
                    List(items[selectedCategory] ?? []) { item in
                        Text(item.title)
                            .padding(.vertical, 8)
                            .id(item.id)
                            .onAppear {
                                // Continuously track the top-most visible index per segment
                                scrollPositions[selectedCategory] = item.id
                            }
                    }
                    .listStyle(.plain)
                    .onChange(of: selectedCategory) { newCategory in
                        // Restore saved scroll position when switching tabs
                        if let savedID = scrollPositions[newCategory] {
                            proxy.scrollTo(savedID, anchor: .top)
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
