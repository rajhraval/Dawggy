//
//  HomeViewController.swift
//  Dawggy
//
//  Created by Raj Raval on 28/01/24.
//

import UIKit

final class HomeViewController: UIViewController {

    private var primaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 64
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Random Dog Generator"
        label.textAlignment = .center
        return label
    }()

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private var generateButton: DButton = {
        let button = DButton(style: .rounded)
        button.title = "Generate Dogs!"
        return button
    }()

    private var recentButton: DButton = {
        let button = DButton(style: .rounded)
        button.title = "My Recently Generated Dogs!"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    private func setup() {
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        setupStackView()
    }

    private func setupStackView() {
        view.addSubview(primaryStackView)
        primaryStackView.centerInSuperview()
        primaryStackView.addArrangedSubviews(textLabel, buttonStackView)
        buttonStackView.addArrangedSubviews(generateButton, recentButton)
        generateButton.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
        recentButton.addTarget(self, action: #selector(recentTapped), for: .touchUpInside)
    }

}

extension HomeViewController {

    @objc
    private func generateTapped(_ sender: UIButton) {
        let vc = GenerateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    private func recentTapped(_ sender: UIButton) {
        let vc = RecentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

