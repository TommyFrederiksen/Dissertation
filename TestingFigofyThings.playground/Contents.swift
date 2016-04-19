//: Playground - noun: a place where people can play

import UIKit
import Foundation
import SceneKit
import SpriteKit
import XCPlayground


let canvas = UIView(frame: CGRectMake(0, 0, 500, 700))
canvas.backgroundColor = UIColor.darkGrayColor()

XCPlaygroundPage.currentPage.liveView = canvas
class ProgressView: UIView  {
    var layers = [CAShapeLayer]()
    let progressLayer = CAShapeLayer()
    let progressLayer2 = CAShapeLayer()
    let progressLayer3 = CAShapeLayer()
    
    let secondsGradientMask = CAGradientLayer()
    let minutesGradientMask = CAGradientLayer()
    let hoursGradientMask = CAGradientLayer()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createProgressLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createProgressLayer()
    }
    
    
    func animateProgressView(timeLeft: Int) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(1.0)
        animation.toValue = CGFloat(0.0)
        animation.duration = Double(timeLeft*60*60)
        animation.additive = true
        animation.fillMode = kCAFillModeForwards
        animation.fadeOutDuration = CGFloat(5)
        animation.fadeInDuration = CGFloat(5)
        animation.repeatCount = 60
        animation.removedOnCompletion = false
        progressLayer.addAnimation(animation, forKey: "strokeEnd")
        let animation2 = CABasicAnimation(keyPath: "strokeEnd")
        animation2.fromValue = CGFloat(1.0)
        animation2.toValue = CGFloat(0.0)
        animation2.duration = Double(timeLeft*60)
        animation2.additive = true
        animation2.fillMode = kCAFillModeForwards
        animation2.fadeOutDuration = CGFloat(5)
        animation2.fadeInDuration = CGFloat(5)
        animation2.repeatCount = 60
        animation2.removedOnCompletion = false
        progressLayer2.addAnimation(animation2, forKey: "strokeEnd")
        let animation3 = CABasicAnimation(keyPath: "strokeEnd")
        animation3.fromValue = CGFloat(1.0)
        animation3.toValue = CGFloat(0.0)
        animation3.duration = Double(timeLeft)
        animation3.additive = true
        animation3.fillMode = kCAFillModeForwards
        animation3.fadeOutDuration = CGFloat(5)
        animation3.fadeInDuration = CGFloat(5)
        animation3.repeatCount = 60
        animation3.removedOnCompletion = false
        progressLayer3.addAnimation(animation3, forKey: "strokeEnd")
    }


