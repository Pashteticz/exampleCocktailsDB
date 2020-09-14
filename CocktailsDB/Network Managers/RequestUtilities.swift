//
//  RequestUtilities.swift
//  CocktailsDB
//
//  Created by Pavel Okhrimenko on 13.09.2020.
//  Copyright © 2020 Pavel Okhrimenko. All rights reserved.
//

import Foundation
import UIKit

class RequestUtilities {
    
    // MARK: - ERRORS
    
    class func getEmptyError() -> NSError {
        let error = NSError(domain: BaseURL.domain, code: -3, userInfo: [NSLocalizedDescriptionKey: "Empty error"])
        return error
    }
    
    class func noInternetConnectionError() -> NSError {
        let error = NSError(domain: BaseURL.domain, code: -1, userInfo: [NSLocalizedDescriptionKey: "При загрузке данных произошла ошибка. Проверьте подключение устройства к интернету.".localized])
        return error
    }
}

