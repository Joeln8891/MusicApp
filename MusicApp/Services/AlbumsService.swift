//
//  AlbumsService.swift
//  MusicApp
//
//  Created by Joel on 8/17/20.
//  Copyright © 2020 Joel. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

let albumUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"

enum ServiceError: Error {
    case DecodingError(String)
}

class ServiceManager {
    
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getTopAlbums(url: String = albumUrl, completion: @escaping (AlbumFeed?, Error?) -> Void) {
        guard let url = URL(string: url)
            else { fatalError() }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            //Note - we can add lot more checks in here to see if the response has proper status codes. I am not doing any of those because the api is a simple json.
            guard let data = data,
                let albumResults = try? JSONDecoder().decode(AlbumFeed.self, from: data) else {
                    completion(nil, ServiceError.DecodingError("Unable to Decode response"))
                    return
            }
            completion(albumResults, nil)
        }.resume()
    }
}