private func createProgressLayer() {
    let startAngle = CGFloat(M_PI_2)
    let endAngle = CGFloat(M_PI * 2 + M_PI_2)
    let centerPoint = CGPointMake(CGRectGetWidth(canvas.frame)/2, CGRectGetHeight(canvas.frame)/2)
    
    let gradientMaskLayer = gradientMask()
    let gradientMaskLayer2 = gradientMask()
    let gradientMaskLayer3 = gradientMask()
    let radius = ((CGRectGetWidth(canvas.frame))/2)-30
    let dashLength = (canvas.frame.width - 30)*CGFloat(M_PI)/12
    
    progressLayer.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
    
    
    progressLayer.backgroundColor = UIColor.clearColor().CGColor
    progressLayer.shadowColor = UIColor.whiteColor().CGColor
    progressLayer.shadowRadius = 3.5
    progressLayer.shadowOpacity = 1
    progressLayer.shadowOffset = CGSizeZero
    progressLayer.allowsEdgeAntialiasing = true
    progressLayer.masksToBounds = false
    progressLayer.fillColor = nil
    progressLayer.strokeColor = UIColor.blackColor().CGColor
    progressLayer.strokeStart = 0.0
    progressLayer.strokeEnd = 0.0
    progressLayer.lineWidth = 10
    progressLayer.lineDashPhase = 0
    progressLayer.lineDashPattern = [dashLength*1]
    progressLayer.lineJoin = kCALineJoinRound

    progressLayer2.path = UIBezierPath(arcCenter: centerPoint, radius: radius-10, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
    
    
    progressLayer2.backgroundColor = UIColor.clearColor().CGColor
    progressLayer2.shadowColor = UIColor.whiteColor().CGColor
    progressLayer2.shadowRadius = 2.5
    progressLayer2.shadowOpacity = 1
    progressLayer2.shadowOffset = CGSizeZero
    progressLayer2.allowsEdgeAntialiasing = true
    progressLayer2.masksToBounds = false
    progressLayer2.fillColor = nil
    progressLayer2.strokeColor = UIColor.whiteColor().CGColor
    progressLayer2.strokeStart = 0.0
    progressLayer2.strokeEnd = 0.0
    progressLayer2.lineWidth = 5
    //progressLayer2.lineDashPattern = [dashLength,0.1]
    progressLayer2.lineJoin = kCALineJoinRound
    
    progressLayer3.path = UIBezierPath(arcCenter: centerPoint, radius: radius-20, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
    
    
    progressLayer3.backgroundColor = UIColor.clearColor().CGColor
    progressLayer3.shadowColor = UIColor.whiteColor().CGColor
    progressLayer3.shadowRadius = 1.5
    progressLayer3.shadowOpacity = 1
    progressLayer3.shadowOffset = CGSizeZero
    progressLayer3.allowsEdgeAntialiasing = true
    progressLayer3.masksToBounds = false
    progressLayer3.fillColor = nil
    progressLayer3.strokeColor = UIColor.whiteColor().CGColor
    progressLayer3.strokeStart = 0.0
    progressLayer3.strokeEnd = 0.0
    progressLayer3.lineWidth = 1.5
    progressLayer3.lineJoin = kCALineJoinRound
    
    gradientMaskLayer.mask = progressLayer
    gradientMaskLayer2.mask = progressLayer2
    gradientMaskLayer3.mask = progressLayer3
    canvas.layer.addSublayer(gradientMaskLayer)
    canvas.layer.addSublayer(gradientMaskLayer2)
    canvas.layer.addSublayer(gradientMaskLayer3)
    
}
    
    private func gradientMask() -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = canvas.bounds
    gradientLayer.locations = [0.0,  1.0]
    
    
    let colorTop: AnyObject = UIColor(red: 234/255.0, green: 70/255.0, blue: 154/255.0, alpha: 1.0).CGColor
    
    let colorMidTM: AnyObject = UIColor(colorLiteralRed: 253/255, green: 75/255, blue: 56/255, alpha: 1.0).CGColor
        
    let colorBottom: AnyObject = UIColor(red: 48/255.0, green: 110/255.0, blue: 255/255.0, alpha: 1.0).CGColor
        
    let colorMid: AnyObject = UIColor(colorLiteralRed: 153.0, green: 255, blue: 255, alpha: 1.0).CGColor
    
    let arrayOfColors: [AnyObject] = [colorTop, colorMidTM]
        gradientLayer.colors = arrayOfColors
    
   
    return gradientLayer

    }
    
}

func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 60))
}


secondsToHoursMinutesSeconds(3600)

var test = ProgressView()

//test.animateProgressView(6)

//http://www.appcoda.com/nsdate/
/* Custom date format Specifiers
EEEE: The full name of the day (e.g. Monday). Use 1-3 letters for the abbreviated representation of the day name.

MMMM: The full name of the month (e.g. October). Use 1-3 letters for the abbreviated representation of the month name.

dd: The day number in the month (e.g. 09 or 15).

yyyy: The year with four digits (e.g. 2015)

HH: The hour representation with two digits (e.g. 08 or 19).

mm: The minutes representation with two digits (e.g. 05 or 54).

ss: The seconds representation with two digits.

zzz: The timezone presented with three letters (e.g. GMT)

GGG: BC or AD.
*/

let currrentDate = NSDate()
let dateFormatter = NSDateFormatter()

//Full Style
dateFormatter.dateStyle = .FullStyle
var convertedDate = dateFormatter.stringFromDate(currrentDate)
//Long Style
dateFormatter.dateStyle = .LongStyle
convertedDate = dateFormatter.stringFromDate(currrentDate)
//Medium Style
dateFormatter.dateStyle = .MediumStyle
convertedDate = dateFormatter.stringFromDate(currrentDate)
//Short Style
dateFormatter.dateStyle = .ShortStyle
convertedDate = dateFormatter.stringFromDate(currrentDate)
dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
convertedDate = dateFormatter.stringFromDate(currrentDate)
dateFormatter.dateFormat = "HH:mm:ss"
convertedDate = dateFormatter.stringFromDate(currrentDate)
//Converting from string to NSDate
var dateAsString = "24-02-2016 15:00"
dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
var newDate = dateFormatter.dateFromString(dateAsString)
//With timezone
dateAsString = "Thu, 08 Oct 2015 09:22:33 GMT"
dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
newDate = dateFormatter.dateFromString(dateAsString)


//FIREBASE TIMESTAMP
let fireFormatter = NSDateFormatter()

fireFormatter.dateFormat = "yy-MM-dd HH:mm:ss zzz"
var fireDateString = "2016-03-11 10:49:24 +0000"
let fireStamp = fireFormatter.dateFromString(fireDateString)
NSDate(timeIntervalSince1970: 1457694636608.0/1000)
NSDate(timeIntervalSince1970: 1457705798501/1000)

