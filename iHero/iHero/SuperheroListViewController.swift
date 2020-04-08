//
//  SuperheroListViewController.swift
//  iHero
//
//  Created by Stephanie Ballard on 4/7/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class SuperheroListViewController: UIViewController {

    private var heroes: [Hero]?
    // table view's source of truth. it is always tracking what the data is doing.
    private lazy var dataSource = makeDataSource()
    private let superHeroController = SuperHeroController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // assign dataSource to the property data source we created above instead of self
        tableView.dataSource = dataSource
        
        superHeroController.downloadSuperHero(name: "Batman") { (heroes) in
            guard let heroes = heroes else { return }
            self.heroes = heroes
            self.update()
        }
    }
}

extension SuperheroListViewController: UITableViewDelegate {
    enum Section {
        case main
    }
    // you put in tableview so it knows which tableview if you have more than one
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, Hero> {
        UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, hero) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)
            cell.textLabel?.text = hero.name
            return cell
        }
    }
    private func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Hero>()
        guard let heroes = heroes else { return }
        snapshot.appendSections([.main])
        snapshot.appendItems(heroes)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}






