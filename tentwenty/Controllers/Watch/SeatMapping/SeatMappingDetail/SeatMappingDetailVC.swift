//
//  SeatMappingDetailVC.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 10/08/2022.
//

import UIKit

class SeatMappingDetailVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var name:String = ""
    var date:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = name
        lblDate.text = date
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func actionBack(_ sender: Any) {
        
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
}
