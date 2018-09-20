import UIKit
import Moya
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var gitModel: GitResponseModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        getGitInfo()
        setupStyle()
     }
    
    func getGitInfo() {
        NetworkLayer().getGitInfo(completion: { gitModel, error in
            guard let gitModel = gitModel, error == nil else {
                return self.showAlert(error: error?.localizedDescription)
            }
            
            self.gitModel = gitModel
            self.repositoryNameLabel.text = "Repo Name: \(gitModel.items?.first?.fullName ?? "Loading...") "
            self.descriptionLabel.text = "Description: \(gitModel.items?.first?.description ?? "Loading...")"
            self.ownerAvatarImageView.kf.setImage(with:
                try? gitModel
                    .items?.first?
                    .owner?
                    .avatarUrl?
                    .asURL() ?? "".asURL())
        })
    }
    
    func showAlert(error: String?) {
        let alert = UIAlertController(title: "Alert",
                                      message: error,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Back",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupStyle() {
        ownerAvatarImageView.contentMode = .scaleAspectFit
    }
    
    @IBAction func getGitInfoAction(_ sender: UIButton) {
        getGitInfo()
    }
}
