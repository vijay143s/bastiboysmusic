import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchResults: [Song] = []
    @Published var recentSearches: [String] = []
    @Published var availableYears: [Int] = []
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var hasMoreResults = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    private let recentSearchesKey = "recent_searches"
    private let maxRecentSearches = 10
    
    private var currentQuery = ""
    private var currentYear: Int?
    private var currentPage = 1
    private let pageLimit = 20
    
    func loadRecentSearches() {
        recentSearches = UserDefaults.standard.stringArray(forKey: recentSearchesKey) ?? []
    }
    
    func saveRecentSearch(_ query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return }
        
        // Remove if already exists
        recentSearches.removeAll { $0 == trimmedQuery }
        
        // Add to beginning
        recentSearches.insert(trimmedQuery, at: 0)
        
        // Limit to max count
        if recentSearches.count > maxRecentSearches {
            recentSearches = Array(recentSearches.prefix(maxRecentSearches))
        }
        
        UserDefaults.standard.set(recentSearches, forKey: recentSearchesKey)
    }
    
    func clearRecentSearches() {
        recentSearches = []
        UserDefaults.standard.removeObject(forKey: recentSearchesKey)
    }
    
    func loadAvailableYears() async {
        do {
            let queueData = try await networkService.getQueueData()
            availableYears = queueData.years
        } catch {
            print("Failed to load available years: \(error)")
        }
    }
    
    func searchSongs(query: String, year: Int? = nil) async {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return }
        
        currentQuery = trimmedQuery
        currentYear = year
        currentPage = 1
        
        isLoading = true
        errorMessage = nil
        
        do {
            let searchResponse = try await networkService.searchSongs(
                query: trimmedQuery,
                year: year,
                page: currentPage,
                limit: pageLimit
            )
            
            searchResults = searchResponse.songs
            hasMoreResults = searchResponse.hasMore
            
            // Save to recent searches
            saveRecentSearch(trimmedQuery)
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func loadMoreResults() async {
        guard hasMoreResults && !isLoadingMore && !currentQuery.isEmpty else { return }
        
        isLoadingMore = true
        currentPage += 1
        
        do {
            let searchResponse = try await networkService.searchSongs(
                query: currentQuery,
                year: currentYear,
                page: currentPage,
                limit: pageLimit
            )
            
            searchResults.append(contentsOf: searchResponse.songs)
            hasMoreResults = searchResponse.hasMore
            
            isLoadingMore = false
        } catch {
            errorMessage = error.localizedDescription
            isLoadingMore = false
            currentPage -= 1 // Revert page increment on error
        }
    }
    
    func clearSearch() {
        searchResults = []
        hasMoreResults = false
        currentQuery = ""
        currentYear = nil
        currentPage = 1
        errorMessage = nil
    }
}