let date = NSDate()
let calendar = NSCalendar.currentCalendar()
let components = calendar.components(NSCalendarUnit.Hour, fromDate: date)

let hour = components.hour
let minutes = components.minute
let month = components.month
let year = components.year
let day = components.day

let currentDate = calendar.dateFromComponents(components)

let userCalendar = NSCalendar.currentCalendar()

let competitionDate = NSDateComponents()
competitionDate.year = 2016
competitionDate.month = 3
competitionDate.day = 28
competitionDate.hour = 21
competitionDate.minute = 00
let competitionDay = userCalendar.dateFromComponents(competitionDate)!

competitionDay.timeIntervalSinceDate(currentDate!)

let dayCalendarUnit: NSCalendarUnit = (.Day)
let competitionDayDifference = userCalendar.components(dayCalendarUnit, fromDate: currentDate!, toDate: competitionDay, options: .MatchFirst)



var startDate = NSDate()
var endDate = NSDate(timeIntervalSince1970: 4439053409)

endDate.timeIntervalSinceDate(startDate)


//var view = UIView(frame: CGRectMake(0,0, 100, 50))
//view.center = canvas.center
//view.backgroundColor = UIColor.orangeColor()
//let lbl = UILabel(frame: CGRectMake(0, 0, 100, 50))
//lbl.center = canvas.center
//
//lbl.center = canvas.center
//lbl.text = "Hello"
//lbl.textAlignment = NSTextAlignment.Center
//canvas.addSubview(view)
//canvas.addSubview(lbl)




//let canvas = UIView(frame: CGRectMake(0, 0, 200, 200))
//
//canvas.backgroundColor = UIColor.darkGrayColor()
//
//
//
//let title = UILabel(frame: CGRectMake(50, 50, 100, 20))
//title.text = "MummiSnow"
//title.textColor = UIColor.orangeColor()
//title.textAlignment = NSTextAlignment.Center
//
//
//
//
//let button = UIButton(frame: CGRectMake(50, 100, 100, 50))
//button.backgroundColor = UIColor.whiteColor()
//button.setTitle("My Button", forState: UIControlState.Normal)
//button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
//
//button.layer.cornerRadius = 10
//button.layer.shadowColor = UIColor.blackColor().CGColor
//button.layer.shadowOpacity = 0.1
//button.layer.shadowOffset = CGSizeMake(10,10)
//button.layer.shadowRadius = 10
//
//canvas.addSubview(button)
//canvas.addSubview(title)
//
//var colors = ["red", "green", "blue"]
//colors[2]
//
//var shots = [["title":"Shot 1"],["title": "Shot 2"]]
//
//shots[1]["title"]
//
//
//
//let containerView = UIView(frame: CGRectMake(0.0, 0.0, 375, 667))
//XCPShowView("Container View", view: containerView)
//
//let circle = UIView(frame: CGRectMake(0.0,0.0,50,50))
//circle.backgroundColor = UIColor.orangeColor()
//circle.center = containerView.center
//circle.layer.cornerRadius = 25
//
//containerView.addSubview(circle)
//
//let rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
//rectangle.center = containerView.center
//rectangle.layer.cornerRadius = 5.0
//
//rectangle.backgroundColor = UIColor.whiteColor()
//
//containerView.addSubview(rectangle)
//
//
//let popoverView = UIView(frame: CGRectMake(0.0, 0.0, 40.0, 40.0))
//
//popoverView.backgroundColor = UIColor.whiteColor()
//popoverView.center = CGPointMake(containerView.frame.width/1.5, containerView.frame.height/1.5)
//let scale = CGAffineTransformMakeScale(0.3, 0.3)
//let translate = CGAffineTransformMakeTranslation(50, -50)
//popoverView.transform = CGAffineTransformConcat(scale, translate)
//popoverView.alpha = 0
//containerView.addSubview(popoverView)
//
//
//
//UIView.animateWithDuration(1.3, animations: {
//    
//    let scale = CGAffineTransformMakeScale(1, 1)
//    let translate = CGAffineTransformMakeTranslation(0, 0)
//    popoverView.transform = CGAffineTransformConcat(scale, translate)
//    popoverView.alpha = 1
//    
//})
//
//
//UIView.animateWithDuration(3, animations: { () -> Void in
//    
//    let endingColor = UIColor.yellowColor()
//    circle.backgroundColor = endingColor
//    
//    let scaleTransform = CGAffineTransformMakeScale(5.0, 5.0)
//    
//    circle.transform = scaleTransform
//    
//    let rotationTransform = CGAffineTransformMakeRotation(3.14)
//    
//    rectangle.transform = rotationTransform
//    
//    
//})


// MARK - JSON SERIALIZATION






















