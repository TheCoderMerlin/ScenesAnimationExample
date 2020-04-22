import Igis
import Scenes

class ReplayButton : RenderableEntity, EntityMouseClickHandler, EntityMouseEnterHandler, EntityMouseLeaveHandler {
    let hitRect : Rect
    let text : Text
    let fill = FillStyle(color:Color(.white))
    var updateCursor = false
    var cursorStyle = CursorStyle(style:.defaultCursor) {
        didSet {
            updateCursor = true
        }
    }

    init(hitRect:Rect) {
        self.hitRect = hitRect

        text = Text(location:hitRect.center, text:"Replay")
        text.alignment = .center
        text.baseline = .middle
        text.font = "42px Calibri"

        super.init(name:"ReplayButton")
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
        canvas.render(fill, text)

        if updateCursor {
            canvas.render(cursorStyle)
            updateCursor = false
        }
    }

    func onEntityMouseClick(globalLocation:Point) {
        guard let foreground = layer as? ForegroundLayer else {
            fatalError("expected ForegroundLayer as owner of PlayButton.")
        }
        foreground.replay()
    }

    func onEntityMouseEnter(globalLocation:Point) {
        cursorStyle = CursorStyle(style:.pointer)
    }

    func onEntityMouseLeave(globalLocation:Point) {
        cursorStyle = CursorStyle(style:.defaultCursor)
    }
}
