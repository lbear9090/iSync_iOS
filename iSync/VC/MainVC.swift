//
//  MainVC.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import UIKit
import iOS_Slide_Menu
class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!g_bLogin){
            performSegue(withIdentifier: "segueLogin", sender: nil)
        }
    }
    @IBAction func onMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance()?.toggleLeftMenu()
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
