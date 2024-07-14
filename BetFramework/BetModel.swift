//
//  BetModel.swift
//  BetFramework
//
//  Created by talha heybeci on 13.07.2024.
//

public struct Bet{
    public var name: String
    public var sellIn: Int
    public var quality: Int

    public init(name: String, sellIn: Int, quality: Int) {
        self.name = name
        self.sellIn = sellIn
        self.quality = quality
    }
}
