//
//  EarthquakeListCell.swift
//  Earthquakes
//
//  Created by Oleksandr Pronin on 10.02.20.
//  Copyright © 2020 pronin. All rights reserved.
//

import UIKit

class EarthquakeListCell: BaseTableViewCell {
    // MARK: - Public
    public override class func height() -> CGFloat { 64 }
    // MARK: - ConfigurableView
    override func configure(with viewModel: DisplayedItemProtocol) -> ConfigurableView {
        if let hasIconImage = viewModel as? DisplayedItemHasIconImage {
            if let iconImage = hasIconImage.iconImage {
                self.iconImageView.image = iconImage
            } else {
                self.iconImageView.image = nil
            }
        }
        if let hasTitle = viewModel as? DisplayedItemHasTitle, let title = hasTitle.title {
            self.titleLabel.text = title
        } else {
            self.titleLabel.text = nil
        }
        if let hasSubtitle = viewModel as? DisplayedItemHasSubtitle, let subtitle = hasSubtitle.subtitle {
            self.subtitleLabel.text = subtitle
        } else {
            self.subtitleLabel.text = nil
        }
        return self
    }
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // titleLabel
        do {
            self.titleLabel.font = UIFont.brand(font: .regular, withSize: .h5)
        }
        // subtitleLabel
        do {
            self.subtitleLabel.textColor = .lightGray
            self.subtitleLabel.font = UIFont.brand(font: .regular, withSize: .h6)
        }
        // rightImageView
        do {
            self.rightImageView.imageColor = .lightGray
        }
    }
    // MARK: - Private
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
}
