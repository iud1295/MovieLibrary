
import UIKit
import YoutubePlayer_in_WKWebView

class PlayerViewController: UIViewController {

    var key: String = ""
    
    @IBOutlet weak var youtubePlayer: WKYTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        youtubePlayer.delegate = self
        youtubePlayer.load(withVideoId: key)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscape, andRotateTo: UIInterfaceOrientation.landscapeLeft)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
   
}

extension PlayerViewController: WKYTPlayerViewDelegate {
    
    func playerView(_ playerView: WKYTPlayerView, didChangeTo state: WKYTPlayerState) {
        switch state {
        case .ended:
            print("Reached end of video")
            self.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
    
}
