//
//  LoginVC.swift
//  iSync
//
//  Created by Lucky on 06/08/21.
//

import UIKit
import ProgressHUD
import Alamofire

class LoginVC: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignin(_ sender: Any) {
        ProgressHUD.show("Login...", interaction: false)
        AuthAPI.shared.login(email: tfEmail.text!, password: tfPW.text!) { (user) in
            
        } onError: { (error) in
            
        }


    }
    
    func login(_ email: String, _ password: String, onSuccess: @escaping(_ result: String) -> Void, onError: @escaping(_ error: String) -> Void){
            
        let url = baseURL + "/login.php"
        var param = Parameters()
        let header = ["Content-Type": "application/json; charset=utf-8",
                      "Accept": "application/json"] as HTTPHeaders
        
        param["email"] = email
        param["password"] = password

        let request = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
        request.validate().responseString { (response) in
            print(response.debugDescription)
            switch response.result{
            case .success:
                let value = response.value ?? ""
                print(value.debugDescription)
                onSuccess("")
                break
            case .failure(let error):
                onError(error.localizedDescription)
                break
            }
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
