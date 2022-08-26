# **묵찌빠게임(rock-paper-scissors)**

---

## 1. **소개:**

 가위바위보로 공격하는 순서를 정한 후 묵찌빠를 진행합니다.

 - **게임진행방법:**
1. 컴퓨터와 가위바위보를 진행합니다. 
(가위(1), 바위(2), 보(3))
2. 가위바위보에서 이기면 사용자가 공격권을 갖고, 지면 컴퓨터가 공격권을 갖게됩니다. 
3. 묵찌빠를 시작합니다. 
(묵(1), 찌(2), 빠(3))
4. 묵찌빠 중 비기면 현재 공격권을 갖고있는 자가 승리합니다. 
비기지 않고 이기게 되면 사용자 공격권을 갖고 다시 시작하고, 
지면 컴퓨터가 공격권을 갖고 다시 묵찌빠를 진행합니다.
5. 승자가 나올 때까지 묵찌빠를 진행합니다.

---

## 2. **🧑‍🤝‍🧑 팀원**


|**제이푸시**|**써니쿠키**|
|------|---|
|<img width="150" src="https://i.imgur.com/9Cw0sFn.png)">|<img width="150" src="https://i.imgur.com/z4FjnKX.png">|  

---

## 3. 👩🏻‍💻 실행 화면(기능 설명)
### - 실행화면에서 가위바위보, 묵찌빠 0.게임종료 선택시

