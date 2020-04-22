import Igis
import Scenes

class PlayButton : RenderableEntity, EntityMouseClickHandler, EntityMouseEnterHandler, EntityMouseLeaveHandler {
    let hitRect : Rect
    
    let playIcon : Path
    let pauseIcon : [Rectangle]
    let fill = FillStyle(color:Color(.white))

    var playing = true
    var updateCursor = false
    var cursorStyle = CursorStyle(style:.defaultCursor) {
        didSet {
            updateCursor = true
        }
    }

    init(hitRect:Rect) {
        self.hitRect = hitRect
        
        playIcon = Path(fillMode:.fill)
        playIcon.moveTo(hitRect.topLeft)
        playIcon.lineTo(hitRect.bottomLeft)
        playIcon.lineTo(Point(x:hitRect.right, y:hitRect.centerY))
        playIcon.close()

        let rectangleSize = Size(width:hitRect.size.width/3, height:hitRect.size.height)
        let secondRectangleTopLeft = hitRect.topLeft + Point(x:Int(Double(hitRect.size.width) * (2/3)), y:0)
        pauseIcon = [Rectangle(rect:Rect(topLeft:hitRect.topLeft, size:rectangleSize), fillMode:.fill),
                     Rectangle(rect:Rect(topLeft:secondRectangleTopLeft, size:rectangleSize), fillMode:.fill)]
        
        super.init(name:"PlayButton")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        dispatcher.registerEntityMouseClickHandler(handler:self)
        dispatcher.registerEntityMouseEnterHandler(handler:self)
        dispatcher.registerEntityMouseLeaveHandler(handler:self)
    }

    override func teardown() {
        dispatcher.unregisterEntityMouseClickHandler(handler:self)
        dispatcher.unregisterEntityMouseEnterHandler(handler:self)
        dispatcher.unregisterEntityMouseLeaveHandler(handler:self)
    }

    override func boundingRect() -> Rect {
        return hitRect
    }

    override func render(canvas:Canvas) {
        canvas.render(fill)
        playing
          ? canvas.render(pauseIcon)
          : canvas.render(playIcon)

        if updateCursor {
            canvas.render(cursorStyle)
            updateCursor = false
        }
    }

    func onEntityMouseClick(globalLocation:Point) {
        playing = !playing

        guard let foreground = layer as? ForegroundLayer else {
            fatalError("expected ForegroundLayer as owner of PlayButton.")
        }
        foreground.togglePlay(playing:playing)
    }

    func onEntityMouseEnter(globalLocation:Point) {
        cursorStyle = CursorStyle(style:.pointer)
    }

    func onEntityMouseLeave(globalLocation:Point) {
        cursorStyle = CursorStyle(style:.defaultCursor)
    }
}
