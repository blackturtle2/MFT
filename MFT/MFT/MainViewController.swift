//
//  MainViewController.swift
//  MFT
//
//  Created by leejaesung on 2018. 1. 14..
//  Copyright © 2018년 blackturtle2. All rights reserved.
//

import UIKit
import Toaster

class MainViewController: UIViewController, AddTextViewControllerDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var grayBGView: UIView!
    
    var savedTextDataArray:[[String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate & dataSource
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        // 텍스트 추가 버튼 코너 라운드 먹이기.
        self.buttonAdd.layer.cornerRadius = self.buttonAdd.frame.width / 2
        
        self.configureUserDefaults()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: 앱 처음 실행시, UserDefaults 초기화
    func configureUserDefaults() {
        // 1: 통장
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_01") == nil {
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(["MFT_01", "ic_payment_48pt","MyBank 123-456789-00"], forKey: "MFT_01")
        }
        if let data01 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_01") as? [String] {
            self.savedTextDataArray = [data01]
        }
        
        // 2: 집 주소
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_02") == nil {
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(["MFT_02", "ic_home_48pt","161, Sajik-ro, Jongno-gu, Seoul, Republic of Korea"], forKey: "MFT_02")
        }
        if let data02 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_02") as? [String] {
            self.savedTextDataArray?.append(data02)
        }
        
        // 3: 이메일
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_03") == nil {
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(["MFT_03", "ic_email_48pt","my_email@address.com"], forKey: "MFT_03")
        }
        if let data03 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_03") as? [String] {
            self.savedTextDataArray?.append(data03)
        }
        
        // 4: 폰 넘버
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_04") == nil {
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(["MFT_04", "ic_phone_iphone_48pt","010-0516-0412"], forKey: "MFT_04")
        }
        if let data04 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_04") as? [String] {
            self.savedTextDataArray?.append(data04)
        }
        
        // 5: 인스타그램
        if UserDefaults.init(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_05") == nil {
            UserDefaults(suiteName: Constants.savedUserDefaults)?.set(["MFT_05", "ic_camera_alt_48pt","#travel #traveller #travelgram #blogger #sunshine #holidays #vacation #trips #instalove #Seoul #Korea"], forKey: "MFT_05")
        }
        if let data05 = UserDefaults(suiteName: Constants.savedUserDefaults)?.value(forKey: "MFT_05") as? [String] {
            self.savedTextDataArray?.append(data05)
        }
        
        self.mainTableView.reloadData()
    }

    // MARK: 질문 버튼 Action.
    @IBAction func buttonQuestionAciton(_ sender: Any) {
        
    }
    
    // MARK: 텍스트 추가 버튼 Action
    @IBAction func buttonAddAction(_ sender: UIButton) {
        self.grayBGView.isHidden = false
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTextViewController") as! AddTextViewController
        nextVC.delegate = self
        
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // MARK: AddTextViewControllerDelegate's function.
    func completeAddText() {
        self.grayBGView.isHidden = true
        self.configureUserDefaults()
        self.mainTableView.reloadData()
    }
    
}


// MARK: extension: UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedTextDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultCell = tableView.dequeueReusableCell(withIdentifier: "MainTextListCell", for: indexPath) as! MainTextListCell
        guard let realSavedTextDataArray = self.savedTextDataArray else { return resultCell }
        let currentData = realSavedTextDataArray[indexPath.row]
        
        resultCell.thisData = realSavedTextDataArray[indexPath.row]
        resultCell.imageViewIcon.image = UIImage(named: currentData[1])
        resultCell.labelText.text = currentData[2]
        
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let resultCell = tableView.cellForRow(at: indexPath) as! MainTextListCell
        
        // UI
        self.grayBGView.isHidden = false
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTextViewController") as! AddTextViewController
        nextVC.delegate = self
        nextVC.thisData = resultCell.thisData
        
        self.present(nextVC, animated: true, completion: nil)
    }
    
}
