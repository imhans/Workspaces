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
    }
    
    //Get data by parsing the HTML Source
    do {
        
    }
}


