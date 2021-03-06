import Igis
import Scenes
import ScenesAnimations

class PlayButton : RenderableEntity, EntityMouseClickHandler, EntityMouseEnterHandler, EntityMouseLeaveHandler {
    let boundRect : Rect
    let fillStyle = FillStyle(color:Color(.white))
    let play : Path
    let pause : [CanvasObject]

    var playing = true
    var mouseTween : Tween<Double>? = nil
    var needToRenderCursor = false
    var cursorStyle = CursorStyle(style:.defaultCursor) {
        didSet {needToRenderCursor = true}
    }

    init(boundRect:Rect) {
        self.boundRect = boundRect

        play = Path(fillMode:.fill)
        play.moveTo(boundRect.topLeft)
        play.lineTo(boundRect.bottomLeft)
        play.lineTo(Point(x:boundRect.right, y:boundRect.centerY))
        play.close()

        let pauseSize = Size(width:boundRect.size.width/3, height:boundRect.size.height)
        pause = [Rectangle(rect:Rect(topLeft:boundRect.topLeft, size:pauseSize), fillMode:.fill),
                 Rectangle(rect:Rect(topRight:boundRect.topRight, size:pauseSize), fillMode:.fill)]

        // Using a meaningful name can be helpful for debugging
        super.init(name:"PlayButton")
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        mouseTween = Tween(from:1.0, to:0.7, duration:0.3, ease:.inQuad) {
            self.setAlpha(alpha:Alpha(alphaValue:$0))
        }
        animationController.register(animation: mouseTween!)
        
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
        return boundRect
    }

    override func render(canvas:Canvas) {
        canvas.render(fillStyle)
        if playing {
            canvas.render(pause)
        } else {
            canvas.render(play)
        }
        
        if needToRenderCursor {
            canvas.render(cursorStyle)
            needToRenderCursor = false
        }
    }

    func onEntityMouseClick(globalLocation:Point) {
        playing = !playing
        
        guard let parent = layer as? InteractionLayer else {
            fatalError("Expected InteractionLayer as layer to PlayButton")
        }
        parent.play(playing)
    }

    func onEntityMouseEnter(globalLocation:Point) {
        cursorStyle = CursorStyle(style:.pointer)
        mouseTween!.direction = .reverse
        mouseTween!.play() 
    }

    func onEntityMouseLeave(globalLocation:Point) {
        cursorStyle = CursorStyle(style:.defaultCursor)
        mouseTween!.direction = .reverse
        mouseTween!.play() 
    }
}
