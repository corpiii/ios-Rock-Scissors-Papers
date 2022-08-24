struct RockPaperScissorsGame {
    internal var RPSWinner: Player = .none
    mutating func startRPSGame() {
        printRPGMenu()
        
        guard let userRPSNumber = fetchUserNumber() else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
            return startRPSGame()
        }
        
        if userRPSNumber == 0 {
            print("게임종료")
            return
        }
        
        let computerRPSNumber = Int.random(in: 1...3)
        
        guard let userRPS = RPS.convertRPS(from: userRPSNumber),
              let computerRPS = RPS.convertRPS(from: computerRPSNumber) else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
            return startRPSGame()
        }
        
        let gameRPSResult = GameResult.judgeUserGameResultIn(userRPS, computerRPS)
        
        printResult(of: gameRPSResult)
        
        switch gameRPSResult {
        case .win:
            RPSWinner = .user
            return
        case .lose:
            RPSWinner = .computer
            return
        case .draw:
            startRPSGame()
        }
    }

    
    private func printRPGMenu() {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")
    }
    
    internal func fetchUserNumber() -> Int? {
        guard let userInput = readLine() else {
            return nil
        }
        
        return Int(userInput)
    }
    
    private func printResult(of result: GameResult) {
        switch result {
        case .win:
            print("이겼습니다!")
        case .lose:
            print("졌습니다!")
        case .draw:
            print("비겼습니다!")
        }
    }
}
