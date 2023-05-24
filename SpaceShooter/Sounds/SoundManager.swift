//
//  SoundManager.swift
//  SpaceShooter
//
//  Created by Vicky Irwanto on 25/05/23.
//

import AVFoundation

class SoundManager{
    static let instance = SoundManager()
    
    var player : AVAudioPlayer?
    
    func PlaySound(){
        guard let url = Bundle.main.url(forResource: "bgsound", withExtension: ".mp3") else {return}
        
        do{
          
            player = try AVAudioPlayer(contentsOf:url)
            player?.numberOfLoops = -1
            player?.play()
        } catch let error{
            print("error playing sound. \(error.localizedDescription)")
        }
    }
    
    func StopSound(){
        guard let url = Bundle.main.url(forResource: "bgsound", withExtension: ".mp3") else {return}
        
        do{
            player = try AVAudioPlayer(contentsOf:url)
            player?.pause()
        } catch let error{
            print("error stopping sound. \(error.localizedDescription)")
        }
    }
    
    func PlaySoundFire(){
        guard let url = Bundle.main.url(forResource: "slimeball", withExtension: ".wav") else {return}
        
        do{
          
            player = try AVAudioPlayer(contentsOf:url)
            player?.numberOfLoops = -1
            player?.play()
        } catch let error{
            print("error playing sound. \(error.localizedDescription)")
        }
    }
    
    func StopSoundFire(){
        guard let url = Bundle.main.url(forResource: "slimeball", withExtension: ".wav") else {return}
        
        do{
            player = try AVAudioPlayer(contentsOf:url)
            player?.pause()
        } catch let error{
            print("error stopping sound. \(error.localizedDescription)")
        }
    }
    
    
}

