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
        
        // 컴포넌트 잡기
        guard
            let stackView = sender.superview as? UIStackView,
            let superStackView = stackView.superview as? UIStackView,
            let imageView = stackView.arrangedSubviews[0] as? UIImageView
        else { return }
        
        // 내가 클릭한 StackView의 Index 구하기
        let stackViewList = superStackView.arrangedSubviews
        for (index, stackView) in stackViewList.enumerated() {
            if let clickedStackView = stackView as? UIStackView, clickedStackView.arrangedSubviews[2] == sender {
                print("Clicked index: \(index)")
                break
            }
        }
        
        imageView.backgroundColor = .systemRed
        
        
        
        // 1. 서버 통신 (비동기)
        // 2. 이미지 표시
    }
    
    
    @IBAction func loadAllImageButtonTapped(_ sender: UIButton) {
        // 1. 서버 통신
        // 2. 모든 UIImage 다운로드 (동시큐에 올리기)
        // 3. 이미지 표시
    }
    
}

