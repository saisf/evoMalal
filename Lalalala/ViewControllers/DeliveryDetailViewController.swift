//
//  DeliveryDetailViewController.swift
//  Lalalala
//
//  Created by Sai Leung on 5/21/22.
//

import Foundation
import UIKit

class DeliveryDetailViewController: UIViewController, DeliveryFavoriteHelper {
    
    var delivery: Delivery?
    var userImageView = UIImageView()
    var totalLabel = UILabel()
    var stackView = UIStackView()
    var containerStackView = UIStackView()
    var switchButton = UISwitch()
    var phoneLabel = UILabel()
    var emailLabel = UILabel()
    var pickupTimeLabel: UILabel = UILabel()
    var routeStartLabel = UILabel()
    var routeEndLabel = UILabel()
    var remarksLabel = UILabel()
    var switchButtonStackView = UIStackView()
    var switchTextLabel = UILabel()
    var switchIsPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupAllViewElements()
        addAllArrangedSubviews()
        addAllViewConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if switchIsPressed {
            reloadPreviousVcTableViewData()
        }
    }
}

extension DeliveryDetailViewController {
    // MARK: - Setup userImageView
    fileprivate func setupUserImageView() {
        userImageView.layer.cornerRadius = 20
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFill
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.heightAnchor.constraint(equalToConstant: CGFloat(220)).isActive = true
    }
    
    // MARK: - Setup userNameLabel
    fileprivate func setupUserNameLabel() {
        totalLabel.font = UIFont.preferredFont(forTextStyle: .body)
        totalLabel.adjustsFontForContentSizeCategory = true
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Setup phoneLabel
    fileprivate func setupPhoneLabel() {
        phoneLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        phoneLabel.adjustsFontForContentSizeCategory = true
    }
    
    // MARK: - Setup emailLabel
    fileprivate func setupEmailLabel() {
        emailLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        emailLabel.adjustsFontForContentSizeCategory = true
    }
    
    // MARK: - Setup pickupTimeLabel
    fileprivate func setupPickupTimeLabel() {
        pickupTimeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        pickupTimeLabel.adjustsFontForContentSizeCategory = true
    }
    
    // MARK: - Setup routeStartLabel
    fileprivate func setupRouteStartLabel() {
        routeStartLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        routeStartLabel.adjustsFontForContentSizeCategory = true
    }
    
    // MARK: - Setup routeEndLabel
    fileprivate func setupRouteEndLabel() {
        routeEndLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        routeEndLabel.adjustsFontForContentSizeCategory = true
    }
    
    // MARK: - Setup remarksLabel
    fileprivate func setupRemarksLabel() {
        remarksLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        remarksLabel.adjustsFontForContentSizeCategory = true
        remarksLabel.numberOfLines = 5
    }
    
    // MARK: - Setup switchTextLabel
    fileprivate func setupSwitchTextLabel() {
        switchTextLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        switchTextLabel.adjustsFontForContentSizeCategory = true
        switchTextLabel.text = "Switch to favorite this"
    }
    
    // MARK: - Setup switch button
    fileprivate func setupSwitchButton() {
        switchButton.setOn(deliveryIsFavorited(id: delivery?.id ?? "") , animated: true)
        switchButton.onTintColor = .orange
        switchButton.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
    }
    
    // MARK: - Setup stackview
    fileprivate func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 2.0
        stackView.clipsToBounds = true
    }
    
    // MARK: - Setup container stackview
    fileprivate func setupContainerStackView() {
        containerStackView.center = view.center
        containerStackView.layer.cornerRadius = 15
        containerStackView.backgroundColor = .white
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Setup switch button stackview
    fileprivate func setupSwitchButtonStackView() {
        switchButtonStackView.axis = .horizontal
        switchButtonStackView.alignment = .center
        switchButtonStackView.spacing = 8
    }
    
    // MARK: - Setup all view elements
    fileprivate func setupAllViewElements() {
        setupUserImageView()
        setupUserNameLabel()
        setupPhoneLabel()
        setupEmailLabel()
        setupPickupTimeLabel()
        setupRouteStartLabel()
        setupRouteEndLabel()
        setupRemarksLabel()
        setupSwitchTextLabel()
        setupSwitchButton()
        setupStackView()
        setupContainerStackView()
        setupSwitchButtonStackView()
    }
    
    // MARK: - Add all arranged subviews
    fileprivate func addAllArrangedSubviews() {
        stackView.addArrangedSubview(userImageView)
        stackView.addArrangedSubview(totalLabel)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(pickupTimeLabel)
        stackView.addArrangedSubview(routeStartLabel)
        stackView.addArrangedSubview(routeEndLabel)
        stackView.addArrangedSubview(remarksLabel)
        
        switchButtonStackView.addArrangedSubview(switchTextLabel)
        switchButtonStackView.addArrangedSubview(switchButton)
        stackView.addArrangedSubview(switchButtonStackView)
        
        containerStackView.addSubview(stackView)
        view.addSubview(containerStackView)
    }
    
    // MARK: - Add all view constraints
    fileprivate func addAllViewConstraints() {
        var arrowConstraints : [NSLayoutConstraint] = [NSLayoutConstraint]()
        let viewSafeArea = view.safeAreaLayoutGuide
        var layoutConstraint: NSLayoutConstraint
        
        layoutConstraint = userImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10)
        arrowConstraints.append(layoutConstraint)
        layoutConstraint = userImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10)
        arrowConstraints.append(layoutConstraint)
        layoutConstraint = userImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10.0)
        arrowConstraints.append(layoutConstraint)
        
        layoutConstraint = containerStackView.leadingAnchor.constraint(equalTo: viewSafeArea.leadingAnchor, constant: 20.0)
        arrowConstraints.append(layoutConstraint)
        layoutConstraint = containerStackView.trailingAnchor.constraint(equalTo: viewSafeArea.trailingAnchor, constant: -20.0)
        arrowConstraints.append(layoutConstraint)
        layoutConstraint = containerStackView.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 20.0)
        arrowConstraints.append(layoutConstraint)
        layoutConstraint = containerStackView.bottomAnchor.constraint(equalTo: viewSafeArea.bottomAnchor, constant: -20.0)
        arrowConstraints.append(layoutConstraint)
        
        layoutConstraint = stackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 10.0)
        arrowConstraints.append(layoutConstraint)
        layoutConstraint = stackView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor, constant: -10.0)
        arrowConstraints.append(layoutConstraint)
        layoutConstraint = stackView.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 10.0)
        arrowConstraints.append(layoutConstraint)
        layoutConstraint = stackView.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: -10.0)
        arrowConstraints.append(layoutConstraint)
        
        NSLayoutConstraint.activate(arrowConstraints)
    }
    
    func reloadPreviousVcTableViewData() {
        if let count = navigationController?.viewControllers.count,
           let deliveryDisplayViewController = navigationController?.viewControllers[count - 1] as? DeliveryDisplayViewController {
            deliveryDisplayViewController.deliveryTableView.reloadData()
        }
    }
    
    @objc func switchStateDidChange(_ sender: UISwitch!) {
        if sender.isOn {
            favoriteTheDelivery(id: delivery?.id, toFavorite: true)
            switchIsPressed = true
        } else {
            favoriteTheDelivery(id: delivery?.id, toFavorite: false)
            switchIsPressed = true
        }
    }
}


