# Design-Pattern-Practice

## Strategy Pattern(전략 패턴)

전략 패턴은 알고리즘 집합을 사용하는 패턴. 
알고리즘군(집합)을 정의하고 캡슐화해서 각각의 알고리즘을 하나의 인터페이스로 묶어 캡슐화하고, 이들을 교체하면서 쓸 수 있는 패턴을 의미한다.

<img width="600" alt="스크린샷 2022-11-15 오후 2 14 04" src="https://user-images.githubusercontent.com/63997044/201832035-eb192e78-92c4-42e8-a48a-e231a4855078.png">

> 오리 시뮬레이션 게임의 오리 구현 예시. 기존 오리들 중에서 일부 오리에 나는 기능이 추가되어야 하는 경우, 상속 대신 오리의 기능들을 알고리즘 또는 인터페이스라고 하고, 이를 전략(Strategy)이라고 묶어 필요에 따라 주입시켜주는 방법을 제안한다. - 출처: **헤드 퍼스트 디자인 패턴**

전략 패턴은 런타임에서 전략을 교체할 수 있기 때문에 비슷한 목적을 가지는 여러 알고리즘을 선택적으로 변경하면서 사용할 때 유용하다. 또는 비슷하지만 각자 다른 기능을 하는 객체를 구현할 때 유용하다.
(예 - 자동차 경로, 도보 경로, 자전거 경로를 각각 알려주는 내비게이션)

전략 패턴을 사용하면 알고리즘을 사용하는 객체와 알고리즘의 구현을 분리해서 독립적으로 변경할 수 있다. 이로 인해 **개방 폐쇄 원칙**을 준수하게 되어 기존 객체를 건드리지 않으면서 기능 확장을 할 수 있다.


## Observer Pattern(옵저버 패턴)

옵저버 패턴은 행동 패턴 중 하나로 A 객체에서 발생하는 이벤트를 A를 관찰하고 있는 B에게 알리는 패턴을 의미한다.

- Subject: 관찰 당하는 객체로, 어떠한 이벤트를 발생시키는 객체이다.
- Observer: Subject를 관찰하고 있는 객체로, Subject가 발생시킨 이벤트에 따라 특정 동작을 수행한다.

옵저버 패턴은 Subject와 Observer사이의 **느슨한 연결** 구성에 목적이 있다.

예를 들어 Subject가 새로 추가된다면? Subject의 구독자로 Observer를 추가할 뿐, Observer에는 변경사항이 없다.

또한 느슨한 연결에 따라 결합도가 낮아지는 효과가 있으며 객체지향 설계 원칙 중 단일 책임 원칙과 개방 폐쇄 원칙을 준수하게 된다.


## Publisher-Subscriber Pattern(발행 구독 패턴)

발행 구독 패턴은 옵저버 패턴과 동일하게 이벤트를 발생시키는 Subject(=Publisher)와 그 이벤트를 받기위해 Subject를 관찰하는 Observer(Subscriber)가 존재한다. 둘 사이의 중간에 이벤트를 처리하는 또 하나의 계층(미들웨어)이 존재한다.

발행 구독 패턴은 다음과 같은 특징이 존재한다. 
- 발행자가 보내는 메시지(이벤트)에는 수신자가 정해져 있지 않다.
- 특정 대상 없이 전달된 메시지는 구독중인 수신자에게 전달된다.
- 수신자는 발행자에 대한 정보 없이 메시지(이벤트)를 수신한다.

![](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FkOPnx%2FbtrrcumMg0k%2FgOlZSIj6wY0XG7JCxMhRY0%2Fimg.png)

옵저버 패턴과의 차이점은 다음과 같다.

1. 옵저버 패턴은 Observer와 Subject 간 서로를 알고 있으나, 발행 구독 패턴에서는 서로를 몰라도 상관없다.

    옵저버 패턴은 두 객체간의 직접적인 소통이 이루어져야 한다.
(Subject에서 Observer의 메서드를 직접적으로 호출하기 때문)
 
    반면 발행 구독 패턴은 Publisher 객체와 Subscriber 객체 사이에 직접적인 소통을 하지 않아도 된다.
소통의 역할을 Event Channel인 제 3자가 수행하기 때문이다.
 
2. 발행 구독 패턴이 옵저버 패턴보다 더 낮은 결합도를 가진다.

    1의 내용에서 살펴봤듯이, 서로의 존재를 알 필요가 없으므로 둘 사이에 더욱 느슨한 결합을 얻을 수 있다.

    옵저버 패턴과 다르게 발행 구독 패턴에서는 구독, 이벤트 전달 등 모두를 중간 계층에 위임하고 있으므로 더욱 분리된 구조를 구성할 수 있다는 장점이 있다.
 
3. 옵저버 패턴은 주로 동기적으로 동작하며, 발행 구독 패턴은 비동기적으로 동작하게 된다.

    발행구독 패턴에서는 Publisher, Subscriber 사이의 중간 브로커에게 이벤트를 던지고 다른 작업을 할 수 있기 때문에 비동기작업을 활용할 수 있다.

참고 자료
- [https://jeonyeohun.tistory.com/216](https://jeonyeohun.tistory.com/216)
- [https://learn.microsoft.com/ko-kr/azure/architecture/patterns/publisher-subscriber](https://learn.microsoft.com/ko-kr/azure/architecture/patterns/publisher-subscriber)
- [https://gobae.tistory.com/122](https://gobae.tistory.com/122)



## Mediator Pattern(중재자 패턴)

중재자 패턴은 행동 패턴 중 하나로 객체 간 복잡한 의존 관계를 줄일 수 있는 패턴이다. 객체 간의 상호 작용 로직을 캡슐화하여 Mediator에게 맡김으로써 상호 작용 로직을 독립적으로 만들고 상호 작용 주체인 두 객체 사이의 종속성을 줄일 수 있다.

![](https://miro.medium.com/max/732/0*OhWEPai_6A-JsuqM.png)

- Mediator: 객체들과 통신하기 위한 인터페이스를 정의하고 상호 작용에 대한 로직을 중앙 제어 관리하는 객체
- Component(Collague): Mediator 객체에 의해 중재되는 클래스(Object)

하나의 객체에서 발생한 이벤트에 대하여 다른 객체가 응답을 할 때 중재자 패턴을 사용한다. 이 때 객체들은 서로 독립적이고 상호 작용은 Mediator 객체를 통해서 한다.

중재자 패턴은 다음과 같은 특징을 갖고 있다.

장점:
- 상호 작용의 로직이 Mediator에게 중앙 집중 제어된다.
- 단일 책임 원칙 준수: Component 자체의 작업과 다른 객체와의 상호 작용이 분리되어 있기 때문에 책임이 분리되어 코드를 수정하기 쉽다.
- 개방 폐쇄 원칙 준수: 객체들을 변경하지 않고도 Mediator의 기능을 확장하거나 변경할 수 있다. 그 반대도 성립한다.
- 프로그램의 component 간 결합도를 줄일 수 있다.

단점:
- 시간이 지나고 여러 기능이 추가되면 Mediator 객체가 너무 많은 기능을 포함해 복잡한 구조가 될 수 있다.

참고 자료
- [https://en.wikipedia.org/wiki/Mediator_pattern](https://en.wikipedia.org/wiki/Mediator_pattern)
- [https://refactoring.guru/design-patterns/mediator/swift/example](https://refactoring.guru/design-patterns/mediator/swift/example)
- [https://joycestudios.tistory.com/44](https://joycestudios.tistory.com/44)
