//
//  PreviewVC.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 06/01/2023.
//

import UIKit
import AVKit

class PreviewVC: UIViewController {
    @IBOutlet weak var videoView: UIView!
    
    var SPB: SegmentedProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        SPB = SegmentedProgressBar(numberOfSegments: 2, duration: 5)
        if #available(iOS 11.0, *) {
            SPB.frame = CGRect(x: 18, y: UIApplication.shared.statusBarFrame.height + 5, width: view.frame.width - 18, height: 3)
        } else {
            // Fallback on earlier versions
            SPB.frame = CGRect(x: 18, y: 15, width: view.frame.width - 35, height: 3)
        }
        SPB.delegate = self
        SPB.topColor = UIColor.white
        SPB.bottomColor = UIColor.white.withAlphaComponent(0.25)
        SPB.padding = 2
        SPB.isPaused = true
        SPB.currentAnimationIndex = 0
        SPB.duration = getDuration(at: 0)
        view.addSubview(SPB)
        view.bringSubviewToFront(SPB)

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.playLocalVideoLayer()
            self.SPB.startAnimation()
            self.SPB.duration = 5
        }
    }
    func addGestures() {
        let tapGestureVideo = UITapGestureRecognizer(target: self, action: #selector(tapOn(_:)))
        tapGestureVideo.numberOfTapsRequired = 1
        tapGestureVideo.numberOfTouchesRequired = 1
        videoView.addGestureRecognizer(tapGestureVideo)
    }
    
    func playLocalVideoLayer() {
        guard let path = Bundle.main.path(forResource: "story", ofType:"mp4") else {
            debugPrint("story.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame =  self.videoView.bounds
        playerLayer.videoGravity = .resizeAspect
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    @IBAction func closeAction(_ sender: Any) {
    }
    
    private func getDuration(at index: Int) -> TimeInterval {
        return 5
    }
    @objc
    func tapOn(_ sender: UITapGestureRecognizer) {
        print("tapOn")
       SPB.skip()
    }
    
}

extension PreviewVC: SegmentedProgressBarDelegate {
    func segmentedProgressBarChangedIndex(index: Int) {
        playLocalVideoLayer() 
    }
    
    func segmentedProgressBarFinished() {
        print("segmentedProgressBarFinished")
        
    }
    
    
}
