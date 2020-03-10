//
//  InterfaceController.swift

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController{

    @IBOutlet weak var table: WKInterfaceTable!
    
    let value = indicatorType.allCase
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        table.setNumberOfRows(value.count, withRowType: String(describing: RowController.self))
        for (offset, element) in value.enumerated() {
            if let controller = table.rowController(at: offset) as? RowController{
                controller.label.setText(element.description)
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
    }
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        pushController(withName: String(describing: IndicatorInterfaceController.self), context: value[rowIndex])
    }
}

enum indicatorType:CustomDebugStringConvertible, CustomStringConvertible{
    var description: String{
        switch self {
        case .Large_Size(let size):
            return type.Large_Size.rawValue + size.description
        case .Normal_Size(let size):
            return type.Normal_Size.rawValue + size.description
        case .Small_Size(let size):
            return type.Small_Size.rawValue + size.description
        case .XLarge_Size(let size):
            return type.XLarge_Size.rawValue + size.description
        case .XSmall_Size(let size):
            return type.XSmall_Size.rawValue + size.description
        case .XXLarge_Size(let size):
            return type.XXLarge_Size.rawValue + size.description
        case .Small_Indicator:
            return type.Small_Indicator.rawValue
        }
    }
    
    var debugDescription: String{
        switch self {
        case .Large_Size(let size):
            return type.Large_Size.rawValue + size.rawValue
        case .Normal_Size(let size):
            return type.Normal_Size.rawValue + size.rawValue
        case .Small_Size(let size):
            return type.Small_Size.rawValue + size.rawValue
        case .XLarge_Size(let size):
            return type.XLarge_Size.rawValue + size.rawValue
        case .XSmall_Size(let size):
            return type.XSmall_Size.rawValue + size.rawValue
        case .XXLarge_Size(let size):
            return type.XXLarge_Size.rawValue + size.rawValue
        case .Small_Indicator:
            return type.Small_Indicator.rawValue
        }
    }
    var range:NSRange{
        switch self {
        case .Large_Size(let size):
            return size.ranges
        case .Normal_Size(let size):
            return size.ranges
        case .Small_Size(let size):
            return size.ranges
        case .XLarge_Size(let size):
            return size.ranges
        case .XSmall_Size(let size):
            return size.ranges
        case .XXLarge_Size(let size):
            return size.ranges
        case .Small_Indicator:
            return NSMakeRange(0, 39)
        }
    }
    static let allCase: [indicatorType] = [.Small_Indicator, .Large_Size(.size_15), .Large_Size(.size_30), .Normal_Size(.size_15), .Normal_Size(.size_30), .Small_Size(.size_15), .Small_Size(.size_30), .XLarge_Size(.size_15), .XLarge_Size(.size_30), .XSmall_Size(.size_15), .XSmall_Size(.size_30), .XXLarge_Size(.size_15), .XXLarge_Size(.size_30)]
    
    case Large_Size(size)
    case Normal_Size(size)
    case Small_Size(size)
    case XLarge_Size(size)
    case XSmall_Size(size)
    case XXLarge_Size(size)
    case Small_Indicator
    
    enum type:String, CaseIterable{
        
        case Large_Size
        case Normal_Size
        case Small_Size
        case XLarge_Size
        case XSmall_Size
        case XXLarge_Size
        case Small_Indicator
    }
    enum size:String, CustomStringConvertible{
        var description: String{
            switch self {
            case .size_15:
                return " 15"
            case .size_30:
                return " 30"
            }
        }
        
        var ranges:NSRange{
            switch self {
            case .size_15:
                return NSMakeRange(0, 15)
            case .size_30:
                return NSMakeRange(0, 30)
            }
        }
        case size_15 = "Fifteen"
        case size_30 = "Thirty"
    }
}

protocol clickActionDelegate {
    func didSelectButton(_ type:indicatorType, didSelect row:Int)
}
