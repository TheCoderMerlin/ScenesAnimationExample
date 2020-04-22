import Scenes
import Igis

class Background : RenderableEntity {
    let rectangle = Rectangle(rect:Rect(), fillMode:.fill)
    let fill = FillStyle(color:Color(red:54, green:57, blue:63))

    init() {
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        rectangle.rect.size = canvasSize
    }

    override func render(canvas:Canvas) {
        canvas.render(fill, rectangle)
    }
}
