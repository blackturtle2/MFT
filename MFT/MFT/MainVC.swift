//
//  MainVC.swift
//  MFT
//
//  Created by leejaesung on 2018. 1. 14..
//  Copyright © 2018년 blackturtle2. All rights reserved.
//

import UIKit
import Toaster

class MainVC: UIViewController, AddTextViewControllerDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var grayBGView: UIView!
    
    var savedTextDataArray:[MFT_Text]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate & DataSource
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        // UI: 텍스트 추가 버튼 코너 라운드 먹이기.
        self.buttonAdd.layer.cornerRadius = self.buttonAdd.frame.width / 2
        
        // Configure: User Defaults.
        self.configureUserDefaults()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: 앱 처음 실행시, UserDefaults 초기화
    func configureUserDefaults() {
        // 00: 통장
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "text00") == nil {
            let data = MFT_Text(keyID: "text00",
                                iconImageName: "ic_payment_48pt",
                                text: "MyBank 123-456789-00")
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(data.getDicData(), forKey: "text00")
        }
        
        // 01: 집 주소
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "text01") == nil {
            let data = MFT_Text(keyID: "text01",
                                iconImageName: "ic_home_48pt",
                                text: "161, Sajik-ro, Jongno-gu, Seoul, Republic of Korea")
            
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(data.getDicData(), forKey: "text01")
        }
        
        // 02: 이메일
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "text02") == nil {
            let data = MFT_Text(keyID: "text02",
                                iconImageName: "ic_email_48pt",
                                text: "my_email@address.com")
            
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(data.getDicData(), forKey: "text02")
        }
        
        // 03: 폰 넘버
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "text03") == nil {
            let data = MFT_Text(keyID: "text03",
                                iconImageName: "ic_phone_iphone_48pt",
                                text: "010-0516-0412")
            
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(data.getDicData(), forKey: "text03")
        }
        
        // 04: 인스타그램
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "text04") == nil {
            let data = MFT_Text(keyID: "text04",
                                iconImageName: "ic_camera_alt_48pt",
                                text: "#travel #traveller #travelgram #blogger #sunshine #holidays #vacation #trips #instalove #Seoul #Korea")
            
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(data.getDicData(), forKey: "text04")
        }
        
        // 전역 변수 초기화
        if let data00 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text00") as? [String : String],
            let data01 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text01") as? [String : String],
            let data02 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text02") as? [String : String],
            let data03 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text03") as? [String : String],
            let data04 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "text04") as? [String : String] {
            
            self.savedTextDataArray = [MFT_Text(withDicData: data00)]
            self.savedTextDataArray?.append(MFT_Text(withDicData: data01))
            self.savedTextDataArray?.append(MFT_Text(withDicData: data02))
            self.savedTextDataArray?.append(MFT_Text(withDicData: data03))
            self.savedTextDataArray?.append(MFT_Text(withDicData: data04))
        }
        
        self.mainTableView.reloadData()
    }

    // MARK: 질문 버튼 Action.
    @IBAction func buttonQuestionAciton(_ sender: Any) {
        
    }
    
    // MARK: 텍스트 추가 버튼 Action
    @IBAction func buttonAddAction(_ sender: UIButton) {
        self.grayBGView.isHidden = false
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTextViewController") as! AddTextVC
        nextVC.delegate = self
        
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // MARK: AddTextViewControllerDelegate's function.
    func completeAddText() {
        self.grayBGView.isHidden = true
        self.configureUserDefaults()
        self.mainTableView.reloadData()
        
        Toast(text: "Saved complete-!").show()
    }
    
}


// MARK: extension: UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedTextDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultCell = tableView.dequeueReusableCell(withIdentifier: "MainTextListCell", for: indexPath) as! MainTextListCell
        guard let realSavedTextDataArray = self.savedTextDataArray else { return resultCell }
        let currentData = realSavedTextDataArray[indexPath.row]
        
        resultCell.thisData = realSavedTextDataArray[indexPath.row]
        resultCell.imageViewIcon.image = UIImage(named: currentData.iconImageName)
        resultCell.labelText.text = currentData.text
        
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let resultCell = tableView.cellForRow(at: indexPath) as! MainTextListCell
        
        // UI
        self.grayBGView.isHidden = false
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTextViewController") as! AddTextVC
        nextVC.delegate = self
        nextVC.thisData = resultCell.thisData
        
        self.present(nextVC, animated: true, completion: nil)
    }
    
}
