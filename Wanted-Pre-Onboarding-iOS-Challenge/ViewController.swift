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
        "https://drive.google.com/uc?export=download&id=1F8orTckEM8vRhrqDQZu3Ycsde9H5BA7A",
        "https://drive.google.com/uc?export=download&id=15GktXfKtJuJl-nJeKPExcf11QlIlHCXA",
        "https://drive.google.com/uc?export=download&id=1FstKka8HKQQuM_YgOv5LCVVWMANCVsTm",
        "https://drive.google.com/uc?export=download&id=10DaqhTjlC9bW7VMgQQXBDGRJ-giGsvPf",
        "https://drive.google.com/uc?export=download&id=1YCxh8tYfYAwrRJbILzTotxHotEOO3pHh"
    ]
    
    
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
        
        // 이미지 초기화
        imageView.image = UIImage(systemName: "photo.fill")
        
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

    @IBAction func loadAllImageButtonTapped(_ sender: UIButton) {
        // 1. 서버 통신
        // 2. 모든 UIImage 다운로드 (동시큐에 올리기)
        // 3. 이미지 표시
    }
    
    
    // MARK: - Function
    func imageUpdate(imageView: UIImageView) {
        
        // 현재 선택된 index의 이미지 URL
        guard let url = URL(string: imageURL[currentIndex]) else { return }
        
        // URLSession
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // 에러 확인
            guard error == nil else {
                print("에러가 발생했습니다.: \(error!.localizedDescription)")
                return
            }
            
            // 데이터 확인
            guard let data = data else {
                print("데이터를 전달 받지 못했습니다.")
                return
            }
            
            // image 업데이트
            DispatchQueue.main.async { // UI업데이트는 main queue에서 진행
                let image = UIImage(data: data)
                imageView.image = image
            }
            
        }.resume()
        
    }
}

