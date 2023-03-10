//
//  MainController.swift
//  Macrosnap
//
//  Created by Александр Янчик on 12.11.22.
//

import UIKit

class MainController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var container: UIView!
    
    private var controllers = [UIViewController]()
    private var selectedIndex = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        configureControllers()
        insertController()
    }

    @IBAction func mailButtonDidTap(_ sender: Any) {
        let nib = String(describing: ChatsController.self)
        let chatVC = ChatsController(nibName: nib, bundle: nil)
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @IBAction func segmentDidChange(_ sender: Any) {
        guard segment.selectedSegmentIndex < 2 else { return }
        self.selectedIndex = segment.selectedSegmentIndex
        insertController()
    }
    
}

// MARK: -
// MARK: - SetStyle
extension MainController {
    func setStyle() {
        self.topView.layer.cornerRadius = 12
        self.container.layer.cornerRadius = 12
    }
}

// MARK: -
// MARK: - SegmentController
extension MainController {
    
    private func configureControllers() {
        let postVC = PostsTableController(nibName: String(describing: PostsTableController.self), bundle: nil)
        let filmPostVC = PostsTableController(nibName: String(describing: PostsTableController.self), bundle: nil)
        
        postVC.set(postType: .digitalPost)
        filmPostVC.set(postType: .filmPost)
        
        controllers.append(postVC)
        controllers.append(filmPostVC)
    }
    
    private func insertController() {
        let controller = controllers[selectedIndex]
        self.addChild(controller)
        controller.view.frame = self.container.bounds
        self.container.addSubview(controller.view)
        self.didMove(toParent: controller)
    }
    
}
