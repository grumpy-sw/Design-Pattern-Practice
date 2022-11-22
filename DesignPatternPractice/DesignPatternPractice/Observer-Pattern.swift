//
//  Observer-Pattern.swift
//  DesignPatternPractice
//
//  Created by 박세웅 on 2022/11/21.
//

import Foundation

// Subject가 채택해야 하는 프로토콜 정의
// Subject는 관찰 대상이기 때문에 Observable을 채택한다.
fileprivate protocol Observable {
    func add(_ follower: Follower)
    func remove(_ follower: Follower)
    func notify(_ message: String)
}

// Observer가 채택하는 프로토콜 정의
fileprivate protocol Followable {
    func update(_ message: String)
}

// Subject가 될 Creator 클래스
// 자신의 구독자들인 followers에게 notify를 보낸다.
fileprivate class Creator: Observable {
    let name: String
    var followers: [Follower] = []
    
    init(name: String) {
        self.name = name
    }
    
    func add(_ follower: Follower) {
        self.followers.append(follower)
    }
    
    func remove(_ follower: Follower) {
        guard let index = followers.firstIndex(where: {
            $0 === follower
        }) else {
            return
        }
        self.followers.remove(at: index)
    }
    
    func notify(_ message: String) {
        for follower in followers {
            follower.update("\(name) 채널에 \(message)가 업로드됨")
        }
    }
}

// Observer인 Follower 클래스
fileprivate class Follower: Followable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func update(_ message: String) {
        print("\(name)님이 \(message)에 대한 알림을 받았습니다.")
    }
}

// 실행 시나리오
/*
 in main.swift
 
 let observerPatternPractice = ObserverPatternPractice()
 observerPatternPractice.run()
 */
class ObserverPatternPractice {

    func run() {
        let chimchakman = Creator(name: "침착맨")
        let yooxicman = Creator(name: "육식맨")

        let mino = Follower(name: "마이노")
        let doggie = Follower(name: "두기")
        let papri = Follower(name: "파프리")
        let red = Follower(name: "레드")

        chimchakman.add(mino)
        chimchakman.add(doggie)
        yooxicman.add(papri)
        yooxicman.add(red)

        chimchakman.notify("어색한 모임에서 친해지는 법")
        yooxicman.notify("꿈에도 그리던 고든 램지와의 만남")
        chimchakman.notify("초밥 먹으며 초밥왕 이야기")
        yooxicman.notify("완벽하게 삼겹살 굽는 법")
    }
}
