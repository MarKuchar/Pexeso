//
//  timer.swift
//  Pexeso
//
//  Created by Andrea Dancek on 2020-05-28.
//

import Foundation
    

class TimerSample {

    var timer: Timer?

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self,
                                     selector: #selector(eventWith(timer:)),
                                     userInfo: [ "foo" : "bar" ],
                                     repeats: true)
    }

    // Timer expects @objc selector
    @objc func eventWith(timer: Timer!) {
        let info = timer.userInfo as Any
        print(info)
    }

}
