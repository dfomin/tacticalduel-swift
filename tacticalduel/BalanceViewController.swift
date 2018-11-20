//
//  BalanceViewController.swift
//  tacticalduel
//
//  Created by Dmitry Fomin on 20/11/2018.
//  Copyright © 2018 Dmitry Fomin. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
}

extension BalanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameBalance.shared.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell") as? BalanceCell else {
            return UITableViewCell()
        }
        
        let key = GameBalance.shared.keys[indexPath.row].0
        cell.key.text = key
        cell.value.text = "\(GameBalance.shared[key])"
        
        return cell
    }
}
