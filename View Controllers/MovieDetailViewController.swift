
import UIKit
import SDWebImage
import AVKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblAverage: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblRunTime: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblProductionCompanies: UILabel!

    @IBAction func btnWatchTrailerTapped(_ sender: Any) {
        
        if movieDetailsObj.videos.results.count > 0 {
            let obj = movieDetailsObj.videos.results[0]
            let videoURL = getVideoUrl(object: obj)
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        } else {
            showToastMessage(messageString: "Video Unavailable!")
        }
        
        
    }
    
    var id: Int = 0
    var movieDetailsObj: MovieDetailModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovieDetails()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

extension MovieDetailViewController {
    
    @objc func playerDidFinishPlaying() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getMovieDetails() {
        APICalls().getMovieDetails(id: id) { (result) in
            if let response = result {
                self.movieDetailsObj = response
                self.loadData()
            }
        }
    }
    
    func loadData() {
        
        imgBackground.sd_setImage(with: getImageUrl(posterPath: movieDetailsObj.backdropPath), placeholderImage: UIImage.init(named: "placeholder"))
        imgPoster.sd_setImage(with: getImageUrl(posterPath: movieDetailsObj.posterPath), placeholderImage: UIImage.init(named: "poster"))
        lblAverage.text = "\(movieDetailsObj.voteAverage)"
        lblTitle.text = movieDetailsObj.title
        
        var genre = ""
        for (i,j) in movieDetailsObj.genres.enumerated() {
            genre = genre + j.name + (i == movieDetailsObj.genres.count-1 ? "" : ", ")
        }
        lblGenres.text = genre
        
        lblRunTime.text = "\(movieDetailsObj.runtime) mins"
        lblOverview.text = movieDetailsObj.overview
        
        var productionCompanies = ""
        for (i,j) in movieDetailsObj.productionCompanies.enumerated() {
            productionCompanies = productionCompanies + j.name + (i == movieDetailsObj.productionCompanies.count-1 ? "" : ", ")
        }
        lblProductionCompanies.text = productionCompanies
    }
    
}
