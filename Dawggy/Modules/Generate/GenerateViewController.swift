//
//  GenerateViewController.swift
//  Dawggy
//
//  Created by Raj Raval on 27/04/24.
//

import Combine
import UIKit

final class GenerateViewController: UIViewController {

    private var viewModel: GenerateViewModel!

    private var cancellables: Set<AnyCancellable> = []

    @UseAutoLayout
    private var primaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()

    @UseAutoLayout
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var generateButton: DButton = {
        let button = DButton(style: .rounded)
        button.title = "Generate!"
        return button
    }()

    init(viewModel: GenerateViewModel = GenerateViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func setup() {
        setupView()
        bind()
    }

    private func setupView() {
        title = ""
        view.backgroundColor = .systemBackground
        view.addSubview(primaryStackView)
        primaryStackView.centerInSuperview()
        primaryStackView.addArrangedSubviews(imageView, generateButton)
        imageView.setWidthHeightConstraints(200)
        generateButton.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
    }

    private func bind() {
        viewModel.$dogResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let self = self else { return }
                if let url = response?.imageURL {
                    imageView.setImage(url)
                }
            }
            .store(in: &cancellables)
    }


}

extension GenerateViewController {

    @objc
    private func generateTapped(_ sender: UIButton) {
        viewModel.getRandomDog()
    }

}
