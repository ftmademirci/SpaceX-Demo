//
//  SliderViewController.swift
//  SpaceX Demo
//
//  Created by Admin on 28.11.2020.
//

import UIKit

class SliderViewController: BaseViewController {
    
    var viewModel: SliderViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SliderViewModel(api: API())
        self.fetchUpcoming()
        
        self.setTimer()
        self.pageControl.currentPageIndicatorTintColor = .black
        self.collectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")

    }
    
    func fetchUpcoming() {
        self.viewModel.fetchUpcoming(success: {
            self.collectionView.reloadData()
        }, failure: { error in
            print(error!)
        })
    }
    
    func setTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextPage (){
        let pageWidth:CGFloat = self.collectionView.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(viewModel.getRowCount())
        let contentOffset:CGFloat = self.collectionView.contentOffset.x

        var slideToX = contentOffset + pageWidth

        if  contentOffset + pageWidth == maxWidth {
                slideToX = 0
        }

        self.collectionView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.collectionView.frame.height), animated: true)
    }
}

extension SliderViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = self.viewModel.getRowCount()
        self.pageControl.numberOfPages = count
        self.pageControl.isHidden = !(count > 1)
        
        return count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        if let item = self.viewModel.getRowHeader(indexPath.row) {
            cell.sliderImageView.kf.setImage(with: URL(string: item.links?.mission_patch ?? ""), placeholder: UIImage(named: "no-photo.png"))
            cell.sliderTitle.text = item.mission_name
        }
    
        return cell
    }
}

extension SliderViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl?.currentPage = Int(roundedIndex)
        self.setTimer()
    }
    
}

extension SliderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

