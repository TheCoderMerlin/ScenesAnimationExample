import Igis
import Scenes

class MovingRectangle : RenderableEntity {
    let rectangle : Rectangle
    let fill : FillStyle
    let text : Text
    let ease : EasingStyle
    var animation : Animation? = nil

    init(yPos:Int, color:Color, label:String, ease:EasingStyle) {
        rectangle = Rectangle(rect:Rect(topLeft:Point(x:200, y:120+(yPos*40)), size:Size(width:100, height:30)), fillMode:.fill)
        fill = FillStyle(color:color)
        text = Text(location:Point(x:80, y:rectangle.rect.centerY), text:label)
        text.alignment = .center
        text.baseline = .middle
        text.font = "20px Calibri"
        self.ease = ease

        super.init(name:"MovingRectangle")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        let fromPoint = rectangle.rect.topLeft
        let toPoint = Point(x:canvasSize.width - 200, y:rectangle.rect.topLeft.y)
        
        let tween = Tween(from:fromPoint, to:toPoint, duration:3, ease:ease, update: {self.rectangle.rect.topLeft = $0})
        animation = Animation(tween:tween)
        
        animationManager.run(animation:animation!)
    }

    func replay() {
        animationManager.run(animation:animation!)
    }

    override func render(canvas:Canvas) {
        canvas.render(fill, rectangle, text)
    }
}
