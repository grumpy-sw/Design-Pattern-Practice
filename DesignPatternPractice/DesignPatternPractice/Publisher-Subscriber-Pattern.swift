//
//  Publisher-Subscriber-Pattern.swift
//  DesignPatternPractice
//
//  Created by 박세웅 on 2022/11/21.
//

import Foundation

fileprivate protocol Observable {
    func add(_ follower: Follower)
    func remove(_ follower: Follower)
    func notify(_ message: String)
}

fileprivate protocol Followable {
    func update(_ message: String)
}

fileprivate class Creator: Observable, Hashable {
    static func == (lhs: Creator, rhs: Creator) -> Bool {
        return lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    let name: String
    var administrator: Administrator
    var followers: [Follower] = []
    
    init(name: String, administrator: Administrator) {
        self.name = name
        self.administrator = administrator
    }
    
    func add(_ follower: Follower) {
        self.administrator.add(follower: follower, of: self)
    }
    
    func remove(_ follower: Follower) {
        self.administrator.remove(follower: follower, of: self)
    }
    
    func notify(_ message: String) {
        self.administrator.notify(message, toFollowersOf: self)
    }
}

fileprivate class Follower: Followable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func update(_ message: String) {
        print("\(name)님이 \(message)에 대한 알림을 받았습니다.")
    }
}

fileprivate class Administrator {
    var relationships: [Creator: [Follower]] = [:]
    
    func add(follower: Follower, of creator: Creator) {
        if relationships[creator] == nil {
            relationships[creator] = [follower]
        } else {
            relationships[creator]!.append(follower)
        }
    }
    
    func remove(follower: Follower, of creator: Creator) {
        guard let followers = relationships[creator] else {
            return
        }
        
        if let index = followers.firstIndex(where: {
            $0 === follower
        }) {
            relationships[creator]?.remove(at: index)
        }
    }
    
    func notify(_ message: String, toFollowersOf creator: Creator) {
        guard let followers = relationships[creator] else {
            return
        }
        
        for follower in followers {
            follower.update(message)
        }
    }
}

class PublisherSubscriberPatternPractice {
    
    func run() {
        let administrator = Administrator()
        
        let chimchakman = Creator(name: "침착맨", administrator: administrator)
        let yooxicman = Creator(name: "육식맨", administrator: administrator)
        
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
        
        chimchakman.remove(mino)
        chimchakman.add(red)
        
        chimchakman.notify("초밥 먹으며 초밥왕 이야기")
        yooxicman.notify("완벽하게 삼겹살 굽는 법")
    }
}
