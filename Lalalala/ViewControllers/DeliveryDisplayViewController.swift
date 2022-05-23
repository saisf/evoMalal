//
//  ViewController.swift
//  Lalalala
//
//  Created by Sai Leung on 5/19/22.
//

import UIKit

class DeliveryDisplayViewController: UIViewController, LoggerManager {
    
    private var deliveries: [Delivery] = []
    private let cellReuseIdentifier = Constant.TableView.cellReuseIdentifier
    var deliveryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DeliveryDisplayViewCell.self, forCellReuseIdentifier: Constant.TableView.cellReuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setUpNavigation()
        setupTableView()
        handleDeliveryData()
    }
    
    func setUpNavigation() {
        navigationItem.title = "Delivery"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
}

class DeliveryDisplayViewCell: UITableViewCell {
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobTitleDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.backgroundColor = .orange
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let countryImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(jobTitleDetailedLabel)
        contentView.addSubview(containerView)
        contentView.addSubview(countryImageView)
        setAutoLayoutConstraintForTableViewElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setAutoLayoutConstraintForTableViewElements() {
        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        jobTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        
        countryImageView.widthAnchor.constraint(equalToConstant:26).isActive = true
        countryImageView.heightAnchor.constraint(equalToConstant:26).isActive = true
        countryImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20).isActive = true
        countryImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }
}

extension DeliveryDisplayViewController {
    func subViews() {
        view.addSubview(deliveryTableView)
    }
    
    func constraints() {
        deliveryTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        deliveryTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        deliveryTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        deliveryTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupTableView() {
        deliveryTableView.delegate = self
        deliveryTableView.dataSource = self
        subViews()
        constraints()
    }
}

extension DeliveryDisplayViewController: UITableViewDelegate, UITableViewDataSource, DeliveryFavoriteHelper {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        deliveries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DeliveryDisplayViewCell
        let delivery = deliveries[indexPath.row]
        if let deliveryFee = currencyToNumber(str: delivery.deliveryFee), let surcharge = currencyToNumber(str: delivery.surcharge) {
            let total = deliveryFee + surcharge
            cell.jobTitleDetailedLabel.text = "$" + String(format: "%.2f", total)
        }
        if let url = URL(string: delivery.goodsPicture) {
            cell.profileImageView.imageFrom(url: url)
        }
        if deliveryIsFavorited(id: delivery.id) {
            cell.countryImageView.tintColor = .orange
            cell.countryImageView.image = UIImage(systemName: Constant.SystemImage.star)
        } else {
            cell.countryImageView.image = nil
        }
        cell.nameLabel.text = delivery.sender.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DeliveryDisplayViewCell
        let vc = DeliveryDetailViewController()
        vc.delivery = deliveries[indexPath.row]
        vc.userImageView.image = cell.profileImageView.image

        if let totalText = cell.jobTitleDetailedLabel.text {
            vc.totalLabel.text = "Total: \(totalText)"
        }
        
        if let phone = vc.delivery?.sender.phone {
            vc.phoneLabel.text = "Phone: " + phone
        }
        
        if let email = vc.delivery?.sender.email {
            vc.emailLabel.text = "Email: " + email
        }
        
        if let pickupTime = vc.delivery?.pickupTime {
            vc.pickupTimeLabel.text = "Pickup Time: " + pickupTime
        }
        
        if let routeStart = vc.delivery?.route.start {
            vc.routeStartLabel.text = "Route Start: " + routeStart
        }
        
        if let roundEnd = vc.delivery?.route.end {
            vc.routeEndLabel.text = "Route End: " + roundEnd
        }
        
        if let remarks = vc.delivery?.remarks {
            vc.remarksLabel.text = "Remarks: " + remarks
        }
        
        vc.navigationItem.title = cell.nameLabel.text
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func currencyToNumber(str: String) -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.number(from: str)?.doubleValue
    }
}

// MARK: - Delivery Data Handling
extension DeliveryDisplayViewController {
    
    // MARK: - Fetch Delivery Data
    func fetchDeliveryData(completion: @escaping (Result<[Delivery], Error>) -> Void) {
        guard let url = URL(string: Constant.API.host) else {
            self.log(type: .error, category: .network, message: NetworkError.badURL.localizedDescription)
            completion(.failure(NetworkError.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle HTTP request error
                self.log(type: .error, category: .network, message: error.localizedDescription)
                completion(.failure(error))
            } else if let data = data {
                // Handle HTTP request response
                let decoder = JSONDecoder()
                do {
                    let json: [Delivery] = try decoder.decode([Delivery].self, from: data)
                    completion(.success(json))
                } catch let DecodingError.dataCorrupted(context) {
                    self.log(type: .error, category: .network, message: "\(NetworkError.dataCorrupted.localizedDescription): \(context.debugDescription)")
                    completion(.failure(NetworkError.dataCorrupted))
                } catch let DecodingError.keyNotFound(key, context) {
                    self.log(type: .error, category: .network, message: "\(NetworkError.keyNotFound.localizedDescription): \(context.debugDescription) Key \(key) not found: CodingPath: \(context.codingPath))" )
                    completion(.failure(NetworkError.keyNotFound))
                } catch let DecodingError.valueNotFound(value, context) {
                    self.log(type: .error, category: .network, message: "\(NetworkError.valueNotFound.localizedDescription) Value \(value) not found: \(context.debugDescription) codingPath: \(context.codingPath)")
                    completion(.failure(NetworkError.valueNotFound))
                } catch let DecodingError.typeMismatch(type, context)  {
                    self.log(type: .error, category: .network, message: "\(NetworkError.typeMismatch.localizedDescription) Type \(type) mismatch: \(context.debugDescription) codingPath: \(context.codingPath)")
                    completion(.failure(NetworkError.typeMismatch))
                } catch {
                    self.log(type: .error, category: .network, message: "\(NetworkError.unknown.localizedDescription) \(error.localizedDescription)")
                    completion(.failure(error))
                }
            } else {
                self.log(type: .error, category: .network, message: NetworkError.unknown.localizedDescription)
                completion(.failure(NetworkError.unknown))
            }
        }.resume()
    }
    
    // MARK: - Handle Delivery Data After Fetching
    func handleDeliveryData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            self.fetchDeliveryData { result in
                switch result {
                case .success(let deliveries):
                    DispatchQueue.main.async {
                        self.deliveries = deliveries
                        self.deliveryTableView.reloadData()
                    }
                case .failure(let error):
                    // This can be handled in different way, but for example, this will just simply show alert with error message
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}







