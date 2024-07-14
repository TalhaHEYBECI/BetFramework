//
//  BetRepository.swift
//  BetFramework
//
//  Created by talha heybeci on 13.07.2024.
//

public class BetRepository : NSObject{
    private let service: BetService
    
    public init(service: BetService) {
        self.service = service
    }
    
    public func updateOdds() async throws -> [Bet] {
        var bets = try await service.loadBets()
        
        for i in 0 ..< bets.count {
            var bet = bets[i]
            updateBetQuality(&bet)
            bet.sellIn -= 1
            if bet.sellIn < 0 {
                handleExpiredBet(&bet)
            }
            bets[i] = bet
        }
        
        try await service.saveBets(bets)
        return bets
    }
    
    private func updateBetQuality(_ bet: inout Bet) {
        switch bet.name {
        case "Player performance":
            increaseQuality(&bet)
        case "Total score":
            increaseQuality(&bet)
            if bet.sellIn < 11 {
                increaseQuality(&bet)
            }
            if bet.sellIn < 6 {
                increaseQuality(&bet)
            }
        case "Winning team":
            break
        default:
            decreaseQuality(&bet)
        }
    }
    
    private func handleExpiredBet(_ bet: inout Bet) {
        switch bet.name {
        case "Player performance":
            increaseQuality(&bet)
        case "Total score":
            bet.quality = 0
        case "Winning team":
            break
        default:
            decreaseQuality(&bet)
        }
    }
    
    private func increaseQuality(_ bet: inout Bet) {
        if bet.quality < 50 {
            bet.quality += 1
        }
    }
    
    private func decreaseQuality(_ bet: inout Bet) {
        if bet.quality > 0 {
            bet.quality -= 1
        }
    }
}


