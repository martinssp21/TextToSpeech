//
//  ViewController.swift
//  TextToSpeech
//
//  Created by Rodrigo Martins on 22/04/19.
//  Copyright © 2019 Rodrigo Martins. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    @IBOutlet private weak var textLabelTextFont: UITextView!
    @IBOutlet weak var sliderSpeedSpeech: UISlider!
    @IBOutlet weak var buttonRead: RoundButton!
    @IBOutlet weak var buttonStop: RoundButton!
    @IBOutlet weak var pickerViewLanguage: UIPickerView!
    
    var languageSelected = String()
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerViewLanguage.delegate = self
        self.pickerViewLanguage.dataSource = self
    }

    private func ReadToSpeech(text: String = "Nada para ler", speed : Float = 2.0, language: String = "pt_BR"){
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)

        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / speed
        
        speechUtterance.voice = AVSpeechSynthesisVoice(language: language)
        
        speechSynthesizer.speak(speechUtterance)
    }
    
    @IBAction func buttonStopRead(_ sender: Any) {
        speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    @IBAction func buttonTextToSpeech(_ sender: Any) {
        self.ReadToSpeech(text: self.textLabelTextFont!.text, speed: self.sliderSpeedSpeech!.value , language: languageSelected)
    }
}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dictionaryLanguage[row].language
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       self.languageSelected = dictionaryLanguage[row].value
    }
}

extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dictionaryLanguage.count
    }
}



