//
//  StartViewController.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 18/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        for indexPath in tableView.indexPathsForSelectedRows ?? [] {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GameViewController else {
            return
        }
        
        destination.heroes1 = tableView.indexPathsForSelectedRows?.filter { $0.section == 0 }.map { GameBalance.shared.heros[$0.row] } ?? []
        destination.heroes2 = tableView.indexPathsForSelectedRows?.filter { $0.section == 1 }.map { GameBalance.shared.heros[$0.row] } ?? []
    }
    
    private func updateNavigationItem() {
        let heroes1 = tableView.indexPathsForSelectedRows?.reduce(0, { $0 + ($1.section == 0 ? 1 : 0) }) ?? 0
        let heroes2 = tableView.indexPathsForSelectedRows?.reduce(0, { $0 + ($1.section == 1 ? 1 : 0) }) ?? 0
        
        navigationItem.rightBarButtonItem?.isEnabled = (heroes1 == heroes2) && (heroes1 > 0)
    }
}

extension StartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameBalance.shared.heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell") as? HeroCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = GameBalance.shared.heros[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Player 1" : "Player 2"
    }
}

extension StartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateNavigationItem()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateNavigationItem()
    }
}
