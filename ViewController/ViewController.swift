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
     }
    
    func getGitInfo() {
        NetworkLayer().getGitInfo(completion: { gitModel, error in
            guard let gitModel = gitModel else {
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
        GeneralAlert.showMessage(title: "Alert", msg: error ?? "Something went wrong")
    }
    
    @IBAction func getGitInfoAction(_ sender: UIButton) {
        getGitInfo()
    }
}

