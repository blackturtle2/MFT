//
//  AddTextViewController.swift
//  MFT
//
//  Created by leejaesung on 2018. 1. 14..
//  Copyright © 2018년 blackturtle2. All rights reserved.
//

import UIKit

protocol AddTextViewControllerDelegate {
    func completeAddText()
}

class AddTextViewController: UIViewController {
    
    @IBOutlet weak var seperatedView: UIView!
    @IBOutlet weak var collectionViewSelectIcon: UICollectionView!
    @IBOutlet weak var textFieldMyFavoriteText: UITextField!
    @IBOutlet weak var buttonComplete: UIButton!
    
    @IBOutlet weak var constraintContentsViewHeight: NSLayoutConstraint!
    
    var thisData: [String]?
    
    let iconArray = ["ic_payment_48pt",
                     "ic_home_48pt",
                     "ic_work_48pt",
                     "ic_phone_iphone_48pt",
                     "ic_email_48pt",
                     "ic_https_48pt",
                     "ic_airplanemode_active_48pt",
                     "ic_book_48pt",
                     "ic_camera_alt_48pt",
                     "ic_directions_car_48pt",
                     "ic_favorite_48pt",
                     "ic_favorite_border_48pt",
                     "ic_grade_48pt",
                     "ic_map_48pt",
                     "ic_motorcycle_48pt",
                     "ic_account_balance_48pt",
                     "ic_person_48pt",
                     "ic_place_48pt",
                     "ic_restaurant_48pt",
                     "ic_store_mall_directory_48pt",
                     "ic_wifi_48pt",
                     "ic_business_48pt"]
    
    var selectedIconString = "ic_payment_48pt" // 첫 선택 아이콘
    
    var delegate: AddTextViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // delegate & dataSource.
        self.collectionViewSelectIcon.delegate = self
        self.collectionViewSelectIcon.dataSource = self
        
        // 텍스트 입력하는 뷰의 위에 코너 라운드 먹인 뚜껑 부분의 뷰.
        self.seperatedView.layer.borderColor = UIColor.black.cgColor
        self.seperatedView.layer.cornerRadius = 12
        
        // 완료 버튼의 코너 라운드 먹이기.
        self.buttonComplete.layer.cornerRadius = 8
        
        // 키보드 Notification 등록.
        self.addKeyboardNotificationObserver()
        
        if let realThisData = self.thisData {
            self.selectedIconString = realThisData[1]
            self.textFieldMyFavoriteText.text = realThisData[2]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: 키보드 올리기 내리기 노티피케이션 옵저버 등록
    func addKeyboardNotificationObserver() {
        // show keyboard
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AddTextViewController.keyboardWillShowOrHide(notification:)),
            name: .UIKeyboardWillShow,
            object: nil)
        
        // hide keyboard
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(AddTextViewController.keyboardWillShowOrHide(notification:)),
//            name: .UIKeyboardWillHide,
//            object: nil)
    }
    
    
    // MARK: 키보드 올리기 & 내리기
    @objc func keyboardWillShowOrHide(notification: Notification) {
        print("///// keyboardWillShowOrHide")
        
        // keyboard hide: guard-let으로 nil 값이면, 키보드를 내립니다. - MFT에서는 키보드 내릴 필요가 없습니다.
        guard let userInfo = notification.userInfo else {
            print("///// keyboard hide-!")
//            self.view.layoutIfNeeded() // UIView layout 새로고침.
            return
        }
        
        // keyboard show: notification.userInfo를 이용해 키보드가 올라올 때, self.view를 같이 올립니다.
        print("///// keyboard show-!")
        
        let animationDuration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animationCurve = UIViewAnimationOptions(rawValue: (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uintValue << 16)
        let frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            options: [.beginFromCurrentState, animationCurve],
            animations: {
                // self.view의 height 자체를 조정합니다.
                if let realWindow = self.view.window {
                    self.view.frame.size.height -= (self.view.bounds.maxY - realWindow.convert(frameEnd, to: self.view).minY)
                    self.view.layoutIfNeeded()
                }
                
        },
            completion: { (isCompletion) in
                print("///// complete animation: ", isCompletion)
        }
        )
    }
    
    
    // MARK: 뷰를 종료하는 Tap Gesture Action 정의.
    @IBAction func tapGestureBackgroundViewAction(_ sender: UITapGestureRecognizer) {
        
        self.dismiss(animated: true) {
            self.delegate.completeAddText()
        }
    }
    
    
    // MARK: Done 버튼 액션 function
    @IBAction func buttonDoneAction(_ sender: UIButton) {
        guard let realThisData = self.thisData else { return }
        let realSelectedIconString = self.selectedIconString
        let realMyFavoriteText = self.textFieldMyFavoriteText.text
        
        UserDefaults(suiteName: Constants.savedUserDefaults)?.set([realThisData[0],
                                                                   realSelectedIconString,
                                                                   realMyFavoriteText], forKey: realThisData[0])
        
        self.dismiss(animated: true) {
            self.delegate.completeAddText()
        }
    }
    

}


// MARK: - extension: UICollectionViewDelegate, UICollectionViewDataSource
extension AddTextViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.iconArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let resultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddTextSelectIconCollectionViewCell", for: indexPath) as! AddTextSelectIconCollectionViewCell
        resultCell.imageViewIcon.image = UIImage(named: self.iconArray[indexPath.row])
        resultCell.selectedIconName = self.iconArray[indexPath.row]
        
        // 선택한 아이콘만 체크 아이콘이 활성화되도록 설정.
        if resultCell.selectedIconName == self.selectedIconString {
            resultCell.imageViewRedCheck.isHidden = false
        }else {
            resultCell.imageViewRedCheck.isHidden = true
        }
        
        return resultCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! AddTextSelectIconCollectionViewCell
        
        // 레드 체크 버튼 활성화.
        selectedCell.imageViewRedCheck.isHidden = false
        
        // 선택한 아이콘 네임 저장.
        self.selectedIconString = selectedCell.selectedIconName
        
        // 다른 cell의 레드 체크 버튼 비활성화를 위한 콜렉션뷰 reload.
        self.collectionViewSelectIcon.reloadData()
        
    }
    
}
