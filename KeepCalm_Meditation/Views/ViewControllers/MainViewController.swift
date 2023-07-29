import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let scrollView : UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Buttons Methods
    
    
    // MARK: - Configure UI

    private func addSubviews() {
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
