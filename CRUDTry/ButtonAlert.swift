import Foundation
import UIKit
import CoreData
 
class ButtonAlert: UIViewController{
    let userDefault = UserDefaults.standard
    var onEdit : ((_ tableReload : Bool, _ nameText : String, _ ageText : String, _ dob : String ) -> Void)?
    
    func alertAction(controller: UIViewController, value: Int, nameString: String){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "", message: "Enter your details", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (nameTextField) -> Void in
            nameTextField.placeholder = "Enter your name."
        }
        alert.addTextField { (ageTextField) -> Void in
            ageTextField.placeholder = "Enter your age."
        }
        alert.addTextField { (dobTextField) -> Void in
            dobTextField.placeholder = "Enter your date of birth."
        }
        
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (action) -> Void in
            let textField:String = ((alert?.textFields![0])?.text!)!
            let textField1:String = ((alert?.textFields![1])?.text!)!
            let textField2:String = ((alert?.textFields![2])?.text!)!
            
            
            // realm.deleteAll()
            if textField != "" && textField1 != "" && textField2 != ""{
                
                self.onEdit!(true, textField, textField1, textField2)
                
            }else{
                print("add your missing details")
            }
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        // 4. Present the alert.
        controller.present(alert, animated: true, completion: nil)
    }
}
