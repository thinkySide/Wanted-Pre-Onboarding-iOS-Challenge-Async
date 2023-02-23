//
//  ViewController.swift
//  Wanted-Pre-Onboarding-iOS-Challenge
//
//  Created by 김민준 on 2023/02/23.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlet
    
    
    
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    // MARK: - IBAction
    
    @IBAction func loadButtonTapped(_ sender: UIButton) {
        // 1. 서버 통신 (비동기)
        // 2. 이미지 표시
    }
    
    
    @IBAction func loadAllImageButtonTapped(_ sender: UIButton) {
        // 1. 서버 통신
        // 2. 모든 UIImage 다운로드 (동시큐에 올리기)
        // 3. 이미지 표시
    }
    
}

