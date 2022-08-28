//
//  ViewController.swift
//  TimerHW-12
//
//  Created by Илья on 28.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Elements
    
    var timer = Timer()
    let workSecond = 6
    let chillSecond = 3
    lazy var durationTimer = workSecond
    var isWorkTime = true
    var isStarted = false
    var durationTimeMs = Int()
    let shapeLayer = CAShapeLayer()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "fon")
        return image
    }()
    
    private lazy var labelTimer: UILabel = {
        let label = UILabel()
        label.text = "6"
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 60)
        return label
    }()
    
    private lazy var buttonStart: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play-button"), for: .normal)
        button.addTarget(self, action: #selector(buttonStartTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarhy()
        makeConstrains()
        animationCircular()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }
    
    //MARK: - Setup
    
    private func setupHierarhy() {
        view.addSubview(imageView)
        view.addSubview(labelTimer)
        view.addSubview(buttonStart)
    }
    
    private func makeConstrains() {
        imageView.snp.makeConstraints { make in
            make.right.left.top.bottom.equalToSuperview()
        }
        
        labelTimer.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        buttonStart.snp.makeConstraints { make in
            make.top.equalTo(labelTimer.snp.centerY).offset(200)
            make.width.height.equalTo(70)
            make.centerX.equalTo(view)
        }
    }
    
    // MARK: - Actions
    
    @objc func buttonStartTapped () {
        if isStarted {
            buttonStart.setImage(UIImage(named: "play-button"), for: .normal)
            isStarted = false
            timer.invalidate()
            pauseAnimation(layer: shapeLayer)
        } else {
            buttonStart.setImage(UIImage(named: "pause"), for: .normal)
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            basicAnimation()
            isStarted = true
            resumeAnimation(layer: shapeLayer)
        }
    }
    
    @objc func changeMode() {
        if isWorkTime {
            labelTimer.text = "3"
            labelTimer.textColor = .systemOrange
            durationTimer = chillSecond
            basicAnimation()
            isWorkTime = false
        } else {
            labelTimer.text = "6"
            labelTimer.textColor = .systemBlue
            durationTimer = workSecond
            basicAnimation()
            isWorkTime = true
        }
    }
    
    @objc func timerAction() {
        durationTimeMs += 1
        guard durationTimeMs >= 1000 else { return }
        if durationTimer > 0 {
            durationTimer -= 1
            labelTimer.text = "\(durationTimer)"
        } else {
            changeMode()
        }
        durationTimeMs = 0
    }
}

