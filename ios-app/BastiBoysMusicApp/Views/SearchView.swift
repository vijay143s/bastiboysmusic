import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    @State private var searchText = ""
    @State private var selectedYear: Int?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Header
                VStack(spacing: 16) {
                    SearchBar(text: $searchText, onSearchButtonClicked: {
                        Task {
                            await viewModel.searchSongs(query: searchText, year: selectedYear)
                        }
                    })
                    
                    // Year Filter (optional)
                    if !viewModel.availableYears.isEmpty {
                        YearFilterView(
                            years: viewModel.availableYears,
                            selectedYear: $selectedYear
                        ) { year in
                            selectedYear = year
                            if !searchText.isEmpty {
                                Task {
                                    await viewModel.searchSongs(query: searchText, year: year)
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGroupedBackground))
                
                // Search Results
                if viewModel.isLoading {
                    LoadingView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.searchResults.isEmpty && !searchText.isEmpty {
                    EmptySearchView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.searchResults.isEmpty {
                    RecentSearchesView(viewModel: viewModel) { query in
                        searchText = query
                        Task {
                            await viewModel.searchSongs(query: query, year: selectedYear)
                        }
                    }
                } else {
                    SearchResultsList(
                        songs: viewModel.searchResults,
                        hasMore: viewModel.hasMoreResults,
                        isLoadingMore: viewModel.isLoadingMore
                    ) { song in
                        audioPlayerManager.playSong(song, in: viewModel.searchResults)
                    } loadMore: {
                        Task {
                            await viewModel.loadMoreResults()
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            viewModel.loadRecentSearches()
            Task {
                await viewModel.loadAvailableYears()
            }
        }
        .onChange(of: searchText) { newValue in
            if newValue.isEmpty {
                viewModel.clearSearch()
            }
        }
    }
}

// MARK: - Search Bar
struct SearchBar: View {
    @Binding var text: String
    let onSearchButtonClicked: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search songs, albums, artists...", text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onSubmit {
                        onSearchButtonClicked()
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray5))
            .cornerRadius(10)
            
            if !text.isEmpty {
                Button("Search", action: onSearchButtonClicked)
                    .foregroundColor(.blue)
            }
        }
    }
}

// MARK: - Year Filter
struct YearFilterView: View {
    let years: [Int]
    @Binding var selectedYear: Int?
    let onYearSelected: (Int?) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // All Years option
                YearFilterChip(
                    title: "All",
                    isSelected: selectedYear == nil
                ) {
                    onYearSelected(nil)
                }
                
                ForEach(years.sorted(by: >), id: \.self) { year in
                    YearFilterChip(
                        title: "\(year)",
                        isSelected: selectedYear == year
                    ) {
                        onYearSelected(year)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct YearFilterChip: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Search Results List
struct SearchResultsList: View {
    let songs: [Song]
    let hasMore: Bool
    let isLoadingMore: Bool
    let onSongTap: (Song) -> Void
    let loadMore: () -> Void
    
    var body: some View {
        List {
            ForEach(songs) { song in
                SongRowView(song: song) {
                    onSongTap(song)
                }
                .onAppear {
                    if song.id == songs.last?.id && hasMore && !isLoadingMore {
                        loadMore()
                    }
                }
            }
            
            if isLoadingMore {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .padding()
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - Song Row
struct SongRowView: View {
    let song: Song
    let onTap: () -> Void
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Thumbnail
                AsyncImage(url: URL(string: song.thumbnailUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            Image(systemName: "music.note")
                                .foregroundColor(.gray)
                        )
                }
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // Song Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(song.title)
                        .font(.headline)
                        .lineLimit(1)
                        .foregroundColor(.primary)
                    
                    HStack {
                        if let singer = song.singer {
                            Text(singer)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        if let year = song.year {
                            Text("• \(year)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if let albumTitle = song.albumTitle {
                        Text(albumTitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                // Play indicator
                if audioPlayerManager.currentSong?.id == song.id {
                    Image(systemName: audioPlayerManager.isPlaying ? "speaker.wave.2.fill" : "speaker.fill")
                        .foregroundColor(.blue)
                        .font(.caption)
                }
                
                // More options
                Button(action: {
                    // Show song options
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Empty States
struct EmptySearchView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No results found")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Try searching with different keywords or check your spelling")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

struct RecentSearchesView: View {
    @ObservedObject var viewModel: SearchViewModel
    let onSearchTap: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if !viewModel.recentSearches.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Recent Searches")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        Button("Clear") {
                            viewModel.clearRecentSearches()
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                    }
                    
                    ForEach(viewModel.recentSearches, id: \.self) { search in
                        Button(action: {
                            onSearchTap(search)
                        }) {
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(.gray)
                                
                                Text(search)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            // Popular searches or suggestions could go here
            VStack(alignment: .leading, spacing: 12) {
                Text("Browse by Category")
                    .font(.headline)
                    .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                    CategoryCard(title: "Top Hits", icon: "chart.line.uptrend.xyaxis") {
                        onSearchTap("top")
                    }
                    
                    CategoryCard(title: "Latest Songs", icon: "music.note.list") {
                        onSearchTap("latest")
                    }
                    
                    CategoryCard(title: "Bollywood", icon: "heart.fill") {
                        onSearchTap("bollywood")
                    }
                    
                    CategoryCard(title: "Classical", icon: "theatermasks") {
                        onSearchTap("classical")
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
    }
}

struct CategoryCard: View {
    let title: String
    let icon: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            
            Text("Searching...")
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(AudioPlayerManager.shared)
}