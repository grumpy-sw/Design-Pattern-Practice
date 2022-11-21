//
//  Strategy-Pattern.swift
//  DesignPatternPractice
//
//  Created by 박세웅 on 2022/11/21.
//

import Foundation

// 나는 기능을 나타내는 Flyable과 울음소리를 내는 기능을 나타내는 Quackable 정의
fileprivate protocol Flyable {
    func fly()
}

fileprivate protocol Quackable {
    func quack()
}

// 전략에 해당. 기능인 프로토톨을 프로퍼티로 갖고 있음
fileprivate protocol Strategy {
    var flyStrategy: Flyable { get set }
    var quackStrategy: Quackable { get set }
    
    func fly()
    func quack()
}

// 알고리즘 구현
// 날 수 있는 오리들이 사용하는 인터페이스인 FlyWithWings와 날 수 없는 오리들이 사용하는 FlyNoWay로 각각 분리
fileprivate class FlyWithWings: Flyable {
    func fly() {
        print("나는 행동")
    }
}

fileprivate class FlyNoWay: Flyable {
    func fly() {
        print("날수 없는 행동")
    }
}

// quack() 메서드를 각각 다르게 처리할 세 가지의 타입 구현
fileprivate class Quack: Quackable {
    func quack() {
        // 오리가 내는 꽥꽥 울음소리 구현
        print("꽥꽥")
    }
}

fileprivate class Squeak: Quackable {
    func quack() {
        // 고무 오리가 내는 삑삑 소리 구현
        print("삑삑")
    }
}

fileprivate class MuteQuack: Quackable {
    func quack() {
        print("--")
    }
}

// 초기화 구문을 통해 기능들을 주입받고, change 메서드를 통해 사용 중인 인터페이스를 교체하도록 Duck 클래스 구현
// 기능에 해당하는 fly()와 quack() 메서드는 내부적인 로직을 갖는 것이 아니라 자기가 가진 알고리즘 전략을 실행해서 나온 결과를 그대로 반환 -> 알고리즘의 구현과 사용을 완벽히 분리
fileprivate class Duck: Strategy {
    var flyStrategy: Flyable
    var quackStrategy: Quackable
    
    init(_ flyStrategy: Flyable, _ quackable: Quackable) {
        self.flyStrategy = flyStrategy
        self.quackStrategy = quackable
    }
    
    func change(_ flyStrategy: Flyable?, _ quackable: Quackable?) {
        if let flyStrategy = flyStrategy {
            self.flyStrategy = flyStrategy
        }
        if let quackable = quackable {
            self.quackStrategy = quackable
        }
    }
    
    func fly() {
        self.flyStrategy.fly()
    }
    
    func quack() {
        self.quackStrategy.quack()
    }
}

// 실행 시나리오
/*
 in main.swift
 
 let strategyPatternPractice = StrategyPatternPractice()
 strategyPatternPractice.run()
 */

class StrategyPatternPractice {
    func run() {
        let mallard = Duck(FlyWithWings(), Squeak())
        mallard.fly()
        mallard.quack()
    }
}
