//
//  ViewController.swift
//  Wanted-Pre-Onboarding-iOS-Challenge
//
//  Created by 김민준 on 2023/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variable
    var currentIndex = 0
    let imageURL = [
        "https://user-images.githubusercontent.com/113565086/221117769-7bd8f46a-965f-4674-b430-f4e5ef6c6105.png",
        "https://user-images.githubusercontent.com/113565086/221118961-5004600b-b0ea-4783-86fd-be3d9fd18502.png",
        "https://user-images.githubusercontent.com/113565086/221119071-11e8886c-fe8e-49cb-b88d-1be8be81fe77.png",
        "https://user-images.githubusercontent.com/113565086/221119002-33eab713-c594-4840-a774-f2d87e8b20cb.png",
        "https://user-images.githubusercontent.com/113565086/221119144-f2a4e119-921e-45ae-b938-c0a36ae30e44.png"
    ]
    
    
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
                currentIndex = index
                break
            }
        }
        
        imageUpdate(imageView: imageView)

    }
    
    func imageUpdate(imageView: UIImageView) {
        
        // 현재 선택된 index의 이미지 URL
        guard let url = URL(string: imageURL[currentIndex]) else { return }
        
        // 글로벌 큐에서 이미지 불러오기
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!)
            
            // 화면 업데이트는 메인큐에서 진행
            DispatchQueue.main.async {
                imageView.image = image
            }
            
        }
    }
    
    
    @IBAction func loadAllImageButtonTapped(_ sender: UIButton) {
        // 1. 서버 통신
        // 2. 모든 UIImage 다운로드 (동시큐에 올리기)
        // 3. 이미지 표시
    }
    
}

