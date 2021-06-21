//
//  MenuVC.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import UIKit
import iOS_Slide_Menu

class MenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let sTitle = ["Dashboard", "Send Email", "Message to cash", "Link to website", "Setting"]
    let sIcon = [#imageLiteral(resourceName: "m_dashboard"), #imageLiteral(resourceName: "m_sendemail"), #imageLiteral(resourceName: "m_message"), #imageLiteral(resourceName: "m_link"), #imageLiteral(resourceName: "m_setting")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath)
        let icon = cell.viewWithTag(100) as! UIImageView
        icon.image = sIcon[indexPath.row]
        let label = cell.viewWithTag(101) as! UILabel
        label.text = sTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        SlideNavigationController.sharedInstance()?.toggleLeftMenu()
    }
}
