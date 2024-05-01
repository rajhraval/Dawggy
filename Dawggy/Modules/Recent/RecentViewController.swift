//
//  RecentViewController.swift
//  Dawggy
//
//  Created by Raj Raval on 28/04/24.
//

import Combine
import UIKit

final class RecentViewController: UIViewController {

    @UseAutoLayout
    private var primaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()

    private var collectionView: UICollectionView!

    private var removeButton: DButton = {
        let button = DButton(style: .rounded)
        button.title = "Remove All"
        return button
    }()

    private var viewModel: RecentViewModel!
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: RecentViewModel = RecentViewModel()) {
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
        viewModel.getAllImages()
        setupView()
        bind()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(primaryStackView)
        primaryStackView.pinToLeadingAndTrailingEdgesWithConstant()
        primaryStackView.centerVerticallyInSuperview()
        setupCollectionView()

    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, layout: .horizontal)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.registerCells([ImageCell.self])
        primaryStackView.addArrangedSubviews(collectionView, removeButton)
        collectionView.pinToLeadingAndTrailingEdgesWithConstant()
        collectionView.pinToTopWithConstant()
        collectionView.setHeightConstraint(300)
        removeButton.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
    }

    private func bind() {
        viewModel.$images
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                collectionView.reloadData()
            }
            .store(in: &cancellables)
    }

}

extension RecentViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = viewModel.images[indexPath.item]
        let cell: ImageCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configureCell(for: image)
        return cell
    }
    

}

extension RecentViewController {

    @objc
    private func removeTapped(_ sender: UIButton) {
        viewModel.removeAllImages()
    }

}
