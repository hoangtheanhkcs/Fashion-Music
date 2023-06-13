//
//  ViewController.swift
//  test005
//
//  Created by hoang the anh on 31/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    private var buttonMusic: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setImage(UIImage(named: "icons8-itunes-96"), for: .normal)
        v.addTarget(self, action: #selector(didTapMusicButton), for: .touchUpInside)
        return v
    }()
    
    @objc private func didTapMusicButton(_ sender:UIButton) {
        let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    private var fashionButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setImage(UIImage(named: "icons8-fashion-58"), for: .normal)
        v.layer.cornerRadius = 40
        v.layer.borderWidth = 3
        v.layer.borderColor = CGColor(genericCMYKCyan: 0.5, magenta: 0.7, yellow: 0, black: 0, alpha: 1)
        v.layer.masksToBounds = true
        v.addTarget(self, action: #selector(didTapFashionButton), for: .touchUpInside)
        return v
    }()
    @objc private func didTapFashionButton(_ sender: UIButton) {
         let storyboard = UIStoryboard(name: "Fashion", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FashionViewController") as! FashionViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private var newsButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setImage(UIImage(named: "icons8-news-64"), for: .normal)
        v.layer.cornerRadius = 40
        v.layer.borderWidth = 3
        v.layer.borderColor = CGColor(genericCMYKCyan: 0.6, magenta: 0, yellow: 0, black: 0, alpha: 1)
        v.layer.masksToBounds = true
        v.addTarget(self, action: #selector(didTapNewsButton), for: .touchUpInside)
        return v
    }()
    
    @objc private func didTapNewsButton() {
        let storyboard = UIStoryboard(name: "RadioViewController", bundle: nil)
       let vc = storyboard.instantiateViewController(withIdentifier: "RadioViewController") as! RadioViewController
       
       navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private var logoImage:UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: "patinete-fashion-music-logo-68D2E0BEBB-seeklogo.com")
        return v
    }()
    private var bottomImage:UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: "happygirl")
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
    }
    private func setButton() {
        view.addSubview(logoImage)
        view.addSubview(buttonMusic)
        view.addSubview(fashionButton)
        view.addSubview(newsButton)
        view.addSubview(bottomImage)
        NSLayoutConstraint.activate([
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            logoImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4)
        ])
        NSLayoutConstraint.activate([
            fashionButton.widthAnchor.constraint(equalToConstant: 80),
            fashionButton.heightAnchor.constraint(equalTo: fashionButton.widthAnchor),
            fashionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            fashionButton.bottomAnchor.constraint(equalTo: bottomImage.topAnchor, constant: 50)
        ])
        NSLayoutConstraint.activate([
            buttonMusic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonMusic.bottomAnchor.constraint(equalTo: bottomImage.topAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            newsButton.widthAnchor.constraint(equalToConstant: 80),
            newsButton.heightAnchor.constraint(equalTo: newsButton.widthAnchor),
            newsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            newsButton.bottomAnchor.constraint(equalTo: bottomImage.topAnchor, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            bottomImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }

}

