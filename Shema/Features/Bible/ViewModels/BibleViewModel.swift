//
//  BibleLockViewModel.swift
//  Shema
//
//  Created by Benson Arafat on 10/10/2025.
//

import Foundation
import Combine

class BibleViewModel: ObservableObject {
    @Published var languages: [Language] = []
    @Published var translations: [Translation] = []
    @Published var books: [Book] = []
    @Published var verses: [Verse] = []
    @Published var selectedTranslation: String = "KJV"
    @Published var selectedBook: Book?
    @Published var selectedChapter: Int = 1
    @Published var isLoading = false
    @Published var error: String?
    @Published var downloadedTranslations: Set<String> = []
    @Published var downloadingTranslations: Set<String> = []
    
    private let apiService: BibleServiceProtocol
    private let storageService = BibleStorageService.shared
    private let parser = BibleReferenceParser.shared
    private var cancellables = Set<AnyCancellable>()
    
    private var translationKey = "translationKey"
    
    init (apiService: BibleServiceProtocol = BibleService.shared) {
        self.apiService = apiService
        downloadedTranslations = Set(storageService.getDownloadedTransations())
        self.selectedTranslation = UserDefaults.standard.string(forKey: translationKey) ?? "KJV"
    }
    
    func loadInitialData() {
        isLoading = true
        error = nil
        let translationDownloaded = isDownloaded(selectedTranslation)
        if translationDownloaded {
            storageService.loadOfflineBook()
                .receive(on: DispatchQueue.main)
                .flatMap { [weak self] books -> AnyPublisher<[Verse], BibleAPIError> in
                    guard let self = self else {
                        return Fail(error: BibleAPIError.noData).eraseToAnyPublisher()
                    }
                    self.books = books
                
                    self.selectedBook = books.first { $0.bookid == 1} ?? books.first
                    self.selectedChapter = 1
                    
                    guard let book = self.selectedBook else {
                        return Fail(error: BibleAPIError.noData).eraseToAnyPublisher()
                    }
                    
                    return self.storageService.loadOfflineVerses(translation: selectedTranslation, book: book.bookid, chapter: 1)
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let err) = completion {
                        self?.error = err.localizedDescription
                    }
                } receiveValue: { [weak self] verses in
                    self?.verses = verses
                    self?.error = nil
                }
                .store(in: &cancellables)
    
        }else {
            storageService.loadOfflineBook()
                .receive(on: DispatchQueue.main)
                .flatMap { [weak self] books -> AnyPublisher<[Verse], BibleAPIError> in
            
                    guard let self = self else {
                        return Fail(error: BibleAPIError.noData).eraseToAnyPublisher()
                    }
                    self.books = books
                    self.selectedBook = books.first { $0.bookid == 1} ?? books.first
                    self.selectedChapter = 1
                   
                    guard let book = self.selectedBook else {
                        return Fail(error: BibleAPIError.noData).eraseToAnyPublisher()
                    }
                    
                    return self.apiService.fetchChapter(translation: self.selectedTranslation, book: book.bookid, chapter: 1)
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let err) = completion {
                        self?.error = err.localizedDescription
                    }
                } receiveValue: { [weak self] verses in
                    self?.verses = verses
                    self?.error = nil
                }
                .store(in: &cancellables)
        }
    }
    
    func loadLanguages() {
        isLoading = true
        apiService.fetchLanguages()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let err) = completion {
                    self?.error = err.localizedDescription
                }
            } receiveValue: { [weak self] languages in
                guard let self = self else { return }
                self.languages = languages
                if let english = languages.first(where: { $0.language == "English" }) {
                    // using this constants "bibleTransalations" allow only this translations for now
                    let englishTranslations = english.translations
                    let filteredTranslations = englishTranslations.filter { tran in
                        bibleTransalations.contains(tran.shortName)
                    }
                    self.translations = filteredTranslations
                } else {
                    self.translations = []
                }
            }
            .store(in: &cancellables)
    }
    
    func loadBooks() {
        isLoading = true
        
        storageService.loadOfflineBook()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let err) = completion {
                    self?.error = err.localizedDescription
                }
            } receiveValue: { [weak self] books in
                self?.books = books
                self?.selectedBook = books.first
            }
            .store(in: &cancellables)

    }
    
    func loadChapter() {

        guard let book = selectedBook else { return }
        isLoading = true
        
        let publisher: AnyPublisher<[Verse], BibleAPIError>
        
        if storageService.isDownloaded(selectedTranslation) {
            publisher = storageService.loadOfflineVerses(translation: selectedTranslation, book: book.bookid, chapter: selectedChapter)
        }else {
            publisher = apiService.fetchChapter(translation: selectedTranslation, book: book.bookid, chapter: selectedChapter)
        }
        
        publisher.receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure (let err) = completion {
                    self?.error = err.localizedDescription
                }
            } receiveValue: { [weak self] verse in
                self?.verses = verse
            }
            .store(in: &cancellables)
    }
    
    func navigateToReference(_ input: String) {
        guard let ref = parser.parse(input, defaultTranslation: selectedTranslation) else {
            error = "Invalid reference format"
            return
        }
        
        selectedTranslation = ref.translation
        isLoading = true
        
        if storageService.isDownloaded(self.selectedTranslation) {
            storageService.loadOfflineBook()
                .receive(on: DispatchQueue.main)
                .flatMap { [weak self] books -> AnyPublisher<[Verse], BibleAPIError> in
                    guard let self = self else {
                        return Fail(error: BibleAPIError.noData).eraseToAnyPublisher()
                    }
                    self.books = books
                    self.selectedBook = books.first { $0.bookid == ref.book }
                    self.selectedChapter = ref.chapter
                    
                    guard let book = self.selectedBook else {
                        return Fail(error: BibleAPIError.noData).eraseToAnyPublisher()
                    }
                    
                    return storageService.loadOfflineVerses(translation: self.selectedTranslation, book: book.bookid, chapter: ref.chapter)
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let err) = completion {
                        self?.error = err.localizedDescription
                    }
                } receiveValue: { [weak self] verses in
                    self?.verses = verses
                }
                .store(in: &cancellables)

        } else {
            storageService.loadOfflineBook()
                .receive(on: DispatchQueue.main)
                .flatMap{ [weak self] books -> AnyPublisher<[Verse], BibleAPIError> in
                    guard let self = self else {
                        return Fail(error: BibleAPIError.noData).eraseToAnyPublisher()
                    }
                    self.books = books
                    self.selectedBook = books.first { $0.bookid == ref.book }
                    self.selectedChapter = ref.chapter
                    
                    guard let book = self.selectedBook else {
                        return Fail(error: BibleAPIError.noData).eraseToAnyPublisher()
                    }
                    
                    return self.apiService.fetchChapter(translation: self.selectedTranslation, book: book.bookid, chapter: ref.chapter)
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let err) = completion {
                        self?.error = err.localizedDescription
                    }
                } receiveValue: { [weak self] verses in
                    self?.verses = verses
                }
                .store(in: &cancellables)
        }
        

    }
    
    func changeTranslation(_ translation: String) -> Void {
        selectedTranslation = translation;
        UserDefaults.standard.set(translation, forKey: translationKey)
        loadChapter()
    }
    
    func downloadTranslation(_ translation: String) {
        downloadingTranslations.insert(translation)
        apiService.downloadTransalation(translation)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.downloadingTranslations.remove(translation)
                if  case .failure (let err) = completion {
                    self?.error = err.localizedDescription
                }
            } receiveValue: { [weak self] _ in
                self?.downloadedTranslations.insert(translation)
            }
            .store(in: &cancellables)
    }
    
    func isDownloaded (_ translation: String) -> Bool {
        if storageService.isDownloaded(translation) {
            return true;
        } else {
            return false;
        }
    }
    
    func isDownloading(_ translation: String) -> Bool {
        return downloadingTranslations.contains(translation)
    }
    
    func deleteTranslation(_ translation: String) {
        try? storageService.deleteTranslation(translation)
        downloadedTranslations.remove(translation)
    }
    
    
    func loadTodaysReading () {
        
    }
    
    func startReading () {
        
    }
    
    func completeReading () {
        
    }
    
    func resetDaily() {
        
    }
    
    
}

