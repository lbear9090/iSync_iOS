//
//  Extensions.swift
//

import Foundation
import UIKit

extension UITableView{
    func getIndexPathOf(subview: UIView) ->IndexPath{
        var view = subview
        while !(view is UITableViewCell) {
            view = view.superview!
        }
        return indexPath(for: view as! UITableViewCell)!
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UICollectionView{
    func getIndexPathOf(subview: UIView) ->IndexPath{
        var view = subview
        while !(view is UICollectionViewCell) {
            view = view.superview!
        }
        return indexPath(for: view as! UICollectionViewCell)!
    }
}

extension UIViewController{
    func showOkAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension String{
    func validateEmail()->Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with:self)
    }
}

func isEmpty(_ str: String?) -> Bool{
    if str == nil || str!.isEmpty{
        return true
    }
    return false
}
