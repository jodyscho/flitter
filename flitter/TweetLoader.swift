//
//  TweetLoader.swift
//  flitter
//

import Foundation

class TweetLoader {
    
    func load(resourceName: String, withExtension ext: String) -> [Tweet]? {
        guard let oldTweets = Bundle.main.url(forResource: resourceName, withExtension: ext) else {
            return nil
        }
        
        let jsonData = NSData(contentsOf: oldTweets)
        
        do {
            guard let jsonObjects = try JSONSerialization.jsonObject(with: jsonData as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:AnyObject]] else {
                return nil
            }
            
            return jsonObjects.map { Tweet(value: $0) }

        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
