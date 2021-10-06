//
//  PagingViewController.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/05.
//

import UIKit

class PageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PagingViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    var pageControl: UIPageControl!
    
    var colors: [UIColor] = [.red, .orange, .yellow, .green, .blue]
    var pages: [PageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors.forEach { color in
            let page = PageView()
            page.backgroundColor = color
            pages.append(page)
        }
        
    }
}

extension PagingViewController: UIScrollViewDelegate {
    
    func setupLayout() {
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.isPagingEnabled = true
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            return scrollView
        }()
        scrollView.delegate = self
        pageControl = {
            let pageConrol = UIPageControl(frame: .zero)
            pageConrol.numberOfPages = colors.count
            pageConrol.currentPage = 0
            pageConrol.isUserInteractionEnabled = false
            pageConrol.translatesAutoresizingMaskIntoConstraints = false
            
            return pageConrol
        }()
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
    }
    
    func setupScrollView(pageWidth: CGFloat,
                         pageHeight: CGFloat,
                         pages: [PageView]) {
        
        
        scrollView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: pageWidth,
                                  height: pageHeight)
        scrollView.contentSize = CGSize(width: pageWidth*CGFloat(pages.count),
                                        height: pageHeight)
        pages.forEach { [weak self] page in
            self?.scrollView.addSubview(page)
        }
    }
}
