//
//  DetailViewController.swift
//  AppleFramework
//
//  Created by 권유진 on 2022/07/15.
//

import UIKit
import SafariServices
import Combine

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @Published var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")
    var subscriptions = Set<AnyCancellable>()
    
    let buttonPressed = PassthroughSubject<AppleFramework, Never>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()

    }
    
    private func bind() {
        
//        Input
        buttonPressed
            .receive(on: RunLoop.main)
            .compactMap { URL(string: $0.urlString) }
            .sink { [unowned self] url in
                let safari = SFSafariViewController(url: url)
                present(safari, animated: true)
            }.store(in: &subscriptions)
        
//        Output
        $framework
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
                self.imageView.image = UIImage(named: framework.imageName)
                self.titleLabel.text = framework.name
                self.descriptionLabel.text = framework.description
            }.store(in: &subscriptions)
    }

    
    @IBAction func learnMorePressed(_ sender: Any) {
        
        buttonPressed.send(framework)
        
    }
    
}
