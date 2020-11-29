//
//  DetailViewController.swift
//  SpaceX Demo
//
//  Created by Admin on 25.11.2020.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var viewModel: DetailViewModel!
    
    @IBOutlet weak var launchImageView: UIImageView!
    @IBOutlet weak var launchTitle: UILabel!
    @IBOutlet weak var launchDetail: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    
    var flight_number: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "SpaceX"
        self.viewModel = DetailViewModel(api: API())
        self.getDetail(flightNumber: flight_number)

    }
    
    func getDetail(flightNumber: Int) {
        self.viewModel.getDetail(flightNumber: flightNumber, success: {
            self.launchTitle.text = self.viewModel.launch?.mission_name
            self.launchDetail.text = self.viewModel.launch?.details
            self.launchImageView.kf.setImage(with: URL(string: self.viewModel.launch?.links?.mission_patch ?? ""))
            self.launchDate.text = self.dateFormatter(timestamp: TimeInterval(self.viewModel.launch?.launch_date_unix ?? 0))
            
        }, failure: { error in
            print(error!)
        })
    }

}
