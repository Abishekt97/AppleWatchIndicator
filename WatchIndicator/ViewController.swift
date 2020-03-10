//
//  ViewController.swift
import UIKit
import Foundation

class ViewController: UIViewController {

    var employees: Employees?
    let static_key = "nscdeing_data_saved"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var request = URLRequest(url: URL(string: "http://dummy.restapiexample.com/api/v1/employees")!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let status = (response as? HTTPURLResponse)?.statusCode, status == 200, let data = data{
                do {
                    guard let dic = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else { return }
                    self.employees = Employees.init(fromDictionary: dic)
                    let archiveData = try NSKeyedArchiver.archivedData(withRootObject: self.employees as Any, requiringSecureCoding: true)
                    UserDefaults.standard.set(archiveData, forKey: self.static_key)
                } catch let error {
                    fatalError(error.localizedDescription)
                }
            }
        }.resume()
    }
    @IBAction func printAction(_ sender: Any) {
        if let data = UserDefaults.standard.data(forKey: static_key){
            do {
                let value = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                print(value as Any)
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
    }
}

class Employees : NSObject, NSCoding, NSSecureCoding{
    static var supportsSecureCoding: Bool{
        return true
    }
    
    var data : [Datum]!
    var status : String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        status = dictionary["status"] as? String
        data = [Datum]()
        if let dataArray = dictionary["data"] as? [[String:Any]]{
            for dic in dataArray{
                let value = Datum(fromDictionary: dic)
                data.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if status != nil{
            dictionary["status"] = status
        }
        if data != nil{
            var dictionaryElements = [[String:Any]]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder){
        data = aDecoder.decodeObject(forKey: "data") as? [Datum]
        status = aDecoder.decodeObject(forKey: "status") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder){
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
class Datum : NSObject, NSCoding, NSSecureCoding{
    static var supportsSecureCoding: Bool{
        return true
    }

    var employeeAge : String!
    var employeeName : String!
    var employeeSalary : String!
    var id : String!
    var profileImage : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        employeeAge = dictionary["employee_age"] as? String
        employeeName = dictionary["employee_name"] as? String
        employeeSalary = dictionary["employee_salary"] as? String
        id = dictionary["id"] as? String
        profileImage = dictionary["profile_image"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if employeeAge != nil{
            dictionary["employee_age"] = employeeAge
        }
        if employeeName != nil{
            dictionary["employee_name"] = employeeName
        }
        if employeeSalary != nil{
            dictionary["employee_salary"] = employeeSalary
        }
        if id != nil{
            dictionary["id"] = id
        }
        if profileImage != nil{
            dictionary["profile_image"] = profileImage
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder){
        employeeAge = aDecoder.decodeObject(forKey: "employee_age") as? String
        employeeName = aDecoder.decodeObject(forKey: "employee_name") as? String
        employeeSalary = aDecoder.decodeObject(forKey: "employee_salary") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        profileImage = aDecoder.decodeObject(forKey: "profile_image") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder){
        if employeeAge != nil{
            aCoder.encode(employeeAge, forKey: "employee_age")
        }
        if employeeName != nil{
            aCoder.encode(employeeName, forKey: "employee_name")
        }
        if employeeSalary != nil{
            aCoder.encode(employeeSalary, forKey: "employee_salary")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if profileImage != nil{
            aCoder.encode(profileImage, forKey: "profile_image")
        }
    }
}
