
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
        if NetworkReachability.isConnectedToNetwork() {
            let arr = movieDetailsObj.videos.results
            if arr.count > 0 && (arr[0].site.lowercased() == "youtube") {
                
                let obj = movieDetailsObj.videos.results[0]
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
                vc.key = obj.key
                //self.present(vc, animated: true, completion: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                showToastMessage(messageString: "Video Unavailable!")
            }
        } else {
            showToastMessage(messageString: "No internet connection.")
        }
    }
    
    var id: Int = 0
    var movieDetailsObj: MovieDetailModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        getMovieDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

extension MovieDetailViewController {
    
    @objc func playerDidFinishPlaying() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getMovieDetails() {
        ActivityIndicator().showIndicator(backgroundColor: nil, message: "Loading", indicatorColor: .white)
        
        APICalls().getMovieDetails(id: id) { (result) in
            ActivityIndicator().hideIndicator()
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
        lblTitle.text = movieDetailsObj.title + " (\(getDateYear(date: movieDetailsObj.releaseDate))) "
        
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
