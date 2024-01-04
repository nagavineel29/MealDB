//
//  ImageLoader.swift
//  MealDB
//
//  Created by naga vineel golla on 1/3/24.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var error: NetworkError? = nil
    
    private static let cache = NSCache<NSString,UIImage>()
    
    func getImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            error  = NetworkError.badUrl
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        if let cachedImage = Self.cache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
        }
        
        URLSession.shared.getPublisher(urlRequest: urlRequest) {[weak self] result in
            switch result {
                
            case .success((let data, let httpResponse)):
                if httpResponse.statusCode == 200 {
                    
                    guard let image = UIImage(data: data) else {
                        DispatchQueue.main.async {
                            self?.error = NetworkError.NoData
                        }
                        return
                    }
                    
                    Self.cache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error
                }
            }
        }
    }
}
