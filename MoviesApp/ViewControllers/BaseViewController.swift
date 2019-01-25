//
//  BaseViewController.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingView: UIView?
    var apiActivityIndicatorView: UIActivityIndicatorView?
    var noDataLabel: UILabel?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .black
    }
    
    // MARK: - Custom methods
    
    /// Show a label in center of screen when no data is found
    ///
    /// - Parameters:
    ///   - message: the message to show on the label
    ///   - color: the color to show on the label
    func showNoDataLabel(message: String, color: UIColor = .white) {
        if noDataLabel == nil {
            let bounds = self.view.bounds
            noDataLabel = UILabel(frame: CGRect(x: 25, y: 0, width: (bounds.width - 50), height: bounds.height))
            if let label = noDataLabel {
                label.numberOfLines = 0
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 16.0)
                label.textColor = color
                label.center = view.center
                label.text = message
                DispatchQueue.main.async {
                    self.view.addSubview(label)
                    self.view.sendSubviewToBack(label)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.noDataLabel?.isHidden = false
            }
        }
    }
    
    /// Hide the label when we have data
    func hideNoDataLabel() {
        DispatchQueue.main.async {
            self.noDataLabel?.isHidden = true
        }
    }
    
    /// Show a loader on any view controller
    func showLoadingIndicator() {
        if loadingView == nil {
            loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 75))
            if let loadView = loadingView {
                loadView.center = view.center
                loadView.layer.cornerRadius = 10.0
                loadView.backgroundColor = .white
                apiActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
                apiActivityIndicatorView?.color = .gray
                if let indicatorView = apiActivityIndicatorView {
                    indicatorView.hidesWhenStopped = true
                    DispatchQueue.main.async {
                        indicatorView.startAnimating()
                        indicatorView.center = loadView.convert(loadView.center, from: indicatorView)
                        loadView.addSubview(indicatorView)
                        loadView.bringSubviewToFront(indicatorView)
                    }
                }
                DispatchQueue.main.async {
                    self.view.addSubview(loadView)
                    self.view.bringSubviewToFront(loadView)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.loadingView?.isHidden = false
                self.apiActivityIndicatorView?.startAnimating()
            }
        }
    }
    
    /// Hide the loading indicator
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingView?.isHidden = true
            self.apiActivityIndicatorView?.stopAnimating()
        }
    }
}
