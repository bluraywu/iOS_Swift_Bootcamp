import Foundation

var width: Float = 1.5
var height: Float = 2.3

var bucketsOfPaint: Int{
    get{
        Int(ceilf(width * height / 1.5))
    }
    
    set{
        print("\(newValue) buckets will cover \(roundf(Float(newValue) * 1.5)) area")
        newValue
    }
}
bucketsOfPaint = 4
print(bucketsOfPaint)
