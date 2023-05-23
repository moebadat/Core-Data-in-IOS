import UIKit
import CoreData
 
class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var people: [NSManagedObject] = []
    var buttonAlertBar = ButtonAlert()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //Display table
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let managedContext =
        appDelegate!.persistentContainer.viewContext
        //2
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Person")
        //3
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //When the add button is presses
    @IBAction func plusButton(_ sender: Any) {
        buttonAlertBar.alertAction(controller: self, value: 0, nameString: "" )
        buttonAlertBar.onEdit = { [weak self] (tableReload: Bool, nameText: String, ageText: String, dob: String ) in
            self?.save(name: nameText, age: ageText, dob: dob)
            self?.tableViewOutlet.reloadData()
        }
        
    }
    
    //function that saves a recor do our core data entity
    func save(name: String, age: String, dob: String) {
        // 1
        let managedContext =
        appDelegate!.persistentContainer.viewContext
        // 2
        let entity =
        NSEntityDescription.entity(forEntityName: "Person",
                                   in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        // 3
        person.setValue(name, forKeyPath: "name")
        person.setValue(age, forKey: "age")
        person.setValue(dob, forKey: "dob")
        // 4
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }}
    
    
//Table view extensions
    extension ViewController: UITableViewDataSource,UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return people.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let person = people[indexPath.row]
            let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            
            //Display what the field is about and the value as found in our core data entity
            cell.nameLabel?.text =  "Name: " + (person.value(forKey: "name") as! String)
            cell.ageLabel?.text = "Age: " + (person.value(forKeyPath: "age") as! String)
            cell.dobLabel?.text = "DOB: " + (person.value(forKeyPath: "dob") as! String)
            cell.tag = indexPath.row
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            //When the user swipes and presses delete, remove the row from our persistece entity
            
            if editingStyle == .delete {
                let managedContext =
                appDelegate!.persistentContainer.viewContext
                
                managedContext.delete(people[indexPath.row])
                
                
                do {
                    try  managedContext.save()
                    
                    people.remove(at: indexPath.row)
                    
                    tableViewOutlet.deleteRows(at: [indexPath], with: .fade)
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
            }
        }
    }
