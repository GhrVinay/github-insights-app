//
//  RepoListView.swift
//  GitHubInsightsApp
//
//  Created by GHR Vinay on 22/11/25.
//

import SwiftUI

struct RepoListView: View {
    @State var vm: RepoListVM
    let langOptions = ["Swift", "Java", "Python"]
    @State private var selectedLang = "Java"
    
    var body: some View {
        
        VStack {
            
            //MARK: - Content
            VStack {
                Picker("Select", selection: $selectedLang) {
                    ForEach(langOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.menu)
                
                //MARK: - Loader
                if vm.repoList.isEmpty {
                    HStack {
                        Text("fetching")
                        ProgressView()
                    }
                }
                
                List {
                    
                    ForEach(vm.repoList, id: \.self) { repo in
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("\(repo.name)").font(.headline)
                                Text("\(repo.owner)").font(.callout)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Label("\(repo.stars)", systemImage: "star.fill")
                                Text("stars").font(.footnote)
                            }
                        }
                    }
                    .listRowBackground(Color.red.opacity(0.1))
                }
                .clipShape(.rect(cornerRadius: 20))
                .listStyle(.plain)
            }
            .background(Color("DarkAccentColor"))
            
        }
        
        .task {
            await vm.loadRepos(lang: selectedLang)
        }
        .onChange(of: selectedLang, { _, newValue in
            Task {
                vm.repoList = []
                await vm.loadRepos(lang: newValue)
            }
        })
        .clipShape(.rect(cornerRadius: 20)).ignoresSafeArea(edges: .bottom)
        .background(Color("AccentColor"))
        .navigationTitle("Top 5 Trending Repos")
        .foregroundStyle(Color("AccentColor"))
    }
}

#Preview {
    NavigationStack {
        RepoListView(vm: RepoListVM(service: GitHubService()))
    }
    
}
