//
//  CampaignsVC.swift
//  Solid Waste Management
//
//  Created by Guriqbal Singh Amroke on 08.01.26.
//

import UIKit

class CampaignsVC: UIViewController {

    @IBOutlet weak var campaignTblView: UITableView!
    let cellSpacingHeight: CGFloat = 50
    override func viewDidLoad() {
        super.viewDidLoad()

        campaignTblView.register(UINib(nibName: "CampaignTableViewCell", bundle: nil), forCellReuseIdentifier: "CampaignTableViewCell")
    }
    


}

extension CampaignsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CampaignTableViewCell") as! CampaignTableViewCell
        return cell
    }
    
    
}
