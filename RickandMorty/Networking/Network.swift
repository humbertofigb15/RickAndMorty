//
//  Network.swift
//  
//

import Foundation
import Network

// MARK: - APIError
enum APIError: LocalizedError, Equatable {
    case offline
    case invalidURL
    case badStatus(Int)
    case decoding
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .offline: return "No connection. Please try again."
        case .invalidURL: return "Invalid URL."
        case .badStatus(let code): return "Request failed with status \(code)."
        case .decoding: return "Could not parse server response."
        case .unknown(let message): return message
        }
    }
}

// MARK: - RMAPI  (https://rickandmortyapi.com/)
struct RMAPI {
    private let base = "https://rickandmortyapi.com/api"
    private let session: URLSession

    init(session: URLSession = .shared) { self.session = session }

    func fetchCharacters(page: Int? = nil) async throws -> PagedResponse<RMCharacter> {
        var comps = URLComponents(string: "\(base)/character")
        if let page = page { comps?.queryItems = [.init(name: "page", value: String(page))] }
        guard let url = comps?.url else { throw APIError.invalidURL }
        return try await request(url)
    }

    func fetchCharacter(id: Int) async throws -> RMCharacter {
        guard let url = URL(string: "\(base)/character/\(id)") else { throw APIError.invalidURL }
        return try await request(url)
    }

    private func request<T: Decodable>(_ url: URL) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse else { throw APIError.unknown("No HTTP response.") }
            guard (200..<300).contains(http.statusCode) else { throw APIError.badStatus(http.statusCode) }
            do { return try JSONDecoder().decode(T.self, from: data) }
            catch { throw APIError.decoding }
        } catch let err as URLError {
            if err.code == .notConnectedToInternet { throw APIError.offline }
            throw APIError.unknown(err.localizedDescription)
        } catch {
            throw APIError.unknown(error.localizedDescription)
        }
    }
}

// MARK: - NetworkMonitor
final class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    @Published var isOffline: Bool = false

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async { self?.isOffline = (path.status != .satisfied) }
        }
        monitor.start(queue: queue)
    }
}

