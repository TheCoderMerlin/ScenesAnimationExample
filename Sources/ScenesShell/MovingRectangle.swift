import Igis
import Scenes
import ScenesAnimations

class MovingRectangle : RenderableEntity {
    let fillStyle : FillStyle
    let rectangle : Rectangle
    let text : Text

    var ease : EasingStyle

    init(yPos:Int, color:Color, label:String, ease:EasingStyle) {
        fillStyle = FillStyle(color:color)
        rectangle = Rectangle(rect:Rect(topLeft:Point(x:200, y:120+(yPos*40)), size:Size(width:100, height:30)), fillMode:.fill)
        text = Text(location:Point(x:80, y:rectangle.rect.centerY), text:label)
        text.alignment = .center
        text.baseline = .middle
        text.font = "20px Calibri"
        self.ease = ease

        // Using a meaningful name can be helpful for debugging
        super.init(name:"MovingRectangle")        
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        let fromPoint = rectangle.rect.topLeft
        let toPoint = Point(x:canvasSize.width - 200, y:rectangle.rect.topLeft.y)
        let tween = Tween(from:fromPoint, to:toPoint, duration:3, ease:ease, update: {self.rectangle.rect.topLeft = $0})
        tween.repeatStyle = .forever
        tween.direction = .alternate

        animationController.register(animation: tween)
        tween.play()
    }

    override func render(canvas:Canvas) {
        canvas.render(fillStyle, rectangle, text)
    }
}
