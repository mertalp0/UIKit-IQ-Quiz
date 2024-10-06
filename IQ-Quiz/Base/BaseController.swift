//
//  BaseController.swift
//  IQ-Quiz
//
//  Created by mert alp on 19.08.2024.
//
import UIKit
import Combine



class BaseViewController <CoordinatorType: BaseCoordinator, ViewModelType: BaseViewModel>: UIViewController {
    // MARK: - Properties
    private var gradientLayer: CAGradientLayer!
    var coordinator: CoordinatorType?
    var viewModel: ViewModelType
    private var cancellables = Set<AnyCancellable>()
    private var loadingView: UIView?
    private var errorView: UIView?
    
    // MARK: - LifeCycle
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Handle view WillAppear if needed
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Handle view appearance if needed
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Handle view disappearance if needed
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Handle view disappearance if needed
    }
}

//MARK: - Helpers
extension BaseViewController {
  
    //MARK: - Setup Gradient Layer
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#1E1E24").cgColor,
            UIColor(hex: "#5A189A").cgColor,
            UIColor(hex: "#48BFE3").cgColor,
            UIColor(hex: "#1E1E24").cgColor
        ]

        gradientLayer.locations = [0.0, 0.4,0.6, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
       
    }
   
}

//MARK: -  Loading
extension BaseViewController {
    
    func showLoading() {
        DispatchQueue.main.async {
            if self.loadingView == nil {
                self.loadingView = UIView(frame: self.view.bounds)
                self.loadingView?.backgroundColor = UIColor(white: 0, alpha: 0.5)
                let activityIndicator = UIActivityIndicatorView(style: .large)
                activityIndicator.center = self.loadingView?.center ?? .zero
                activityIndicator.color = .white
                activityIndicator.startAnimating()
                self.loadingView?.addSubview(activityIndicator)
                self.view.addSubview(self.loadingView!)
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
    }
}

//MARK: -  Alerts
extension BaseViewController {
    
    func showAlert(title: String, message: String, actionTitle: String = "OK", handler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: actionTitle, style: .default) { _ in
                handler?()
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showConfirmationAlert(title: String, message: String, confirmTitle: String = "Confirm", cancelTitle: String = "Cancel", confirmHandler: (() -> Void)? = nil, cancelHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                confirmHandler?()
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelHandler?()
            }
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Bind ViewModel
extension BaseViewController {
    func bindViewModel() {
        viewModel.$errorMessage
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    self?.showAlert(title: "Error", message: message)
                }
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.showLoading()
                } else {
                    self?.hideLoading()
                }
            }
            .store(in: &cancellables)
    }
}
