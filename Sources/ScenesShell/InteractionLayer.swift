import Igis
import Scenes
import ScenesAnimations

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer {
    var play = PlayButton(boundRect:Rect(topLeft:Point(x:40, y:20), size:Size(width:80, height:80)))
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        
        // We insert our RenderableEntities in the constructor
        insert(entity:play, at:.front)
    }

    func play(_ playing:Bool) {
        playing
          ? animationController.playAll()
          : animationController.pauseAll()
    }
}
