//
//  TimerManager.swift
//  MillionaireGame
//
//  Created by Polina on 28.02.2024.
//

import Foundation
import AVFoundation

protocol TimeManagerProtocol{
    func startTimer30Seconds()
    func startTimer5Seconds(music: String)
    func stopTimer30Seconds()
    func stop5Seconds()
    var progresPublisher: Published<Float>.Publisher { get }
}

final class TimeManager: TimeManagerProtocol{
    @Published var progrees: Float = 0.0
    var progresPublisher: Published<Float>.Publisher { $progrees }
    
    private var timer30Seconds = Timer()
    private var count30SecondsTotal = 30
    private var passSeconds30 = 0
    private let totalSecondsProgress = 30
    
    private var timer5SecondsGame = Timer()
    private var pass5SecondsGame = 0
    
    
    private var player: AVAudioPlayer?
    func startTimer30Seconds() {
        playerStart(resource: "zvuk-chasov-vo-vremya-igryi")
        timer30Seconds = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.update30Timer()
        }
    }
    
    func startTimer5Seconds(music: String) {
        timer5SecondsGame = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.update5SecondsTimer()
        }
        playerStart(resource: music)
    }
    
    
    func stopTimer30Seconds() {
        timer30Seconds.invalidate()
        playerStop()
    }
    
    func stop5Seconds(){
        pass5SecondsGame = 0
        timer5SecondsGame.invalidate()
        playerStop()
    }
    
    private func update30Timer() {
        print(count30SecondsTotal)
        count30SecondsTotal -= 1
        passSeconds30 += 1
        progrees = Float(passSeconds30) / Float(totalSecondsProgress)
        if count30SecondsTotal == 0 {
            playerStop()
            passSeconds30 = 0
            timer30Seconds.invalidate()
        }
    }
    
    private func update5SecondsTimer() {
        print(pass5SecondsGame)
        pass5SecondsGame += 1
        if pass5SecondsGame == 5 {
            playerStop()
            pass5SecondsGame = 0
            timer5SecondsGame.invalidate()
        }
    }
        
    private func playerStart(resource: String){
        let url = Bundle.main.url(forResource: resource, withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        } catch {
            print("30SecondsTimer error")
        }
    }
    
    private func playerStop(){
        player?.stop()
    }
}
