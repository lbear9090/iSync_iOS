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
    @IBOutlet weak var pieChartView: PieChartView!
    
    var dashboardData : Dashboard?
    var snapshotData : Snapshot?
    var selectedPeriod = 0
    let sPeriod = ["Day", "Week", "Month", "Year"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLineChart()
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
            self.getUser()
            self.refreshSnapshot()
        } onError: { (error) in
            ProgressHUD.showError(error)
        }
    }
    
    func getUser(){
        ProgressHUD.show("Loading user information...", interaction: false)
        DataAPI.shared.getUserInfo { (userData) in
            ProgressHUD.showSuccess()
            g_user = userData?.user
            self.getEmailTemplates()
        } onError: { (error) in
            ProgressHUD.showError(error)
        }
    }
    
    func getEmailTemplates(){
        ProgressHUD.show("Loading email templates...", interaction: false)
        DataAPI.shared.getEmailTemplates { (emaildata) in
            ProgressHUD.showSuccess()
            g_emails = emaildata?.data
            
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
            setLineChartData(snapshot: snapshot.snapshot)
        }
    }
    
    func setupLineChart(){
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.rightAxis.enabled = true
        
        chartView.leftAxis.labelTextColor = .white
        chartView.rightAxis.labelTextColor = .white

        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelTextColor = ChartColorTemplates.colorFromString("#ff2B7EFE")
        
        chartView.legend.form = .line
        chartView.legend.enabled = false
    }
    
    func setLineChartData(snapshot: SnapshotData) {
        let values = (0..<snapshot.data.count).map { (i) -> ChartDataEntry in
            let val = Double(snapshot.data[i])
            return ChartDataEntry(x: Double(i), y: val)
        }

        let set1 = LineChartDataSet(entries: values)
        set1.drawIconsEnabled = false
        set1.valueTextColor = ChartColorTemplates.colorFromString("#002B7EFE")
        setupLineChart(set1)

        let gradientColors = [ChartColorTemplates.colorFromString("#002B7EFE").cgColor,
                              ChartColorTemplates.colorFromString("#ff2B7EFE").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set1.fillAlpha = 1
        
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)
        chartView.data = data
        
        chartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: { (index, _) -> String in
            return snapshot.labels[Int(index)]
        })
    }

    private func setupLineChart(_ dataSet: LineChartDataSet) {
//        dataSet.lineDashLengths = [5, 2.5]
//        dataSet.highlightLineDashLengths = [5, 2.5]
        dataSet.setColor(ChartColorTemplates.colorFromString("#ff2B7EFE"))
        dataSet.setCircleColor(ChartColorTemplates.colorFromString("#ff2B7EFE"))
        dataSet.lineWidth = 1
        dataSet.circleRadius = 3
        dataSet.drawCircleHoleEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 9)
//        dataSet.formLineDashLengths = [5, 2.5]
        dataSet.formLineWidth = 1
        dataSet.formSize = 15
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
