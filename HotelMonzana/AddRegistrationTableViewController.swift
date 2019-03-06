//
//  AddRegisteratiionTableViewController.swift
//  HotelMonzana
//
//  Created by Chinonso Obidike on 3/5/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    
    
    let checkInDatePickerCellIndexPath: IndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath: IndexPath = IndexPath(row: 3, section: 1)
    
    
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var registration: Registration? {
        guard let roomType = roomType else {
            return nil
        }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren: Int = Int(numberOfChildrenStepper.value)
        let hasWifi: Bool = wifiSwitch.isOn
        
        return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAddress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            numberOfAdults: numberOfAdults,
                            NumberOfChildren: numberOfChildren,
                            roomType: roomType,
                            wifi: hasWifi
                            )
    }
    
    var roomType: RoomType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let midnightToday: Date = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   /* @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        let firstName: String = firstNameTextField.text ?? ""
        let lastName: String = lastNameTextField.text ?? ""
        let email: String = emailTextField.text ?? ""
        let checkInDate: Date = checkInDatePicker.date
        let checkOutDate: Date = checkOutDatePicker.date
        let numberOfAdults: Int = Int(numberOfAdultsStepper.value)
        let numberOfChildren: Int = Int(numberOfChildrenStepper.value)
        let hasWifi: Bool = wifiSwitch.isOn
        let roomChoice = roomType?.name ?? "Not Set"
        
        
        print("""
            DONE TAPPED
            first name: \(firstName)
            last name: \(lastName)
            email: \(email)
            check in date: \(checkInDate)
            check out date: \(checkOutDate)
            number of adults: \(numberOfAdults)
            number of children: \(numberOfChildren)
            wifi: \(hasWifi)
            roomType: \(roomChoice)
            """)
        
        //  check in date: \()
       // check out date: \()
    }*/
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
    }
    
    
    
    func updateDateViews(){
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400) //86400 = 60secs * 60mins * 24hrs
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            return isCheckInDatePickerShown ? 216.0 : 0.0
           /* if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }*/
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            return isCheckOutDatePickerShown ? 216.0 : 0.0
            /*if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }*/
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            
            isCheckInDatePickerShown = !isCheckInDatePickerShown
            isCheckOutDatePickerShown = false
           /* if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }*/
            tableView.performBatchUpdates(nil)
            //tableView.beginUpdates()
           // tableView.endUpdates()
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            
            isCheckOutDatePickerShown = !isCheckOutDatePickerShown
            isCheckInDatePickerShown = false
           /* if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }*/
            tableView.performBatchUpdates(nil)
           // tableView.beginUpdates()
           // tableView.endUpdates()
        default:
            break
        }
        
      
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    

    // MARK: - Table view data source

   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SelectRoomType"{
        let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
        destinationViewController?.delegate = self
        destinationViewController?.roomType = roomType
    }
    }

}
