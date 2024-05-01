//
//  ImageCell.swift
//  Dawggy
//
//  Created by Raj Raval on 28/04/24.
//

import UIKit

final class ImageCell: UICollectionViewCell {

    @UseAutoLayout
    private var containerView: UIView = {
        let view = UIView()
        return view
    }()

    @UseAutoLayout
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    private func setup() {
        contentView.addSubview(containerView)
        containerView.pinToTopBottomLeadingTrailingEdgesWithConstant()
        containerView.addSubview(imageView)
        imageView.pinToTopBottomLeadingTrailingEdgesWithConstant()
    }

    func configureCell(for image: UIImage) {
        imageView.image = image
    }

}
