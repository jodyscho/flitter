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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
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
        DispatchQueue.main.async {
            self.wireframe.displaySignIn()
        }
    }
    
    func clearTweets() {
        displayTweets(tweets: nil)
    }
    
    func displayTweets(tweets: [TweetViewModel]?) {
        DispatchQueue.main.async {
            self.viewmodel = tweets
            self.tableView.reloadData()
        }
    }
}
