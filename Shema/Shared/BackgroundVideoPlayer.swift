//
//  BackgroundVideoPlayer.swift
//  Shema
//
//  Created by Benson Arafat on 24/03/2026.
//

import SwiftUI
import AVKit
import AVFoundation

struct BackgroundVideoPlayer: UIViewRepresentable {
    let player: AVPlayer
    
    func makeCoordinator() -> Coordinator {
        Coordinator(player: player)
    }
    
    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.playerLayer.player = player
        view.playerLayer.videoGravity = .resizeAspectFill
        player.play()
        context.coordinator.observe()
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) {}
    
    static func dismantleUIView(_ uiView: PlayerView, coordinator: Coordinator) {
        coordinator.stop()
    }
    
    class Coordinator {
        let player: AVPlayer
        private var observer: NSObjectProtocol?
        
        init(player: AVPlayer) {
            self.player = player
        }
        
        func observe() {
            observer = NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem,
                queue: .main) { [weak self] _ in
                    self?.player.seek(to: .zero)
                    self?.player.play()
                }
        }
        
        func stop() {
            player.pause()
            if let observer {
                NotificationCenter.default.removeObserver(observer)
            }
        }
    }
}

class PlayerView: UIView {
    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
