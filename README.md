# Wanted-Pre-Onboarding-iOS-Challenge
원티드 프리온보딩 iOS 챌린지 코드입니다.

## I. 챌린지 내용
다음 gif 보고 기능 만들기 (동시성 프로그래밍)

<img width="300" src="https://user-images.githubusercontent.com/113565086/221114273-ac116d6a-a385-48d4-ac2b-7df3fe835eb6.gif">


## II. 기능 정의
- ✅ UI 디자인 (Storyboard 기반 Autolayout) 
- 서버 통신 (이미지 다운로드 및 표시)
- 동시큐 사용, 모든 이미지 표시
- progress bar 다운로드 전 0, 다운르도 후 100 (애니메이션도 줘보기)

## III. Trouble Shooting
### 1. 클릭한 StackView의 Index 구하기
현재 구성한 StackView UI 계층구조는 다음과 같습니다.

<img width="600" src="https://user-images.githubusercontent.com/113565086/221113474-528e7f00-5540-459d-b4a6-8e87ebe0d5d4.jpeg">

클릭한 UIButton의 상위 StackView가 SuperStackView의 몇번째 index 인지 구하는 코드입니다.
~~~swift
// loadButton은 각 버튼에 모두 연결해두었음.
 @IBAction func loadButtonTapped(_ sender: UIButton) {
        
        // 컴포넌트 잡기
        guard
            let stackView = sender.superview as? UIStackView,
            let superStackView = stackView.superview as? UIStackView
        else { return }
        
        // 내가 클릭한 StackView의 Index 구하기
        let stackViewList = superStackView.arrangedSubviews
        for (index, stackView) in stackViewList.enumerated() { // StackView 열거
        
            // loadButtonTapped의 파라미터 sender(UIButton)가 clickedStackView의 2번째 인덱스와 일치하다면 출력
            if let clickedStackView = stackView as? UIStackView, clickedStackView.arrangedSubviews[2] == sender {
                print("Clicked index: \(index)")
                break
            }
        }
    }
~~~
