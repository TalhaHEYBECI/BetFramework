//
//  BetService.swift
//  BetFramework
//
//  Created by talha heybeci on 13.07.2024.
//

public protocol BetService : NSObject {
    func loadBets() async throws -> [Bet]
    func saveBets(_ bets: [Bet]) async throws
}
