//
//  ContentView.swift
//  GitHubInsightsApp
//
//  Created by GHR Vinay on 22/11/25.
//

import SwiftUI

struct ContentView: View {
    let options = ["Korea", "India", "England", "Taiwan"]
    @State var selections = Array(repeating: "Korea", count: 11)
    
    private func binding(for row: Int) -> Binding<String> {
            Binding<String>(
                get: { selections[row] },
                set: { selections[row] = $0 }
            )
        }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.red)
                
                Picker(selection: binding(for: 0)) {
                    ForEach(options, id: \.self) { Text("\($0)") }
                } label: {
                    Text("Label")
                }
                .tint(.red)
            }

            List {
                ForEach(0...10, id: \.self) { num in
                    Picker(selection: binding(for: num)) {
                        ForEach(options, id: \.self) { Text("\($0)") }
                    } label: {
                        Text("Label")
                    }
                    .tint(.red)
                }
                .listRowBackground(Color.clear)
                .listRowSeparatorTint(.red)
                .listStyle(.plain)
                
            }
            .scrollContentBackground(.hidden)
        }
        .customTable
        .navigationTitle("Hello")
        .background(.yellow)
        .task {
            selections = Array(repeating: options.first!, count: 11)
        }
        .onChange(of: selections) { old, new in
            print(selections)
        }
    }
}

#Preview {
    NavigationView {
        ContentView()
            .background(.red)
    }
}

struct CustomTableView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.green)
            .clipShape(.rect(cornerRadius: 30))
            .ignoresSafeArea(edges: .bottom)
            .border(.blue)
        
    }
}

extension View {
    var customTable: some View {
        self.modifier(CustomTableView())
    }
}
