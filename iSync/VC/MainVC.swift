//
//  MainVC.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import UIKit
import iOS_Slide_Menu
import ProgressHUD
import Charts

class MainVC: UIViewController {
    @IBOutlet weak var btnPeriod: UIButton!
    @IBOutlet weak var lblTotalSales: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    
    var dashboardData : Dashboard?
    var snapshotData : Snapshot?
    var selectedPeriod = 0
    let sPeriod = ["Day", "Week", "Month", "Year"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(isEmpty(g_token)){
            performSegue(withIdentifier: "segueLogin", sender: nil)
        }else{
            getDashboard()
        }
    }
    @IBAction func onMenu(_ sender: Any) {
        SlideNavigationController.sharedInstance()?.toggleLeftMenu()
    }
    
    func getDashboard(){
        ProgressHUD.show("Loading dashboard...", interaction: false)
        DataAPI.shared.getDashboard { (dashboard) in
            ProgressHUD.showSuccess()
            self.dashboardData = dashboard
            self.refreshDashboard()
            self.getSnapshot()
        } onError: { (error) in
            ProgressHUD.showError(error)
        }
    }
    
    func getSnapshot(){
        ProgressHUD.show("Loading snapshot...", interaction: false)
        DataAPI.shared.getSnapshot { (snapshot) in
            ProgressHUD.showSuccess()
            self.snapshotData = snapshot
            self.refreshSnapshot()
        } onError: { (error) in
            ProgressHUD.showError(error)
        }
    }
    
    @IBAction func onPeriod(_ sender: UIButton) {
        let ac = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        for i in 0..<sPeriod.count{
            let action = UIAlertAction(title: sPeriod[i], style: .default) { (action) in
                self.btnPeriod.setTitle(self.sPeriod[i], for: .normal)
                self.selectedPeriod = i
                self.refreshDashboard()
            }
            ac.addAction(action)
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func refreshDashboard(){
        if let dbData = dashboardData{
            switch selectedPeriod{
            case 0:
                lblTotalSales.text = dbData.sales.daily_sales
                break
            case 1:
                lblTotalSales.text = dbData.sales.last_weekly_sales
                break
            case 2:
                lblTotalSales.text = dbData.sales.monthly_sales
                break
            case 3:
                lblTotalSales.text = dbData.sales.year_to_date_sales
                break
            default:
                break;
            }
        }
    }
    
    func refreshSnapshot(){
        if let snapshot = snapshotData{
            
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
