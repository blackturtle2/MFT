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
    
    var savedTextDataArray:[[String]]?
    
    
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
        // 1st
        if let data01 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_01") as? [String] {
            self.savedTextDataArray = [data01]
        }
        
        // 2nd
        if let data02 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_02") as? [String] {
            self.savedTextDataArray?.append(data02)
        }
        
        // 3rd
        if let data03 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_03") as? [String] {
            self.savedTextDataArray?.append(data03)
        }
        
        // 4th
        if let data04 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_04") as? [String] {
            self.savedTextDataArray?.append(data04)
        }
        
        // 5th
        if let data05 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_05") as? [String] {
            self.savedTextDataArray?.append(data05)
        }
        
    }
    
    func configureUI() {
        guard let realSavedTextDataArray = savedTextDataArray else { return }
        
        self.button1stText.setImage(UIImage(named: realSavedTextDataArray[0][1]), for: .normal)
        self.button2ndText.setImage(UIImage(named: realSavedTextDataArray[1][1]), for: .normal)
        self.button3rdText.setImage(UIImage(named: realSavedTextDataArray[2][1]), for: .normal)
        self.button4thText.setImage(UIImage(named: realSavedTextDataArray[3][1]), for: .normal)
        self.button5thText.setImage(UIImage(named: realSavedTextDataArray[4][1]), for: .normal)
    }
    
    
    
    // MARK: - IBAction function
    @IBAction func buttonCopyAction(_ sender: UIButton) {
        guard let realSavedTextDataArray = savedTextDataArray else { return }
        
        switch sender {
        case self.button1stText:
            UIPasteboard.general.string = realSavedTextDataArray[0][2]
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[0][2])\""
        case self.button2ndText:
            UIPasteboard.general.string = realSavedTextDataArray[1][2]
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[1][2])\""
        case self.button3rdText:
            UIPasteboard.general.string = realSavedTextDataArray[2][2]
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[2][2])\""
        case self.button4thText:
            UIPasteboard.general.string = realSavedTextDataArray[3][2]
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[3][2])\""
        case self.button5thText:
            UIPasteboard.general.string = realSavedTextDataArray[4][2]
            self.labelResult.text = "Copied: \"\(realSavedTextDataArray[4][2])\""
            
        default:
            break
        }
    }
    
    
}