| 가위바위보 종료 | 묵찌빠 종료 |
| -- | -- |
| ![가위바위보 종료](https://user-images.githubusercontent.com/82566116/186845777-c71ff334-025a-4a83-a27b-33810828b06c.gif) | ![묵찌빠 종료](https://user-images.githubusercontent.com/82566116/186845783-1b55309f-1b38-4ff9-b928-71971f36f00a.gif)

### - 실행화면에서 가위바위보와 묵찌빠 게임 사용자 입력값 오류처리
| 가위바위보 오류처리 | 묵찌빠 오류처리 |
| -- | -- |
| <img src="https://user-images.githubusercontent.com/82566116/186845793-6bceedec-212f-4c38-ac13-aae6ba5ed663.gif" width=400> | ![묵찌빠 오류처리](https://user-images.githubusercontent.com/82566116/186845794-a3e7c99c-b179-47b9-a86d-4da3a0022dff.gif)

### - 정상적인 게임 진행화면

| 묵찌빠 진행 |
| -- |
| ![묵찌빠 진행](https://user-images.githubusercontent.com/82566116/186845808-60887ceb-c277-42a6-a175-007cbfbc45eb.gif) |

---

## 4. **🔥 트러블 슈팅**

- ### 1️⃣ 가위바위보의 손 모앙을 열거형으로 처리할 때 문제가 생기는 부분
  >  ⛔️ **문제점**: case none을 추가하게 되면 switch 문이나 if문에서 none을 해결해 주어야 했기 때문에 생겼던 문제. 또한, 가위바위보 열거형에 none이라는 케이스가 있는것이 어색했습니다.

    💡 **해결법** : case none을 삭제했습니다. switch, if문에서 none을 체크하지 않고 반환값을 Optional 로 만들어서 반환. 이후 바인딩 해서 체크했습니다.


- ### 2️⃣ 가위바위보 승부 판단을 switch문을 사용함에 있어서의 가독성 문제
    >⛔️ **문제점**: 유저의 손모양을 각각 케이스로 받아서 컴퓨터와 비교했습니다. 내부에 if문으로 이기고 진 상황을 분기 했습니다. 직관적이지만 가독성이 상당히 좋지 않습니다.
    ```swift
    switch userRPS {
     case .rock:
         if computerRPS == .scissors {
             gameResult = .win
         } else if computerRPS == .paper {
             gameResult = .lose
         }
     case .paper:
         if computerRPS == .rock {
             gameResult = .win
         } else if computerRPS == .scissors {
             gameResult = .lose
         }
     case .scissors:
         if computerRPS == .paper {
             gameResult = .win
         } else if computerRPS == .rock {
             gameResult = .lose
         }
    ```



    💡 **해결법** : 직관성도 더 높아지고 가독성은 훨씬 더 좋아졌습니다. 튜플을 사용해서 각각의 상황에 승부판단을 했습니다.
    ```swift
    static func judgeUserGameResultIn(_ userRPS: HandShape, _ computerRPS: HandShape) -> GameResult {
            switch (userRPS, computerRPS) {
            case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
                return .win
            case (.rock, .paper), (.scissors, .rock), (.paper, .scissors):
                return .lose
            case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
                return .draw
            }
        }
    ```



- ### 3️⃣ 설계를 할 때 고민했던 부분
    설계를 시작할 때 어떤 메서드와 객체간의 관계를 고민했습니다.

    1. class상속이용: 처음엔 묵찌빠는 가위바위보에서 몇몇 기능이 추가 된 확장판이라고 생각하여 class로 변환 후 상속을 활용하는 방법으로 진행하다가 상속관계가 아닌 것을 알게되었습니다. 집합관계에서 가위바위보가 묵찌빠에 모두 포함되어 있지 않다는 것을 깨달아서 채택하지 않은 컨셉이었습니다
    2. struct extension 이용: 기능을 확장한다는 의미로 extension을 사용하려 했는데 묵찌빠를 표현하기 위해서는 구조체의 네이밍을 묵찌빠로 해주어야 했기에 채택하지 않은 컨셉이었습니다.
    3. 묵찌빠 struct내에서 가위바위보 인스턴스생성: 묵찌빠 내의 객체에서 가위바위보 인스턴스를 생성하여 게임을 실행하고 받은 값들을 묵찌빠에 활용하는 컨셉이었습니다.
    
        -> 💡 **해결법** : 3번 컨셉을 선택하였는데 생각하기에 2번 컨셉의 문제를 해결하고 가위바위보진행과 가위바위보의 메서드를 묵찌빠 구조체 안에서도 사용할 수 있는 컨셉이라 판단되어 채택하였습니다.
후에 추가적으로 생각한 부분이 공통적인 부분을 프로토콜을 만들어서 입력값을 받는 부분이나 판단하는 부분을 구현하여 채택하는 방식을 생각했습니다. 채택한 프로토콜을 구현한 후 각각의 객체를 메인에서 불러와서 실행 후 결과값에 따라 재실행 할지, 종료할지를 분기하는 방식입니다.

- ### 4️⃣ 연산프로퍼티사용
    묵찌빠에서 공격권을 갖는 자가 매번 달라지기에 게임의 결과에 따라 차례를 결정해 주기위해`winnerTurn` 을 연산프로퍼티로 사용하였습니다. 처음에는 메서드를 이용했는데 코드의 간결화를 위해 연산프로퍼티로 수정하였습니다. 가위바위보에서 종료되는 경우(승자가 없는경우)를 nil로 받아오도록 옵셔널처리를 해주었고 게임결과에 따라서 값이 바뀌면 순서를 바꿔주고 누구의 순서인지 알려주는 print문을 추가해주었습니다


- ### 5️⃣ 가위바위보 중 0입력 시 종료되지 않고 묵찌빠가 진행되는 문제
     <img width="550" src="https://i.imgur.com/PLXO5Ps.png">
    

  >⛔️ **원인** : `묵찌빠게임시작 메서드`에서 `가위바위보 구조체`를 인스턴스화 한 후 `가위바위보 게임시작 메서드`를 이용해 가위바위보를 진행한 후`while문`을 이용해 비기기 전까지 묵찌빠를 진행하도록 코드를 작성했었습니다. 그렇기 때문에 `묵찌빠게임시작 메서드`를 실행하면 가위바위보가 종료되어도 `while문`이 실행되어 묵찌빠는 종료되지 않고 진행되는 문제가 있었습니다.
  
  💡 **해결법** : 묵찌빠게임시작 메서드안에 게임결과를 담는 프로퍼티`gameResult`와 가위바위보 게임시작 메서드 안에 게임결과를 리턴값으로 받는 메서드`fetchRPSGameResult()` 를 생성하여 gameResult를  `fetchRPSGameResult()` 메서드를 이용해 받은 후 그 값이 `nil`일 경우엔 게임이 종료될 수 있도록 `guard문`에서 `else`를 이용해 `return`되도록 처리하였습니다.

- ### 6️⃣ 네이밍에 약어사용
    RockPaperScissors, MukJjiPpa 의 약어로 RPS, MJP를 사용했습니다. 다만 변수이름이 약어로 시작할 떄는 대문자로 시작하는 것을 권고하지 않는 가이드라인을 따라 **변수이름이 약어로 시작하는 경우 소문자로 표기**하고, 그 외의 경우에는 항상 대문자로 표기했습니다.
    
- ### 7️⃣ 접근제어
     유저가 참조할 수 있는 부분과 참조할 수 없는 부분을 나누어서 접근제어 처리를 해주었습니다. 다만 묵찌빠에서 가위바위보 인스턴스를 생성하다 보니 메인에서 가위바위보를 만들었을 때 불필요한 부분을 참조 하게되는 문제가 있었습니다.
     이를 해결하려고 internal을 추가하였는데 해결이 되지 않았고 internal은 모듈 외부에서의 사용을 막는 것이었습니다. 해결방법은 구조를 변경해서 하는 수 밖에 없다고 생각이 들었습니다.
    유저가 궁금한건 게임시작과 결과일 뿐이라 생각하여 게임시작 메서드 외에는 모든 프로퍼티와 메서드들을 private 를 이용해 접근제어를 설정해주었습니다.

---

### 5. **🔗 참고 링크**

- [Swift Language Guide - Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html)
- [약어](
https://github.com/StyleShare/swift-style-guide#%EC%95%BD%EC%96%B4)
- [접근제어  Access Level](
https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)
- [[Swift Algorithm Note] 재귀함수 정리 (feat. Factorial)](https://seolhee2750.tistory.com/58)
