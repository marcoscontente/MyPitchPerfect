//
//  PlayAudioViewController.swift
//  MyPitchPerfect
//
//  Created by Marcos V G Contente on 17/10/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {

    @IBOutlet weak var squirrelButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var stopAudioButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    
    var audioRecorderURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func tapToPlaySoundForButton(_ sender: UIButton) {
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playAudio(rate: 0.5)
        case .fast:
            playAudio(rate: 2.0)
        case .chipmunk:
            playAudio(pitch: 1000)
        case .vader:
            playAudio(pitch: -1000)
        case .echo:
            playAudio(echo: true)
        case .reverb:
            playAudio(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func tapToStopAudio(_ sender: Any) {
        stopAudio()
    }
}
