//
//  ViewController.swift
//  Siri
//
//  Created by QianTuFD on 16/10/8.
//  Copyright © 2016年 fandy. All rights reserved.
//

import UIKit
import Speech


class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var microphoneButton: UIButton!
    
    // recognitionRequest 对象用于处理语音识别请求，为语音识别提供音频输入。
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    // 可以将识别请求的结果返回给你，它带来了极大的便利，必要时，可以取消或停止任务。
    private var recognitionTask: SFSpeechRecognitionTask?
    // 最后的 audioEngine 是音频引擎。它的存在使得你能够进行音频输入。
    private let audioEngine = AVAudioEngine()
    
    // zh_CN，zh_TW，zh_HK en-US
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh_CN"))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        microphoneButton.isEnabled = false
        speechRecognizer?.delegate = self;
        
        // 检测授权
        SFSpeechRecognizer.requestAuthorization { (status) in
            // 子线程回掉
            var isButtonEnabled = false
            print(Thread.current)
            switch status {
            case .notDetermined:
                isButtonEnabled = false
            case .denied:
                isButtonEnabled = false
            case .restricted:
                isButtonEnabled = false
            case .authorized:
                isButtonEnabled = true
            }
            
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }

    }
    

    
    
    
    @IBAction func microphoneTapped(_ sender: AnyObject) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
            microphoneButton.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            microphoneButton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func startRecording() -> Void {
        // 检查 recognitionTask 的运行状态，如果正在运行，取消任务
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        // 创建一个 AVAudioSession 对象为音频录制做准备。这里我们将录音分类设置为 Record，模式设为 Measurement，然后启动。
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession 设置失败")
        }
        
        
        // 实例化 recognitionResquest。创建 SFSpeechAudioBufferRecognitionRequest 对象，然后我们就可以利用它将音频数据传输到 Apple 的服务器。
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        
        // 检查 audioEngine (你的设备)是否支持音频输入以录音。如果不支持，报一个 fatal error。
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        // 检查 recognitionRequest 对象是否已被实例化，并且值不为 nil。
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        // 告诉 recognitionRequest 不要等到录音完成才发送请求，而是在用户说话时一部分一部分发送语音识别数据。
        recognitionRequest.shouldReportPartialResults = true;
        
        // 在调用 speechRecognizer 的 recognitionTask 函数时开始识别。该函数有一个完成回调函数，每次识别引擎收到输入时都会调用它，在修改当前识别结果，亦或是取消或停止时，返回一个最终记录。
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            // 倘若结果非空，则设置 textView.text 属性为结果中的最佳记录。同时若为最终结果，将 isFinal 置为 true。
            if result != nil {
                self.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            // 如果请求有错误或已经收到最终结果，停止 audioEngine (音频输入)，recognitionRequest 和 recognitionTask。同时，将开始录音按钮的状态切换为可用。
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        // 向 recognitionRequest 添加一个音频输入。值得留意的是，在 recognitionTask 启动后再添加音频输入完全没有问题。Speech 框架会在添加了音频输入之后立即开始识别任务。
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        
        
        //  将 audioEngine 设为准备就绪状态，并启动引擎。
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textView.text = "Say something, I'm listening!"
        
    }
    
    //在创建语音识别任务时，我们首先得确保语音识别的可用性，因此，需要向 ViewController 添加一个 delegate 方法。如果语音识别不可用，或是改变了状态，应随之设置 microphoneButton.enable 属性。针对这个方案，我们实现了 SFSpeechRecognizerDelegate 协议的 availabilityDidChange 方法。详细实现如下所示：
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }
    
}

