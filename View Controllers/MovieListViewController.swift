
import UIKit
import SDWebImage

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableViewMovies: UITableView!
    @IBOutlet weak var vwNoData: UIView!
    
    @IBAction func btnRefreshTapped(_ sender: UIButton) {
        loadData()
    }
    
    var movieList = [MovieItem]()
    var pageNo : Int!
    var filteredMovies = [MovieItem]()
    let searchController = UISearchController(searchResultsController: nil)
    private var refreshControlbottom: UIRefreshControl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageNo = 1
        // Do any additional setup after loading the view.
        
        setupSearchBar()
        registerCells()
        addBottomRefreshControl()
        
        handleViews(showTable: true)
        
        loadData()
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
    
    func registerCells() {
        tableViewMovies.register(UINib.init(nibName: "MovieItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieItemTableViewCell")
        tableViewMovies.estimatedRowHeight = 100
        tableViewMovies.rowHeight = UITableView.automaticDimension
    }
    
    func addBottomRefreshControl() {
        refreshControlbottom = UIRefreshControl()
        refreshControlbottom?.triggerVerticalOffset = 30
        refreshControlbottom?.transform = CGAffineTransform(rotationAngle: (180 * .pi) / 180)
        refreshControlbottom?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableViewMovies.bottomRefreshControl = refreshControlbottom
    }
    
    @objc func refresh(){
        
        if(movieList.count > 0){
            refreshControlbottom?.attributedTitle = NSAttributedString(string: "Loading Movies")
            
            pageNo = pageNo + 1
            getMovieList(pageNumber: pageNo)
        }
    }
    
    func loadData() {
        
        // set to true if config api returns success response
        // nil otherwise
        let configSuccessFlag = UserDefaults.standard.object(forKey: AppUserDefaults.RecievedConfigSucces) as? Bool
        
        if let recievedConfigSucces = configSuccessFlag {
            if recievedConfigSucces {
                //make popular movie list api call
                getMovieList(pageNumber: pageNo)
            } else {
                //make config api call
                getConfigurations()
            }
        } else {
            //make config api call
            getConfigurations()
        }
    }
    
    func getConfigurations(fromMovieListController: Bool = false) {
        APICalls().getConfigurations { (result) in
            if let response = result {
                
                UserDefaults.standard.set(true, forKey: AppUserDefaults.RecievedConfigSucces)
                
                //save image base url to User Defaults - for image loading
                UserDefaults.standard.set(response.images.secureBaseURL, forKey: AppUserDefaults.ImageBaseURL)
                self.getMovieList(pageNumber: self.pageNo)
            } else {
                self.handleViews(showTable: false)
            }
        }
    }
    
    func getMovieList(pageNumber: Int) {
        //get popular movies list
        APICalls().getMovieList(pageNo: pageNumber) { (result) in
            
            self.refreshControlbottom?.endRefreshing()
            
            if let response = result {
                
                // Assign Page No
                self.pageNo = response.page
                
                if pageNumber != 1 {
                    //append response to local variable
                    for i in response.results {
                        self.movieList.append(i)
                    }
                } else {
                    //save response to local variable
                    self.movieList = response.results
                }
                
                //delete all movies from db
                //save new data from movieList to db
                self.deleteAndAddNewListToMovieTable(list: self.movieList)
                
                self.checkDataList()
                
            } else {
                //retrieve data list from db
                if self.movieList.count == 0 {
                    print("from db")
                    self.retrieveRecordsFromDB()
                }
                
            }
            
            
        }
    }
    
    func checkDataList() {
        if self.movieList.count > 0 {
            self.handleViews(showTable: true)
            //reload table to display the fetched results
            self.tableViewMovies.reloadData()
        } else {
            self.handleViews(showTable: false)
        }
    }
    
    func handleViews(showTable: Bool) {
        if showTable && self.tableViewMovies.isHidden == true {
            self.tableViewMovies.isHidden = false
            self.vwNoData.isHidden = true
        } else {
            self.tableViewMovies.isHidden = true
            self.vwNoData.isHidden = false
        }
    }
    
    func deleteAndAddNewListToMovieTable(list: [MovieItem]) {
    
        DBManager().deleteAllRecords(entityName: DatabaseTables.Movies) { (result, error) in
            if result {
                
                var dataList = [[String: Any]]()
                for i in list {
                    dataList.append(i.dictionary ?? [:])
                }
                
                DBManager().addRecords(entityName: DatabaseTables.Movies, dataList: dataList, completion: { (result, error) in
                    if result {
                        print("Movies list saved to local db.")
                    }
                })
                
            }
        }
    }
    
    func retrieveRecordsFromDB() {
        DBManager().retrieveRecord(entityName: DatabaseTables.Movies) { (result, error) in
            
            if let response = result {
                var temp = [MovieItem]()
                for i in response {
                    temp.append(MovieItem.init(object: i))
                }
                self.movieList = temp
            } 
            self.checkDataList()
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
        
        cell.imgPoster.sd_setImage(with: getImageUrl(posterPath: data.posterPath), placeholderImage: UIImage.init(named: "poster"))
        cell.lblTitle.text = data.title
        cell.lblReleaseDate.text = "Release Date : " + getFullDate(date: data.releaseDate)
        cell.lblOverview.text = data.overview
        cell.lblAverage.text = "\(data.voteAverage)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if NetworkReachability.isConnectedToNetwork() {
            let data: MovieItem
            if isFiltering() {
                data = filteredMovies[indexPath.row]
            } else {
                data = movieList[indexPath.row]
            }
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
            vc.id = data.id
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showToastMessage(messageString: "No internet connection.")
        }
        
    }
    
}


