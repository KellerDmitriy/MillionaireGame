//
//  TimerManager.swift
//  MillionaireGame
//
//  Created by Polina on 28.02.2024.
//

import Foundation
import AVFoundation

protocol TimeManagerProtocol{
    func startTimer30Seconds(completion: @escaping () -> Void)
    func startTimer5Seconds(music: String, completion: @escaping () -> Void)
    func startTimer2Seconds(completion: @escaping () -> Void)
    func stopTimer30Seconds()
    func stop5Seconds()
    func set30TimerGoToSubtotal()
    var progresPublisher: Published<Float>.Publisher { get }
}

final class TimeManager: TimeManagerProtocol{
    @Published var progrees: Float = 0.0
    var progresPublisher: Published<Float>.Publisher { $progrees }
    
    private var timer30Seconds = Timer()
    private var count30SecondsTotal = 30
    private var passSeconds30 = 0
    private let totalSecondsProgress = 30
    private var completionHandler30Sec: (() -> Void)?
    
    private var timer5SecondsGame = Timer()
    private var pass5SecondsGame = 0
    private var completionHandler5Sec: (() -> Void)?
    
    private var timer2SecondsGame = Timer()
    private var pass2SecondsGame = 0
    private var completionHandler2Sec: (() -> Void)?
    
    
    private var player: AVAudioPlayer?
    func startTimer30Seconds(completion: @escaping () -> Void) {
        self.completionHandler30Sec = completion
        playerStart(resource: "zvuk-chasov-vo-vremya-igryi")
        timer30Seconds = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.update30Timer()
        }
    }
    
    func startTimer5Seconds(music: String, completion: @escaping () -> Void) {
        self.completionHandler5Sec = completion
        timer5SecondsGame = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.update5SecondsTimer()
        }
        playerStart(resource: music)
    }
    
    func startTimer2Seconds(completion: @escaping () -> Void) {
        self.completionHandler2Sec = completion
        timer2SecondsGame = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.update2SecondsTimer()
        }
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
    
    func set30TimerGoToSubtotal() {
        count30SecondsTotal = 30
        passSeconds30 = 0
        progrees = 0
        playerStop()
        timer30Seconds.invalidate()
    }
    
    private func update30Timer() {
        //print("progress from timeManager start \(progrees)")
        count30SecondsTotal -= 1
        passSeconds30 += 1
        progrees = Float(passSeconds30) / Float(totalSecondsProgress)
        //print("progress from timeManager finish \(progrees)")
        if count30SecondsTotal == 0 {
            passSeconds30 = 0
            playerStop()
            timer30Seconds.invalidate()
            completionHandler30Sec?()
        }
    }
    
    private func update5SecondsTimer() {
        print(pass5SecondsGame)
        pass5SecondsGame += 1
        if pass5SecondsGame == 5 {
            playerStop()
            pass5SecondsGame = 0
            timer5SecondsGame.invalidate()
            completionHandler5Sec?()
        }
    }
    
    private func update2SecondsTimer() {
        pass2SecondsGame += 1
        if pass2SecondsGame == 2 {
            pass2SecondsGame = 0
            timer2SecondsGame.invalidate()
            completionHandler2Sec?()
        }
    }
        
    private func playerStart(resource: String){
        let url = Bundle.main.url(forResource: resource, withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        } catch {
            print("Timer error")
        }
    }
    
    private func playerStop(){
        player?.stop()
    }
}
