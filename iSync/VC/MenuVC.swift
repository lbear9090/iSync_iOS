//
//  MenuVC.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import UIKit
import iOS_Slide_Menu
import MessageUI

class MenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    let sTitle = ["Dashboard", "Send Email", "Message to cash", "Link to website", "Setting"]
    let sIcon = [#imageLiteral(resourceName: "m_dashboard"), #imageLiteral(resourceName: "m_sendemail"), #imageLiteral(resourceName: "m_message"), #imageLiteral(resourceName: "m_link"), #imageLiteral(resourceName: "m_setting")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(onNotify(_:)), name: kNLogin, object: nil)
        setUserProfile()
    }
    func setUserProfile(){
        lblName.text = g_user?.name ?? ""
        lblEmail.text = g_user?.email ?? ""
    }

    @objc func onNotify(_ notification:Notification){
        setUserProfile()
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
        switch indexPath.row{
        case 0: //Dashboard
            let vc = storyboard?.instantiateViewController(identifier: "MainVC")
            SlideNavigationController.sharedInstance()?.popToRootAndSwitch(to: vc, withCompletion: nil)
            break
        case 1: //Send Email
            let vc = storyboard?.instantiateViewController(identifier: "SendEmailVC")
            SlideNavigationController.sharedInstance()?.popToRootAndSwitch(to: vc, withCompletion: nil)
            break
        case 2: //Message to Cash
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["cash@advancedvpn.com"])
                mail.setSubject("From iSync")
//                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

                SlideNavigationController.sharedInstance().present(mail, animated: true)
            } else {
                showOkAlert(title: "Error", msg: "Unable open Email")
            }
            SlideNavigationController.sharedInstance()?.toggleLeftMenu()
            break
        case 3: //Link to website
            if let url = URL(string: "https://isync.com/VA/partner-login.php") {
                UIApplication.shared.open(url)
                SlideNavigationController.sharedInstance()?.toggleLeftMenu()
            }
            break
        case 4://Setting
            let vc = storyboard?.instantiateViewController(identifier: "SettingsVC")
            SlideNavigationController.sharedInstance()?.popToRootAndSwitch(to: vc, withCompletion: nil)
            break
        default:
            SlideNavigationController.sharedInstance()?.toggleLeftMenu()
            break
        }
    }
}

extension MenuVC: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
