//
//  Int+Extensions.swift
//

import Foundation

extension Int {

  var formattedSettingTime: String {
    let currentDate = Date()
    let settingDate = currentDate.addingTimeInterval(TimeInterval(self))
    
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    formatter.dateFormat = "HH:mm"
    
    let formattedTime = formatter.string(from: settingDate)
    return formattedTime
  }
}
