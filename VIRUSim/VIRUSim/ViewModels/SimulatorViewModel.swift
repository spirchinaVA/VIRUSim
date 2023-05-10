//
//  InputData.swift
//  VIRUSim
//
//  Created by Victoria Spirchina on 06.05.2023.
//

import Foundation
import SwiftUI


class SimulatorViewModel: ObservableObject {
    var data: InputData
    @Published var peopleState:[Bool] 
    @Published var sickPeople: Int = 0
    var timer: Timer.TimerPublisher
    
    var sickStat: [Int] = [0]

    
    init(groupSize: Int, infectionFactor: Int, time: Int) {
        data = InputData(groupSize: groupSize, infectionFactor: infectionFactor, time: time)
      
        self.peopleState = Array(repeating: false, count: groupSize)
        self.timer = Timer.publish(every: TimeInterval(time), on: .main, in: .common)
    }
    
   
    func setSettings(group: String, infFactor: String, t: String) {
        data.groupSize = Int(group) ?? 7
        data.infectionFactor = Int(infFactor) ?? 3
        data.time = Int(t) ?? 3
        peopleState = Array(repeating: false, count: data.groupSize)
        sickPeople = 0
        timer = Timer.publish(every: TimeInterval(data.time), on: .main, in: .common)
        sickStat = [0]
        
    }
    
    func infectPeopleAround(sickP: Int) {
        let count = Int.random(in: 0...data.infectionFactor)
        for _ in 0..<count {
            let left = sickP-data.infectionFactor > 0 ? sickP-data.infectionFactor : 0
            let right = sickP+data.infectionFactor < data.groupSize ? sickP+data.infectionFactor : data.groupSize - 1
            let person = Int.random(in: left...right)
            if !peopleState[abs(person)] {
                    withAnimation {
                        peopleState[abs(person)] = true
                        sickPeople += 1
                    }
            }
        }
    }
    
    func infectPerson(index: Int) {
        if !peopleState[index] {
                peopleState[index] = true
                sickPeople += 1
                infectPeopleAround(sickP: index)
        }
    }
    
    func spreadInfection() {
        var infectedIndexes = [Int]()
        for i in 0..<peopleState.count {
            if peopleState[i] {
                infectedIndexes.append(i)
            }
        }
        for i in infectedIndexes {
            infectPeopleAround(sickP: i)
        }
        sickStat.append(sickPeople)
    }
    
    func getTimeStat() -> [Int] {
        var arr = [Int]()
        var t = 0
        for i in 0..<sickStat.count {
            arr.append(t)
            t += data.time
        }
        return arr
    }
}
