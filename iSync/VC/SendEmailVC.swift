//
//  SendEmailVC.swift
//  iSync
//
//  Created by Lucky on 10/05/21.
//

import UIKit
import iOS_Slide_Menu
import ProgressHUD

class SendEmailVC: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnSubject: UIButton!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var tfURL: UITextField!
    
    var nSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateContent()
    }
    
    @IBAction func onSubject(_ sender: UIButton) {
        let ac = UIAlertController(title: "Subjects", message: "", preferredStyle: .actionSheet)
        for i in 0..<(g_emails?.count ?? 0){
            let action = UIAlertAction.init(title: g_emails![i].email_subject, style: .default) { (action) in
                self.nSelected = i
                self.updateContent()
            }
            ac.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        ac.addAction(cancelAction)
    
        ac.popoverPresentationController?.sourceView = sender
                    present(ac, animated: true, completion: nil)
    }
    
    func updateContent(){
        if nSelected < g_emails?.count ?? 0 {
            btnSubject.setTitle(g_emails?[nSelected].email_subject, for: .normal)
            let htmlData = NSString(string: g_emails?[nSelected].email_body ?? "").data(using: String.Encoding.utf8.rawValue)
                
            let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            
            let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
            txtContent.attributedText = attributedString
            txtContent.textColor = .white
        }
    }
    
    @IBAction func onMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance()?.toggleLeftMenu()
    }
    
    @IBAction func onSend(_ sender: Any) {
        if tfEmail.text!.isEmpty {
            showOkAlert(title: "Error", msg: "Please input the email address")
            return
        }
        
        if tfURL.text!.isEmpty {
            showOkAlert(title: "Error", msg: "Please input the website url")
            return
        }
        
        if nSelected < g_emails?.count ?? 0 {
            ProgressHUD.show("Sending Email...", interaction: false)
            DataAPI.shared.sendEmail(email: tfEmail.text!, templateId: g_emails![nSelected].id, website: tfURL.text!, onSuccess: { (result) in
                ProgressHUD.showSuccess(result?.message)
            }, onError: { (error) in
                ProgressHUD.showError(error)
            })
        }
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
