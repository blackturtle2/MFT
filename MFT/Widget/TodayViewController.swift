//
//  TodayViewController.swift
//  Widget
//
//  Created by leejaesung on 2018. 1. 14..
//  Copyright © 2018년 blackturtle2. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var button1stText: UIButton!
    @IBOutlet weak var button2ndText: UIButton!
    @IBOutlet weak var button3rdText: UIButton!
    @IBOutlet weak var button4thText: UIButton!
    @IBOutlet weak var button5thText: UIButton!
    
    @IBOutlet weak var labelResult: UILabel!
    
    var savedTextDataArray:[MFT_Text]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureData()
        self.configureUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    
    // MARK: - function
    func configureData() {
        if let data00 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text00") as? [String:String],
            let data01 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text01") as? [String:String],
            let data02 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text02") as? [String:String],
            let data03 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text03") as? [String:String],
            let data04 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text04") as? [String:String] {
            
            self.savedTextDataArray = [MFT_Text(withDicData: data00)]
            self.savedTextDataArray?.append(MFT_Text(withDicData: data01))
            self.savedTextDataArray?.append(MFT_Text(withDicData: data02))
            self.savedTextDataArray?.append(MFT_Text(withDicData: data03))
            self.savedTextDataArray?.append(MFT_Text(withDicData: data04))
        }
        
    }
    
    func configureUI() {
        guard let realSavedTextDataArray = savedTextDataArray else { return }
        
        self.button1stText.setImage(UIImage(named: realSavedTextDataArray[0].iconImageName), for: .normal)
        self.button2ndText.setImage(UIImage(named: realSavedTextDataArray[1].iconImageName), for: .normal)
        self.button3rdText.setImage(UIImage(named: realSavedTextDataArray[2].iconImageName), for: .normal)
        self.button4thText.setImage(UIImage(named: realSavedTextDataArray[3].iconImageName), for: .normal)
        self.button5thText.setImage(UIImage(named: realSavedTextDataArray[4].iconImageName), for: .normal)
    }
    
    
    
    // MARK: - IBAction function
    @IBAction func buttonCopyAction(_ sender: UIButton) {
        guard let realSavedTextDataArray = savedTextDataArray else { return }
        
        switch sender {
        case self.button1stText:
            UIPasteboard.general.string = realSavedTextDataArray[0].text
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[0].text ?? "")\""
        case self.button2ndText:
            UIPasteboard.general.string = realSavedTextDataArray[1].text
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[1].text ?? "")\""
        case self.button3rdText:
            UIPasteboard.general.string = realSavedTextDataArray[2].text
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[2].text ?? "")\""
        case self.button4thText:
            UIPasteboard.general.string = realSavedTextDataArray[3].text
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[3].text ?? "")\""
        case self.button5thText:
            UIPasteboard.general.string = realSavedTextDataArray[4].text
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[4].text ?? "")\""
            
        default:
            break
        }
    }
    
    
}
