//
//  DetailView.swift
//  MovieApp
//
//  Created by Ahzam Ghori on 30/07/2023.
//

import UIKit

class DetailView: BaseView {
    
    // MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    var movieId: Int = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Api Call Binding
    private func ApiCall() {
        viewModel = DetailViewModel(binding: self, movieId: movieId)
    }
    
    // MARK: Setup Button
    private func setupView(){
        setupTableView()
        ApiCall()
        addGradient()
    }
    
    // MARK: Setup TableView
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDetailTableViewCell")
    }
}


// MARK: - Extension UITableView Delegate
extension DetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell") as! MovieDetailTableViewCell
        
        let obj = (self.viewModel as! DetailViewModel).moviesData
        
        cell.movieImage.sd_setShowActivityIndicatorView(true)
        cell.movieImage.sd_setIndicatorStyle(UIActivityIndicatorView.Style.whiteLarge)
        
        if let img = obj.posterPath {
            cell.movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original" + (obj?.posterPath ?? "")))
        }
        
        if let release = obj?.releaseDate {
            cell.movieORelease.text = "•\(obj?.releaseDate ?? "")" + "•\(obj?.productionCompanies?[0].originCountry ?? "")"
        }
        
        cell.movieRating.text =  "\(obj?.voteAverage ?? 0)/10"
        cell.movieTitle.text =  obj?.title
        cell.movieOverview.text = obj?.overview ?? ""
        cell.movieTagLine.text = "\(obj?.tagline ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Extension Reload Data
extension DetailView: DetailViewModelDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extension Gradient / Alert
extension DetailView {
    private func addGradient() {
        view.backgroundColor =  UIColor(named: "Blue")
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "Purple")!.cgColor, UIColor(named: "Blue")!.cgColor]
        gradientLayer.locations = [0.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

