//
//  InstgramStoriesVC.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 05/01/2023.
//

import UIKit
import AVKit

class InstgramStoriesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizer()
        playLocalVideoLayer()
        
        // Do any additional setup after loading the view.
    }
    func addGestureRecognizer() {
        let leftSwipe = UITapGestureRecognizer(target: self, action: #selector(didTapSnap))
        self.view.addGestureRecognizer(leftSwipe)
    }
    @objc
    func didTapSnap(_ sender: UITapGestureRecognizer) {
       let touchLocation = sender.location(ofTouch: 0, in: view)
       if touchLocation.x < view.frame.width/2 {
        // changePlayer(forward: false)
         }
       else {
//         fillupLastPlayedSnap()
//         changePlayer(forward: true)
        }
    }
    
    func addPlayer(player: AVPlayer) {
        player.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
      //  playerViewModel?.player = player
    //    playerView.playerLayer.player = player
    }
    
    func playLocalVideoLayer() {
        guard let path = Bundle.main.path(forResource: "story", ofType:"mp4") else {
            debugPrint("story.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func playLocalVideo() {
        guard let path = Bundle.main.path(forResource: "story", ofType:"mp4") else {
            debugPrint("story.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    
    
    func playvideo() {
        let videoURL = URL(string: "https://www.youtube.com/shorts/VKGOGtuqN18")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            if let player =  playerViewController.player {
                player.play()
            }
            
        }
    }
    
}
