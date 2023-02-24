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
    
    // MARK: - IBOutlet
    @IBOutlet weak var superStackView: UIStackView!
    
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - IBAction
    @IBAction func loadButtonTapped(_ sender: UIButton) {
        
        // 컴포넌트 잡기
        guard
            let stackView = sender.superview as? UIStackView,
            let imageView = stackView.arrangedSubviews[0] as? UIImageView
        else { return }
        
        // 이미지 초기화
        imageView.image = UIImage(systemName: "photo.fill")
        
        // 내가 클릭한 StackView의 Index 구하기
        for (index, stackView) in superStackView.arrangedSubviews.enumerated() {
            if let clickedStackView = stackView as? UIStackView, clickedStackView.arrangedSubviews[2] == sender {
                currentIndex = index
                break
            }
        }
        imageUpdate(imageView: imageView)
    }
    
    @IBAction func loadAllImageButtonTapped(_ sender: UIButton) {
        
        for (_, stackView) in superStackView.arrangedSubviews.enumerated() {
            
            // 이미지 초기화
            if let subStackView = stackView as? UIStackView, let imageView = subStackView.arrangedSubviews[0] as? UIImageView {
                imageView.image = UIImage(systemName: "photo.fill")
            }
            
        }

        
        
//        imageView.image = UIImage(systemName: "photo.fill")
        
        //        // 모든 이미지 다운로드 대기열에 올리기
        //        DispatchQueue.global().async { [weak self] in
        //
        //            guard let self = self else { return }
        //
        //            for _ in 1...self.imageURL.count {
        //                self.imageUpdate(imageView: imageView)
        //            }
        //        }
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

