//
//  UrlBuilder.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 05.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

struct UrlBuilder {
    static func generateUrl(urlString: String, queryParameters: [String: String]) -> URL? {
        var mutUrlString = urlString + "?"
        for (key, value) in queryParameters {
            mutUrlString += (key + "=" + value)
            mutUrlString += "&"
        }
        mutUrlString.removeLast()
        return URL(string: mutUrlString)
    }
}
