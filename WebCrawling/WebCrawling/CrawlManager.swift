import Foundation
import SwiftSoup
import Alamofire

let url: String = "https://okky.kr/articles/community"

//Make a request to the URL and fetch HTML sources
func fetchHTML() {
    AF.request(url).responseString { response in
        guard let html = response.value else {
            return
        }
        
        var lines: [[String]] = [] //2D Array as a data set
        
        //Get data by parsing the HTML Source
        do {
            let doc: Document = try SwiftSoup.parse(html)
            
            // #list-article > div.panel.panel-default.community-panel > ul > li:nth-child(1) > div.list-title-wrapper.clearfix > h5 > a
            let elements: Elements = try doc.select("#list-article > div.panel.panel-default.community-panel > ul > li > div.list-title-wrapper.clearfix")
            for element in elements {
                let id: String = try element.select("div.list-tag > span").text()
                let article: String = try element.select("h5 > a").text()
                
                //Each element of the array corresponds to a column of a data set
                let line: [String] = [id, article]
                lines.append(line)
            }
            print("\(lines)")
        } catch {
            print("Crawl Error: ", error)
        }
        
    }
    
    
}


