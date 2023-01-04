//
//  VerificationVC.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 31/12/2022.
//

import UIKit
import AEOTPTextField
import MZTimerLabel

class X{
    var t = 10
}
struct Y{
    var t = 10
}

class VerificationVC: UIViewController {
    @IBOutlet weak var timerLabel: MZTimerLabel!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var firstCodeTF: AEOTPTextField!
    
    var timeLeft: Int = 5 {
        didSet {
            if timeLeft > 0 {
                resendButton.isUserInteractionEnabled = false
            } else {
                resendButton.isUserInteractionEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuOTPTextField()
        setupTimer()
        let x = X()
        x.t = 10
        
        var y = Y()
        y.t = 10
        
    }
    
    
    private func setuOTPTextField(){
        firstCodeTF.otpDefaultCharacter = "-"
        firstCodeTF.otpBackgroundColor = .white
        firstCodeTF.otpFilledBackgroundColor = .gray
        firstCodeTF.otpCornerRaduis = 15
        firstCodeTF.otpDefaultBorderColor = .clear
        firstCodeTF.otpFilledBorderColor = .darkGray
      //  firstCodeTF.isSecureTextEntry = true
        firstCodeTF.otpDelegate = self
        firstCodeTF.configure(with: 4)
    }

    private func setupTimer(){
        timerLabel.setCountDownTime(Double(timeLeft))
         self.timerLabel.timeFormat = "mm:ss"
        self.timerLabel.timerType = MZTimerLabelType(1)
        self.timerLabel.delegate = self
        self.timerLabel.start()
        self.timerLabel.resetTimerAfterFinish = true
        
    }
    
    @IBAction func resendButtonTapped(_ sender: Any) {
        print("resend Code")
    }
}
extension VerificationVC: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        print("I will verify code \(code)")
    }
}

extension VerificationVC: MZTimerLabelDelegate {
    func timerLabel(_ timerLabel: MZTimerLabel!, customTextToDisplayAtTime time: TimeInterval) -> String! {
        if !time.isNaN {
            let leftTime = Int(time)
            self.timeLeft = leftTime
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.unitsStyle = .positional

            let formattedString = formatter.string(from: TimeInterval(leftTime))!
            return "\(formattedString)"
        } else {
            return "\(0)"
        }
  
    }

    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval) {
        resendButton.isUserInteractionEnabled = true
    }
    

}
