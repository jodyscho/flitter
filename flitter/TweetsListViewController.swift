//
//  TweetsListViewController.swift
//  flitter
//

import UIKit
import Swinject


class TweetsListViewController: UITableViewController {
    let CellIdentifier = "TweetTableViewCell"

    var wireframe: TweetsListWireframe!
    var presenter: TweetsListPresenter!

    var viewmodel: [TweetViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchTweets()
    }

    fileprivate func configure() {
        let cf = Container.defaultContainer.resolve(TweetsListConfigurator.self)
        cf?.configure(viewController: self)
    }
    
    @IBAction func signOut(_ sender: Any) {
        presenter.signOut()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as! TweetTableViewCell
        cell.configure(viewModel: viewmodel![indexPath.row])
        return cell
    }
}


extension TweetsListViewController: TweetsListView {

    func displaySignIn() {
        wireframe.displaySignIn()
    }
    
    func clearTweets() {
        viewmodel = nil
        tableView.reloadData()
    }
    
    func appendTweets(tweets: [TweetViewModel]) {
        viewmodel = concatTweets(newTweets: tweets, viewModel: viewmodel)
        
        let indexPaths = buildIndexPaths(tweets: tweets)
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    fileprivate func concatTweets(newTweets: [TweetViewModel], viewModel: [TweetViewModel]?) -> [TweetViewModel] {
        guard let viewModel = viewModel else {
            return newTweets
        }
        var model = newTweets
        model.append(contentsOf: viewModel)
        return model
    }
    
    fileprivate func buildIndexPaths(tweets: [TweetViewModel]) -> [IndexPath] {
        return tweets.enumerated().map { (index, _) in
            IndexPath(row: index, section: 0)
        }
    }
}
