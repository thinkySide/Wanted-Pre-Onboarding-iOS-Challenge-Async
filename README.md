# Wanted-Pre-Onboarding-iOS-Challenge
원티드 프리온보딩 iOS 챌린지 코드입니다.

## I. 챌린지 내용
다음 gif 보고 기능 만들기 (동시성 프로그래밍)

<img width="300" src="https://user-images.githubusercontent.com/113565086/221114273-ac116d6a-a385-48d4-ac2b-7df3fe835eb6.gif">


## II. 기능 정의
- ✅ UI 디자인 (Storyboard 기반 Autolayout) 
- ✅ 서버 통신 (이미지 다운로드 및 표시)
- ✅ 동시큐 사용, 모든 이미지 표시
- 리팩토링
- [나만의 추가 챌린지] progress bar 다운로드 전 0, 다운르도 후 100 (애니메이션도 줘보기)

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

### 2. 이미지 업데이트
이미지는 Google Drive에 업로드 후, 다운로드 링크를 생성해 배열 형태로 만들었습니다.   
처음에 이미지 업데이트를 정상적으로 하지 못했었는데, URLSession을 사용하지 않아 발생한 문제였습니다.   
- Main Queue에서 UI업데이트 관련 코드 작성.
- URLSession을 이용하지 않고도 처음에 이미지 업데이트가 잘 되었었는데, 이후에 갑자기 작동 안함 (추가로 공부해야 할 내용)   

다음은 URLSession을 추가해 이미지를 업데이트하는 코드입니다.
~~~swift
@IBAction func loadButtonTapped(_ sender: UIButton) {
        
        // 컴포넌트 잡기
        guard
            let stackView = sender.superview as? UIStackView,
            let imageView = stackView.arrangedSubviews[0] as? UIImageView
        else { return }
        
        // 이미지 업데이트
        imageUpdate(imageView: imageView)
    }
    
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
~~~

### 3. GCD 사용하기
순서가 보장되지 않고 뒤죽박죽 나오고 있습니다.   
GCD를 사용하면서 우선순위를 정해주고, 큐의 특성을 다시 한번 되새겨 봐야 합니다.

<img width="600" src="https://user-images.githubusercontent.com/113565086/221193455-374dee99-de20-4d98-a3f0-a40ee937e742.jpeg">

global().async -> global().sync로 변경 후 순서를 보장했습니다.
~~~swift
@IBAction func loadAllImageButtonTapped(_ sender: UIButton) {

        for (index, stackView) in superStackView.arrangedSubviews.enumerated() {
            if let subStackView = stackView as? UIStackView, let imageView = subStackView.arrangedSubviews[0] as? UIImageView {
                
                // 이미지 초기화
                imageView.image = UIImage(systemName: "photo.fill")
                currentIndex = index
                
                // 모든 이미지 다운로드 대기열에 올리기
                DispatchQueue.global().sync { [weak self] in // 작업을 sync(동기)로 등록했기 때문에, 작업 등록 순서와 실행 순서 일치하게 됨.
                    guard let self = self else { return }
                    self.imageUpdate(imageView: imageView)
                }
            }
        }
    }
~~~
