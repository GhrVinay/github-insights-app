# Requirement

1. Create a single screen which lets user input a language and show a list of top 5 github repos
2. User input can be from a dropdown of languages
3. As soon as a lang is selected the list is populated
4. Each row in list shows the name of the repo, owner, no. of stars
5. Use this api to fetch the list : https://api.github.com/search/repositories?q=language:swift&sort=stars

Technical
1. Separation of concerns for files
2. Follow SOLID principles
3. Clean error handling 
4. Write Unit tests

# Code organisation

## Data Model
1. RepositoriesResponse - Repo List
2. RepoDetail - Repo name, Repo Owner, stars
Note: Parse the whole resp and take in only what is required

## Service
1. GitHubService - fetchRepositories(lang: String)
Note: async, throws

## View Model
1. RepoListVM - getRepoList(lang), maintain data in state var: RepoList


## View
1. RepoListView - show the list with name, owner, stars


## Shared
