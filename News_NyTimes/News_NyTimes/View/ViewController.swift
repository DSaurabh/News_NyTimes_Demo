//
//  ViewController.swift
//  News
//
//  Created by Saurabh D on 11/06/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    var newsAPITest:NewsAPI?
    var newsData:MostPopular?
    let newsTableCellID = "NewsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newsCell = UINib.init(nibName: newsTableCellID, bundle: nil)
        newsTableView.register(newsCell, forCellReuseIdentifier: newsTableCellID)
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        
        newsAPITest = NewsAPI()
        self.fetchNewsData()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsData?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = newsTableView.dequeueReusableCell(withIdentifier: newsTableCellID, for: indexPath) as! NewsTableViewCell
        
        cell.titleLabel.text = newsData?.articles?[indexPath.row].title
        cell.articleLabel.text = newsData?.articles?[indexPath.row].abstract
        cell.authorLabel.text = newsData?.articles?[indexPath.row].author
        cell.dateLabel.text = newsData?.articles?[indexPath.row].updatedDate
        
        let path = newsData?.articles?[indexPath.row].media?.first?.mediaMetadata?.first?.url
        if(path != nil){
            newsAPITest?.downLoadImageFromUrl(urlPath: path!, { image in
                DispatchQueue.main.async {
                    if(image != nil){
                        cell.articleImage.image = image
                    }
                }
            })
        }
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC: DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.path = newsData?.articles?[indexPath.row].url
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController{
    
    func fetchNewsData(){
        newsAPITest?.fetchAllMostPopularArticles({(news,newsError) in
            if let newsError = newsError {
                switch newsError{
                case .failed:
                    
                    let alert = UIAlertController(title: "Error", message: "not able to get News", preferredStyle: .alert)
                    let submitButton = UIAlertAction(title: "OK", style: .default) { (action) in
                    }
                    alert.addAction(submitButton)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                case .networkDown:
                    let alert = UIAlertController(title: "Error", message: "Please connect to Internet", preferredStyle: .alert)
                    let submitButton = UIAlertAction(title: "OK", style: .default) { (action) in
                    }
                    alert.addAction(submitButton)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                case .success:
                    self.newsData = news
                    DispatchQueue.main.async {
                        self.newsTableView.reloadData()
                    }
                }
            }
        })
    }
}
