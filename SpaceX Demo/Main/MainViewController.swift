//
//  MainViewController.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import UIKit

class MainViewController: BaseViewController {
    
    var viewModel: MainViewModel!
    
    let activityInstance = Indicator()

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "SpaceX"
        
        self.viewModel = MainViewModel(api: API())
        self.fetchLaunch()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.register(UINib(nibName: "CollectionHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "CollectionHeaderCell")


    }
    
    func fetchLaunch() {
        self.activityInstance.showIndicator()
        self.viewModel.fetchLaunch(success: {
            self.activityInstance.hideIndicator()
            self.collectionView.reloadData()
        }, failure: { error in
            print(error!)
        })
    }

}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = self.viewModel.getRow(indexPath.row) {
            let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailVC.flight_number = item.flight_number
            detailVC.modalPresentationStyle = .popover
            detailVC.modalPresentationStyle = .overCurrentContext
            detailVC.modalTransitionStyle = .crossDissolve
            let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
            navController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.viewModel.getNextPage(indexPath.row) {
            self.fetchLaunch()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getRowCount()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderCell", for: indexPath as IndexPath) as! CollectionHeaderCell
        
        let sliderViewController = SliderViewController(nibName: "SliderViewController", bundle: nil)
        addChild(sliderViewController)
        sliderViewController.didMove(toParent: self)
        headerCell.addSubview(sliderViewController.view)
        sliderViewController.view.frame = headerCell.bounds
    
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        if let item = self.viewModel.getRow(indexPath.row) {
            cell.launchImageView.kf.setImage(with: URL(string: item.links?.mission_patch ?? ""), placeholder: UIImage(named: "no-photo.png"))
            cell.launchTitle.text = item.mission_name
            cell.launchDescription.text = item.details
            cell.launchDate.text = self.dateFormatter(timestamp: TimeInterval(item.launch_date_unix ?? 0))
        }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
