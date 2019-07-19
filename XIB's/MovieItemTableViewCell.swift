
import UIKit

class MovieItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var vwAverage: CircularViewWithShadow!
    @IBOutlet weak var lblAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
