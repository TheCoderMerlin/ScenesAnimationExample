import Igis
import Scenes

class ForegroundLayer : Layer {
    let playButton = PlayButton(hitRect:Rect(topLeft:Point(x:55, y:25), size:Size(width:50, height:50)))
    let replayButton = ReplayButton(hitRect:Rect(topLeft:Point(x:130, y:25), size:Size(width:100, height:50)))
    
    let linear = MovingRectangle(yPos:0, color:Color(.limegreen), label:"Linear", ease:.linear)
    let quad = MovingRectangle(yPos:1, color:Color(.teal), label:"InOutQuad", ease:.inOutQuad)
    let cubic = MovingRectangle(yPos:2, color:Color(.gold), label:"InOutCubic", ease:.inOutCubic)
    let quart = MovingRectangle(yPos:3, color:Color(.magenta), label:"InOutQuart", ease:.inOutQuart)
    let quint = MovingRectangle(yPos:4, color:Color(.crimson), label:"InOutQuint", ease:.inOutQuint)
    let sine = MovingRectangle(yPos:5, color:Color(.limegreen), label:"InOutSine", ease:.inOutSine)
    let exponential = MovingRectangle(yPos:6, color:Color(.teal), label:"InOutExponential", ease:.inOutExponential)
    let back = MovingRectangle(yPos:7, color:Color(.gold), label:"InOutBack", ease:.inOutBack)
    let circ = MovingRectangle(yPos:8, color:Color(.magenta), label:"InOutCirc", ease:.inOutCirc)
    let bounce = MovingRectangle(yPos:9, color:Color(.crimson), label:"InOutBounce", ease:.inOutBounce)
    let elastic = MovingRectangle(yPos:10, color:Color(.limegreen), label:"InOutElastic", ease:.inOutElastic)

    let entities : [MovingRectangle]

    init() {
        entities = [linear, quad, cubic, quart, quint, sine, exponential, back, circ, bounce, elastic]
        
        super.init(name:"Foreground")

        entities.forEach {
            insert(entity:$0, at:.front)
        }
        insert(entity:playButton, at:.front)
        insert(entity:replayButton, at:.front)
    }

    func replay() {
        animationManager.terminateAll()
        entities.forEach {
            $0.replay()
        }
    }

    func togglePlay(playing:Bool) {
        playing
          ? animationManager.playAll()
          : animationManager.pauseAll()
    }
}
