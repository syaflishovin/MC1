//
//  Recommendation.swift
//  Mini1
//
//  Created by Jeremy Raymond on 30/04/23.
//

import Foundation

class Recommendation: ObservableObject {
    var dict: [Date: Journal] = [:]
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    @Published var moodCounts: [String: Int] = [:]
    @Published var feelingCounts: [Feeling: Int] = [:]
    
    func getDate(dict: [Date: Journal]) {
        self.dict = dict
        // Calculate the start and end dates of the current week
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
        print("start: \(startOfWeek)")
        print("end: \(endOfWeek)")

        // Loop through your dictionary to retrieve the values for each date within the current week
        var moodArray: [String] = []
        var feelingArray: [Feeling] = []
        
        for date in dict.keys {
            print("loop")
            print(date)
            if date >= startOfWeek && date < endOfWeek {
                print("special date: \(date)")
                var mood = dict[date]?.wrappedMood
                moodArray.append(mood ?? "Mood")
                
                var feelings = (dict[date]?.feelingArray)!
                feelingArray += feelings
            }
        }
        moodCounts = moodArray.reduce(into: [:]) { moodCounts, word in
            moodCounts[word, default: 0] += 1
        }
        feelingCounts = feelingArray.reduce(into: [:]) { feelingCounts, feeling in
            feelingCounts[feeling, default: 0] += 1
        }
        print(moodCounts)
        print(feelingCounts)
    }
    
}
