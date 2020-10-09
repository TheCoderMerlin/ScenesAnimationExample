import Igis
import Scenes
import ScenesAnimations


/*
 This class is responsible for the foreground Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class ForegroundLayer : Layer {
    let entities = [MovingRectangle(yPos:0, color:Color(.limegreen), label:"Linear", ease:.linear),
                    MovingRectangle(yPos:1, color:Color(.teal), label:"InOutQuad", ease:.inOutQuad),
                    MovingRectangle(yPos:2, color:Color(.gold), label:"InOutCubic", ease:.inOutCubic),
                    MovingRectangle(yPos:3, color:Color(.magenta), label:"InOutQuart", ease:.inOutQuart),
                    MovingRectangle(yPos:4, color:Color(.crimson), label:"InOutQuint", ease:.inOutQuint),
                    MovingRectangle(yPos:5, color:Color(.limegreen), label:"InOutSine", ease:.inOutSine),
                    MovingRectangle(yPos:6, color:Color(.teal), label:"InOutExponential", ease:.inOutExpo),
                    MovingRectangle(yPos:7, color:Color(.gold), label:"InOutBack", ease:.inOutBack),
                    MovingRectangle(yPos:8, color:Color(.magenta), label:"InOutCirc", ease:.inOutCirc),
                    MovingRectangle(yPos:9, color:Color(.crimson), label:"InOutBounce", ease:.inOutBounce),
                    MovingRectangle(yPos:10, color:Color(.limegreen), label:"InOutElastic", ease:.inOutElastic)]

    init() {
        // Using a meaningful name can be helpful for debugging       
        super.init(name:"Foreground")

        // We insert our RenderableEntities in the constructor
        entities.forEach {
            insert(entity:$0, at:.front)
        }
    }
}
