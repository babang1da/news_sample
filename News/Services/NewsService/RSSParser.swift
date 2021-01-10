//
//  RSSParser.swift
//  News
//
//  Created by Egor Oprea on 05.01.2021.
//

import Foundation

protocol IRSSParser: class {
    func startParsingWithContentsOfURL(rssURL: URL, completion: @escaping ([[String: String]]) -> Void)
}

final class RSSParser: NSObject, IRSSParser {
    private var currentElement = ""
    private var foundCharacters = ""
    private var currentData = [String: String]()
    private var parsedData = [[String: String]]()
    private var isHeader = true

    func startParsingWithContentsOfURL(rssURL: URL, completion: @escaping ([[String: String]]) -> Void) {
        let parser = XMLParser(contentsOf: rssURL)
        parser?.delegate = self
        if let _ = parser?.parse() {
            parsedData.append(currentData)
            completion(parsedData)
        }
    }
}

extension RSSParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
//        print(elementName)
        
        currentElement = elementName
        
        if currentElement == "item" || currentElement == "entry" {
            if !isHeader {
                parsedData.append(currentData)
            }
            isHeader = false
        }
        
        if !isHeader {
//            if
//                currentElement == "media:thumbnail" ||
//                currentElement == "media:content",
//                let chars = attributeDict["url"] {
//
//                foundCharacters += chars
//            }
            
//            if currentElement == "image", let chars = attributeDict["url"] {
//                foundCharacters += chars
//            }
            
            if currentElement == "enclosure", let chars = attributeDict["url"] {
                foundCharacters += chars
            }
        }
    }
    
    //keep relevant tag content
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !isHeader {
            if
                currentElement == "title" ||
                currentElement == "link" ||
                currentElement == "description" ||
                currentElement == "content" ||
                currentElement == "pubDate" ||
                currentElement == "author" ||
                currentElement == "enclosure" ||
                currentElement == "dc:creator" ||
                currentElement == "content:encoded" {
                
                foundCharacters += string
                foundCharacters = foundCharacters.deleteHTML()
            }
        }
    }
    
    //look at closing tag
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        
        if !foundCharacters.isEmpty {
            foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            currentData[currentElement] = foundCharacters
            foundCharacters = ""
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(#function)
    }
    
}
