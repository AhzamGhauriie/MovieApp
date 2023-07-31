//
//  ViewController.swift
//  MovieApp
//
//  Created by Ahzam Ghori on 28/07/2023.
//

import UIKit
import SDWebImage
import Reachability

class HomeView: BaseView {
    
    // MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    
    let networkAdapter : NetworkChangeNotifiable = NetworkChangeClass()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Api Call Binding
    private func ApiCall() {
        viewModel = HomeViewModel(binding: self)
    }
    
    // MARK: Setup Button
    private func setupView(){
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setupTableView()
        ApiCall()
        addGradient()
    }
    
    // MARK: Setup TableView
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
}

// MARK: - Extension UITableView Delegate
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if networkAdapter.isNetworkAvailable {
            return (viewModel as! HomeViewModel).movies.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        cell.movieImg.sd_setShowActivityIndicatorView(true)
        cell.movieImg.sd_setIndicatorStyle(UIActivityIndicatorView.Style.whiteLarge)
        
        if networkAdapter.isNetworkAvailable {
            cell.movieImg.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + (viewModel as! HomeViewModel).movies[indexPath.row].backdropPath! ))
            cell.movieTitle.text = (viewModel as! HomeViewModel).movies[indexPath.row].title
            cell.movieReleaseDate.text = (viewModel as! HomeViewModel).movies[indexPath.row].releaseDate
            cell.movieRating.text = " \((viewModel as! HomeViewModel).movies[indexPath.row].voteAverage ?? 0)/10"
        } else {
            cell.movieImg.sd_setImage(with: URL(string: UserDefaults.standard.object(forKey: "image") as! String ))
            cell.movieTitle.text = UserDefaults.standard.object(forKey: "title") as! String
            cell.movieReleaseDate.text = UserDefaults.standard.object(forKey: "release") as! String
            cell.movieRating.text = "\(UserDefaults.standard.integer(forKey: "vote") as! Int)/10"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if networkAdapter.isNetworkAvailable {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailView") as? DetailView
            vc?.movieId = (viewModel as! HomeViewModel).movies[indexPath.row].id ?? 0
            self.present(vc!, animated: true, completion: nil)
            
            let movieTitle = UserDefaults.standard.set((viewModel as! HomeViewModel).movies[indexPath.row].title, forKey: "title")
            let movieImage =  UserDefaults.standard.set("https://image.tmdb.org/t/p/original" + (viewModel as! HomeViewModel).movies[indexPath.row].backdropPath!, forKey: "image")
            let movieReleaseData = UserDefaults.standard.set((viewModel as! HomeViewModel).movies[indexPath.row].releaseDate, forKey: "release")
            let movieRating = UserDefaults.standard.set((viewModel as! HomeViewModel).movies[indexPath.row].voteAverage, forKey: "vote")
            
        } else {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (viewModel as! HomeViewModel).getNewPageData(itemIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Extension Reload Data
extension HomeView: HomeViewModelDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extension Gradient / Alert
extension HomeView {
    private func addGradient() {
        view.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "Purple")!.cgColor, UIColor(named: "Blue")!.cgColor]
        gradientLayer.locations = [0.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

