//
//  Mediator-Pattern.swift
//  DesignPatternPractice
//
//  Created by 박세웅 on 2022/12/03.
//

import Foundation

fileprivate protocol Mediator: AnyObject {
    func notify(_ sender: Component, _ message: String)
}

fileprivate class ConcreateMediator: Mediator {
    private var components: [Component] = []
    
    func add(_ component: Component) {
        print("\(component.name)님이 대화방에 참여하셨습니다.")
        self.components.append(component)
    }
    
    func add(_ components: [Component]) {
        self.components += components
    }
    
    func notify(_ sender: Component, _ message: String) {
        for component in components {
            if component != sender {
                if let camper = component as? Camper {
                    camper.read(message, from: sender as! Camper)
                }
            }
        }
    }
}

fileprivate class Component: Hashable {
    static func == (lhs: Component, rhs: Component) -> Bool {
        return lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    let name: String
    fileprivate weak var mediator: Mediator?
    
    init(name: String, mediator: Mediator? = nil) {
        self.name = name
        self.mediator = mediator
    }

    func update(mediator: Mediator) {
        self.mediator = mediator
    }
}

fileprivate class Camper: Component {
    func post(_ message: String) {
        print("\(name) : \(message)")
        self.mediator?.notify(self, message)
    }
    
    func read(_ message: String, from camper: Camper) {
        print("\(name) > \(camper.name)으로부터 받은 메시지: \(message)")
    }
}

/*
 중재자 패턴 예시 코드
 
 채팅 프로그램을 구현한다고 가정.
 Sender: 메시지를 보냄
 Mediator: 메시지를 받아 Components들에게 전달
 Receiver: 메시지를 받았음을 확인
 ex) onetool.post("안녕하세요?") -> Mediator가 components 중 sender를 제외하고 메시지 전달 -> [dudu, mmim, marisol].read()
 */

class MediatorPatternPractice {
    func run() {
        let concreteMediator = ConcreateMediator()
        let dudu = Camper(name: "두두", mediator: concreteMediator)
        let mmim = Camper(name: "밈", mediator: concreteMediator)
        let onetool = Camper(name: "원툴", mediator: concreteMediator)
        let marisol = Camper(name: "마리솔", mediator: concreteMediator)

        concreteMediator.add([dudu, mmim, onetool, marisol])
        onetool.post("안녕하세요?")
        
        let mino = Camper(name: "마이노", mediator: concreteMediator)
        concreteMediator.add(mino)
        
        marisol.post("어서오세요!")
    }
}
