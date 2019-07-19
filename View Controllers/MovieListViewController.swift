
import UIKit
import SDWebImage

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableViewMovies: UITableView!
    
    var movieList = [MovieItem]()
    var filteredMovies = [MovieItem]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupSearchBar()
        
        tableViewMovies.register(UINib.init(nibName: "MovieItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieItemTableViewCell")
        tableViewMovies.estimatedRowHeight = 100
        tableViewMovies.rowHeight = UITableView.automaticDimension
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        setupSearchBar()
        
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
            self.searchController.hidesNavigationBarDuringPresentation = false
        }
    }
    
}

extension MovieListViewController {
    
    func setupSearchBar(){
        
        self.navigationController?.navigationBar.isHidden = false
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        searchController.searchBar.tintColor = UIColor.white
        
        //make textfield text color white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //get the search bar textfield
        let searchTextField: UITextField? = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        //make textfield search icon color white
        let search = searchTextField?.leftView as! UIImageView
        search.image = search.image?.withRenderingMode(.alwaysTemplate)
        search.tintColor = .white
        
        //make textfield placeholder text color white
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.white]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search Category", attributes: attributeDict)
        }
        
        //check for iOS version for adding search bar
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
            self.searchController.hidesNavigationBarDuringPresentation = false
        } else {
            // Fallback on earlier versions
            navigationItem.titleView = searchController.searchBar
        }
        definesPresentationContext = false
    }
    
    func loadData() {
        
        // set to true if config api returns success response
        // nil otherwise
        let configSuccessFlag = UserDefaults.standard.object(forKey: AppUserDefaults.RecievedConfigSucces) as? Bool
        
        if let recievedConfigSucces = configSuccessFlag {
            if recievedConfigSucces {
                //make popular movie list api call
                getMovieList()
            } else {
                //make config api call
                getConfigurations()
            }
        } else {
            //make config api call
            getConfigurations()
        }
    }
    
    func getMovieList() {
        //get popular movies list
        APICalls().getMovieList { (result) in
            if let response = result {
                //save response to local variable
                self.movieList = response.results
                //reload table to display the fetched results
                self.tableViewMovies.reloadData()
            }
        }
    }
    
    func getConfigurations(fromMovieListController: Bool = false) {
        APICalls().getConfigurations { (result) in
            if let response = result {
                
                
                UserDefaults.standard.set(true, forKey: AppUserDefaults.RecievedConfigSucces)
                
                //save image base url to User Defaults - for image loading
                UserDefaults.standard.set(response.images.secureBaseURL, forKey: AppUserDefaults.ImageBaseURL)
                self.getMovieList()
            }
        }
    }
    
}

extension MovieListViewController: UISearchResultsUpdating {
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = movieList.filter({( movie : MovieItem) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        
        tableViewMovies.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        }
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data: MovieItem
        if isFiltering() {
            data = filteredMovies[indexPath.row]
        } else {
            data = movieList[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemTableViewCell", for: indexPath) as! MovieItemTableViewCell
        
        cell.imgPoster.sd_setImage(with: URL(string: (UserDefaults.standard.object(forKey: AppUserDefaults.ImageBaseURL) as! String + "original" + data.posterPath)), placeholderImage: UIImage.init(named: "poster"))
        cell.lblTitle.text = data.title
        cell.lblReleaseDate.text = "Release Date : " + data.releaseDate
        cell.lblOverview.text = data.overview
        cell.lblAverage.text = "\(data.voteAverage)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


