//
//  RecordAudioViewController.swift
//  MyPitchPerfect
//
//  Created by Marcos V G Contente on 17/10/18.
//  Copyright © 2018 marcoscontente. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: - Initialize Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(false)
        recordButton.imageView?.contentMode = .scaleAspectFit
        stopRecordButton.imageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Audio Functions
    
    @IBAction func tapToRecord(_ sender: Any) {
        configureUI(true)
        
        let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedFile.wav"
        let pathArray = [directoryPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func tapToStopRecord(_ sender: Any) {
        configureUI(false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - UI Functions
    
    func configureUI(_ isRecording: Bool = false) {
        recordButton.isEnabled = !isRecording
        stopRecordButton.isEnabled = isRecording
        recordLabel.text = isRecording ? "Recording" : "Tap To Record"
    }
    
    // MARK: - Audio delegate

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Record audio was not successful")
        }
    }
    
    // MARK: - Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlayAudioViewController
            let recorderURL = sender as! URL
            playSoundsVC.audioRecorderURL = recorderURL
        }
    }
    
}

