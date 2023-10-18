//
//  BadgeView.swift
//  Movie List
//
//  Created by Muhammad Ariful islam on 17/10/23.
//


import UIKit

class BadgeView {
    let badgeButton: UIButton
    let badgeSize: CGFloat = 20
    let badgeTag = 9830384
    
    init(badgeButton: UIButton) {
        self.badgeButton = badgeButton
    }

    func badgeLabel(withCount count: Int) -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .systemRed
        badgeCount.text = String(count)
        return badgeCount
    }

    func accept(changed cartCount: Int) {
        showBadge(withCount: cartCount)
    }

    func showBadge(withCount count: Int) {
        let badge = badgeLabel(withCount: count)
        badgeButton.addSubview(badge)

        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: badgeButton.leftAnchor, constant: 24),
            badge.topAnchor.constraint(equalTo: badgeButton.topAnchor, constant: 0),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])

        badge.layer.zPosition = 1
    }

    func removeBadge() {
        if let badge = badgeButton.viewWithTag(badgeTag) {
            badge.removeFromSuperview()
        }
    }
}

