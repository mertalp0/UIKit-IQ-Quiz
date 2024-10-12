//
//  OnboardinViewController.swift
//  IQ-Quiz
//
//  Created by mert alp on 12.10.2024.
//
import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController<OnboardingCoordinator,OnboardingViewModel> {
    
    private var pageViewController: UIPageViewController!
    private var pageControl = UIPageControl()
    
    
    private lazy var pages: [OnboardingPageViewController] = {
       
        let firstPage = OnboardingPageViewController(
            imageName: "Welcome1",
            title: "Welcome to the App",
            text: "Discover the amazing features of our application.",
            buttonTitle: "Next"
        )
        firstPage.delegate = self
        
        let secondPage = OnboardingPageViewController(
            imageName: "Welcome2",
            title: "Explore Features",
            text: "Learn how to use the app effectively.",
            buttonTitle: "Next"
        )
        secondPage.delegate = self
        
        let thirdPage = OnboardingPageViewController(
            imageName: "Welcome3",
            title: "Get Started",
            text: "Join us and start your journey!",
            buttonTitle: "Get Started"
        )
        thirdPage.delegate = self

        return [firstPage, secondPage, thirdPage]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        setupPageControl()
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // Önceki sayfayı döndürür
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingPageViewController), index > 0 else {
            return nil // Önceki sayfa yoksa nil döndür
        }
        return pages[index - 1] // Önceki sayfayı döndür
    }
    
    // Sonraki sayfayı döndürür
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingPageViewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
    
    // Sayfa geçişi tamamlandığında çağrılır
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentVC = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: currentVC as! OnboardingPageViewController) {
            pageControl.currentPage = index
        }
    }
}


extension OnboardingViewController: OnboardingPageDelegate {
    func didTapNextButton(on page: OnboardingPageViewController) {
        guard let currentIndex = pages.firstIndex(of: page) else { return }
        let nextIndex = currentIndex + 1
        
        if nextIndex < pages.count {
            pageViewController.setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
            pageControl.currentPage = nextIndex
        }
        else {
            viewModel.onboardingTrue()
            coordinator?.showStart()
        }
    }
}
